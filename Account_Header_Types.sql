USE [AccountManagement]
GO

/****** Object:  Table [dbo].[AccountHeaderTypes]    Script Date: 6/18/2024 8:34:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AccountHeaderTypes](
	[AHT_Id] [int] IDENTITY(1,1) NOT NULL,
	[AHT_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AccountHeaderTypes] PRIMARY KEY CLUSTERED 
(
	[AHT_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
