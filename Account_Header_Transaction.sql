USE [AccountManagement]
GO

/****** Object:  Table [dbo].[Account_Header_Transactions]    Script Date: 6/18/2024 8:10:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Account_Header_Transactions](
	[AH_Trans_Id] [int] IDENTITY(1,1) NOT NULL,
	[AH_Id] [int] NOT NULL,
	[AHR_Id] [int] NOT NULL,
	[Amount] [money] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Account_Header_Transactions]  WITH CHECK ADD  CONSTRAINT [fk_AH_AH_Id2] FOREIGN KEY([AH_Id])
REFERENCES [dbo].[Account_Headers] ([AH_Id])
GO

ALTER TABLE [dbo].[Account_Header_Transactions] CHECK CONSTRAINT [fk_AH_AH_Id2]
GO

ALTER TABLE [dbo].[Account_Header_Transactions]  WITH CHECK ADD  CONSTRAINT [fk_AHR_AHR_Id] FOREIGN KEY([AHR_Id])
REFERENCES [dbo].[Account_Head_Relations] ([AHR_Id])
GO

ALTER TABLE [dbo].[Account_Header_Transactions] CHECK CONSTRAINT [fk_AHR_AHR_Id]
GO

