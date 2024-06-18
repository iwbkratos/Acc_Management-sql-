USE [AccountManagement]
GO

/****** Object:  Table [dbo].[Account_Headers]    Script Date: 6/18/2024 8:14:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Account_Headers](
	[AH_Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[AHT_Id] [int] NOT NULL,
 CONSTRAINT [PK_Account_Header] PRIMARY KEY CLUSTERED 
(
	[AH_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Account_Headers]  WITH CHECK ADD  CONSTRAINT [fk_AH_AccountId] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([AccountId])
GO

ALTER TABLE [dbo].[Account_Headers] CHECK CONSTRAINT [fk_AH_AccountId]
GO

ALTER TABLE [dbo].[Account_Headers]  WITH CHECK ADD  CONSTRAINT [fk_AHT_AHT_Id] FOREIGN KEY([AHT_Id])
REFERENCES [dbo].[AccountHeaderTypes] ([AHT_Id])
GO

ALTER TABLE [dbo].[Account_Headers] CHECK CONSTRAINT [fk_AHT_AHT_Id]
GO

