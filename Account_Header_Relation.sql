USE [AccountManagement]
GO

/****** Object:  Table [dbo].[Account_Head_Relations]    Script Date: 6/18/2024 8:04:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Account_Head_Relations](
	[AHR_Id] [int] IDENTITY(1,1) NOT NULL,
	[AHR_Date] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_Account_Head_Relations] PRIMARY KEY CLUSTERED 
(
	[AHR_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

