USE [AccountManagement]
GO

/****** Object:  StoredProcedure [dbo].[AccountCases]    Script Date: 6/18/2024 7:59:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[AccountCases](@AccId int=0,@AHT_Id int,@Amount money,@AH_Id int=0)
as
begin 
declare @rAHT_Name  varchar(50);
select @rAHT_Name =AccountHeaderTypes.AHT_Name from AccountHeaderTypes where AccountHeaderTypes.AHT_Id=@AHT_Id

if (@rAHT_Name='Invoice' AND @AccId NOT IN(4,5))
begin
insert into Account_Headers(AccountId,AHT_Id) values (@AccId,@AHT_Id)
declare @rAH_Id int;
select @rAH_Id=Account_Headers.AH_Id from Account_Headers where Account_Headers.AccountId=@AccId

declare @i int=2;
while @i>0
   begin
    if @i=2
	  begin
           declare @raccId int;
	       select @raccId=Accounts.AccountId from Accounts where Accounts.AccountName='Receivable';
           insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@raccId,@Amount);
      end
	                                  
    else if @i=1
	 begin
	      insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@AccId,-(@Amount));
	 end

	set @i=@i-1;
	if @i=0 break;
   end;
	insert into Account_Head_Relations(AHR_Date) values(GETUTCDATE());
	declare @rAHR_Id int;
	select top 1 @rAHR_Id= Account_Head_Relations.AHR_Id from Account_Head_Relations  order by Account_Head_Relations.AHR_Id desc
	insert into Account_Header_Transactions(AH_Id,AHR_Id)values(@rAH_Id,@rAHR_Id);
end;

/*================================================================================================================================*/
 
else if @rAHT_Name='Payment'

begin
 declare @exAHT_ID int;
	select @exAHT_ID= Account_Headers.AHT_Id from Account_Headers where Account_Headers.AH_Id=@AH_Id;

 if @exAHT_ID=5
 begin
    declare @rAcc_Id int=6;
    insert into Account_Headers (AccountId,AHT_Id) values (@rAcc_Id,@AHT_Id);
	select @rAH_Id=Account_Headers.AH_Id from Account_Headers where Account_Headers.AccountId=@rAcc_Id;


  declare @n int=2;
while @n>0
   begin
    if @n=2
	  begin
	       select @raccId=Accounts.AccountId from Accounts where Accounts.AccountName='Payable';
           insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@raccId,@Amount);
      end

    else if @n=1
	 begin
	      insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,6,-(@Amount));
	 end

	set @n=@n-1;
	if @n=0 break;
   end;
     insert into Account_Head_Relations(AHR_Date) values(GETUTCDATE());
    select @rAHR_Id= Account_Header_Transactions.AHR_Id from Account_Header_Transactions where AH_Id=@AH_Id;
    insert into Account_Header_Transactions(AH_Id,AHR_Id,Amount)values(@rAH_Id,@rAHR_Id,@Amount);
 end;
/*=================================================================================================================*/
 else if  @exAHT_ID!=5
 begin
   
   select @rAcc_Id= Account_Headers.AccountId from Account_Headers where Account_Headers.AH_Id=@AH_Id;
  insert into Account_Headers (AccountId,AHT_Id) values (@rAcc_Id,@AHT_Id);
   
   select @rAH_Id=Account_Headers.AH_Id from Account_Headers where Account_Headers.AccountId=@rAcc_Id;

  declare @j int=2;
while @j>0
   begin
    if @j=2
	  begin
	       select @raccId=Accounts.AccountId from Accounts where Accounts.AccountName='Receivable';
           insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@raccId,-(@Amount));
      end

    else if @j=1
	 begin
	      insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,6,@Amount);
	 end

	set @j=@j-1;
	if @j=0 break;
   end;
    select @rAHR_Id= Account_Header_Transactions.AHR_Id from Account_Header_Transactions where AH_Id=@AH_Id;
  insert into Account_Header_Transactions(AH_Id,AHR_Id,Amount)values(@rAH_Id,@rAHR_Id,@Amount);
 
 end;
end;

/*=========================================================================================================================================*/

else if( @rAHT_Name='Credit' AND @AccId NOT IN(4,5) )
begin
insert into Account_Headers (AccountId,AHT_Id) values (@AccId,@AHT_Id)
select @rAH_Id=Account_Headers.AH_Id from Account_Headers where Account_Headers.AccountId=@AccId

declare @k int=2;
while @k>0
   begin
    if @k=2
	  begin
      
	       select @raccId=Accounts.AccountId from Accounts where Accounts.AccountName='Receivable';
           insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@raccId,-(@Amount));
      end

    else if @k=1
	 begin
	      insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@AccId,@Amount);
	 end

	set @k=@k-1;
	if @k=0 break;
   end;
	insert into Account_Head_Relations(AHR_Date) values(GETUTCDATE());
	
	select top 1 @rAHR_Id= Account_Head_Relations.AHR_Id from Account_Head_Relations  order by Account_Head_Relations.AHR_Id desc;
	insert into Account_Header_Transactions(AH_Id,AHR_Id)values(@rAH_Id,@rAHR_Id);
end;
/*=============================================================================================================================================*/
else if @rAHT_Name='Refund'
 begin
  
  declare @enter int;
  select @enter=Account_Headers.AHT_Id from Account_Headers where Account_Headers.AH_Id=@AH_Id;

  if @enter=3
     begin
         select @rAcc_Id= Account_Headers.AccountId from Account_Headers where Account_Headers.AH_Id=@AH_Id;
         insert into Account_Headers (AccountId,AHT_Id) values (@rAcc_Id,@AHT_Id);
   
         select @rAH_Id=Account_Headers.AH_Id from Account_Headers where Account_Headers.AccountId=@rAcc_Id;

         declare @l int=2;
         while @l>0
            begin
             if @l=2
	            begin
	              select @raccId=Accounts.AccountId from Accounts where Accounts.AccountName='Receivable';
                  insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@raccId,@Amount);
                end

             else if @l=1
	            begin
	              insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,6,-(@Amount));
	            end

	         set @l=@l-1;
	         if @l=0 break;
            end;
         select @rAHR_Id= Account_Header_Transactions.AHR_Id from Account_Header_Transactions where AH_Id=@AH_Id;
         insert into Account_Header_Transactions(AH_Id,AHR_Id,Amount)values(@rAH_Id,@rAHR_Id,@Amount);
     end;

 else
    begin
	  print 'Enter a valid AH_Id';
	end

 end;
 
 /*================================================================================================================================*/
else if( @rAHT_Name='Bill'  AND @AccId NOT IN(4,5))
begin
insert into Account_Headers (AccountId,AHT_Id) values (@AccId,@AHT_Id)
select @rAH_Id=Account_Headers.AH_Id from Account_Headers where Account_Headers.AccountId=@AccId

declare @m int=2;
while @m>0
   begin
    if @m=2
	  begin
	       select @raccId=Accounts.AccountId from Accounts where Accounts.AccountName='Payable';
           insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@raccId,-(@Amount));
      end

    else if @m=1
	 begin
	      insert into Account_Transactions(AH_Id,AccountId,Amount)values(@rAH_Id,@AccId,@Amount);
	 end

	set @m=@m-1;
	if @m=0 break;
   end;
	insert into Account_Head_Relations(AHR_Date) values(GETUTCDATE());
	select top 1 @rAHR_Id= Account_Head_Relations.AHR_Id from Account_Head_Relations  order by Account_Head_Relations.AHR_Id desc;
	insert into Account_Header_Transactions(AH_Id,AHR_Id)values(@rAH_Id,@rAHR_Id);
end;

/*=====================================================================================================================*/
/*else if @rAHT_Name='BillPayment'
 begin
    declare @exAHT_ID int;
	select @exAHT_ID= Account_Header.AHT_Id from Account_Header where Account_Header.AH_Id=@AH_Id;

 if @exAHT_ID=5
    begin
   
	end;
 else
	begin 
	  print 'NO PAYMENT PENDING'
	end
 end;*/
    
 end;
GO

