USE [AccountManagement]
GO
/****** Object:  StoredProcedure [dbo].[show]    Script Date: 5/6/2024 7:26:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[show](@Acc_Id int)
as
begin

declare @check varchar(20);
--select @check=AccountHeaderTypes.AHT_Name from AccountHeaderTypes where AccountHeaderTypes.AHT_Id=()
declare @balance money=null;
declare @recAmnt money=0;
declare @payAmnt money=null;
declare @InvoiceTallyAmnt money=0;
declare @CreditTallyAmnt money=null;
declare @BillTallyAmnt money=null;

select @recAmnt=sum(Account_Transactions.Amount)
from Account_Transactions
join Account_Headers
on Account_Headers.AH_Id=Account_Transactions.AH_Id and Account_Transactions.AccountId=@Acc_Id and Account_Headers.AHT_Id=1

declare @rAHR_Id int;

select top 1 @rAHR_Id=  AccountManagement.dbo.Account_Header_Transactions.AHR_Id
from AccountManagement.dbo.Account_Header_Transactions
join AccountManagement.dbo.Account_Headers
on Account_Header_Transactions.AH_Id in(select Account_Headers.AH_Id from AccountManagement.dbo.Account_Headers where AccountManagement.dbo.Account_Headers.AccountId=@Acc_Id and Account_Headers.AHT_Id=2)


declare @rAH_Id int;


select @payAmnt= sum(Account_Header_Transactions.Amount)
from AccountManagement.dbo.Account_Header_Transactions
where Account_Header_Transactions.AH_Id in (select distinct( AccountManagement.dbo.Account_Headers.AH_Id)
from AccountManagement.dbo.Account_Headers
join AccountManagement.dbo.Account_Header_Transactions
on Account_Headers.AH_Id=Account_Header_Transactions.AH_Id
join AccountManagement.dbo.Account_Head_Relations
on Account_Header_Transactions.AHR_Id=@rAHR_Id
where Account_Header_Transactions.Amount>0 );

select @recAmnt=-@recAmnt

select @balance=@recAmnt-@payAmnt

if @balance=null
 begin 
    select @recAmnt as 'Invoice',@payAmnt as 'Payment',@balance as 'Amount';
 end

else
  begin
    if @balance>0
   begin 
       select @recAmnt as 'Invoice',@payAmnt as 'Payment',@balance as 'Extra Amount';
   end
 else if @balance<0
   begin
         select @recAmnt as 'Invoice',@payAmnt as 'Payment',@balance as 'Balance';
   end
  
 else if @balance=0
   begin
          select @recAmnt as 'Invoice',@payAmnt as 'Payment','NO DUE PENDING' as 'Balance';
   end
 else 
     begin 
	   select  @recAmnt as 'Invoice',@payAmnt as 'Payment', @balance as 'Balance'
	 end
	 select @InvoiceTallyAmnt+=@balance;
--	 select @InvoiceTallyAmnt as TallyAmnt

	 
  end
end




--===================================================================================================================================================================================================
declare @CredAmnt money ;
declare @RefAmnt money;
declare @CredBal money;

select @CredAmnt=sum( Account_Transactions.Amount)
from AccountManagement.dbo.Account_Transactions
join AccountManagement.dbo.Account_Headers
on Account_Headers.AH_Id=Account_Transactions.AH_Id and Account_Transactions.AccountId=@Acc_Id and Account_Headers.AHT_Id=3;


select top 1 @rAHR_Id=  AccountManagement.dbo.Account_Header_Transactions.AHR_Id
from AccountManagement.dbo.Account_Header_Transactions
join AccountManagement.dbo.Account_Headers
on Account_Header_Transactions.AH_Id in(select Account_Headers.AH_Id from AccountManagement.dbo.Account_Headers where AccountManagement.dbo.Account_Headers.AccountId=@Acc_Id and Account_Headers.AHT_Id=4)


select @RefAmnt= sum(Account_Header_Transactions.Amount)
from AccountManagement.dbo.Account_Header_Transactions
where Account_Header_Transactions.AH_Id in (select distinct( AccountManagement.dbo.Account_Headers.AH_Id)
from AccountManagement.dbo.Account_Headers
join AccountManagement.dbo.Account_Header_Transactions
on Account_Headers.AH_Id=Account_Header_Transactions.AH_Id
join AccountManagement.dbo.Account_Head_Relations
on Account_Header_Transactions.AHR_Id=@rAHR_Id
where Account_Header_Transactions.Amount>0);

 select @CredBal=@RefAmnt-@CredAmnt;





 if @CredBal>0
   begin 
       select @CredAmnt as 'credit',@RefAmnt as 'refund',@CredBal as 'Extra Amount';
   end
 else if @CredBal<0
   begin
         select @CredAmnt as 'credit',@RefAmnt as 'refund',@CredBal as 'Balance';
   end
 else if @CredBal=0
   begin
          
          select @CredAmnt as 'credit',@RefAmnt as 'refund','NO DUE ' as 'Balance';
   end

   if @CredBal is null
    select @CredBal=0;
   select @InvoiceTallyAmnt+=@CredBal
  -- select @InvoiceTallyAmnt as TallyAmnt

   






--===================================================================================================================================================================================================
declare @BillAmnt money;
declare @BillPayAmnt money;
declare @BillBalance money=0;

 select @BillAmnt=sum( Account_Transactions.Amount)
from AccountManagement.dbo.Account_Transactions
join AccountManagement.dbo.Account_Headers
on Account_Headers.AH_Id=Account_Transactions.AH_Id and Account_Transactions.AccountId=@Acc_Id and Account_Headers.AHT_Id=5;


select top 1 @rAHR_Id=  AccountManagement.dbo.Account_Header_Transactions.AHR_Id
from AccountManagement.dbo.Account_Header_Transactions
join AccountManagement.dbo.Account_Headers
on Account_Header_Transactions.AH_Id in(select Account_Headers.AH_Id from AccountManagement.dbo.Account_Headers where AccountManagement.dbo.Account_Headers.AccountId=@Acc_Id and Account_Headers.AHT_Id=5);


select @BillPayAmnt= sum(Account_Header_Transactions.Amount)
from AccountManagement.dbo.Account_Header_Transactions
where Account_Header_Transactions.AH_Id in (select distinct( AccountManagement.dbo.Account_Headers.AH_Id)
from AccountManagement.dbo.Account_Headers
join AccountManagement.dbo.Account_Header_Transactions
on Account_Headers.AH_Id=Account_Header_Transactions.AH_Id
join AccountManagement.dbo.Account_Head_Relations
on Account_Header_Transactions.AHR_Id=@rAHR_Id and Account_Header_Transactions.Amount>0);


 select @BillBalance=@BillPayAmnt-@BillAmnt;



 if @BillBalance>0
   begin 
       select @BillAmnt as 'Bill',@BillPayAmnt as 'Payment',@BillBalance as 'Extra Amount';
   end
 else if @BillBalance<0
   begin
         select @BillAmnt as 'Bill',@BillPayAmnt as 'Payment',@BillBalance as 'Balance';
   end
 else if @BillBalance=0
   begin
          
          select @BillAmnt as 'Bill',@BillPayAmnt as 'Payment','NO DUE ' as 'Balance';
   end


    if @BillBalance is null
    select @BillBalance=0;



     select @InvoiceTallyAmnt+=@BillBalance
	 select @InvoiceTallyAmnt as TallyAmnt



