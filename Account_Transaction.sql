USE [AccountManagement]
GO

/****** Object:  Table [dbo].[Account_Transactions]    Script Date: 6/18/2024 8:29:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Account_Transactions](
	[AccTrans_Id] [int] IDENTITY(1,1) NOT NULL,
	[AH_Id] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[Amount] [money] NOT NULL,
 CONSTRAINT [PK_Account_Transaction] PRIMARY KEY CLUSTERED 
(
	[AccTrans_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Account_Transactions]  WITH CHECK ADD  CONSTRAINT [fk_AC_AccountId] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([AccountId])
GO

ALTER TABLE [dbo].[Account_Transactions] CHECK CONSTRAINT [fk_AC_AccountId]
GO

ALTER TABLE [dbo].[Account_Transactions]  WITH CHECK ADD  CONSTRAINT [fk_AH_AH_Id] FOREIGN KEY([AH_Id])
REFERENCES [dbo].[Account_Headers] ([AH_Id])
GO

ALTER TABLE [dbo].[Account_Transactions] CHECK CONSTRAINT [fk_AH_AH_Id]
GO

