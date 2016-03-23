USE [BibblanDatabase];
GO

CREATE TABLE [dbo].[USER_ROLES](
	[RoleId] [int] NOT NULL PRIMARY KEY,
	[Role] [nvarchar](50) NOT NULL
);
GO

CREATE TABLE [dbo].[ACCOUNT](
	[Username] [nvarchar](50) NOT NULL PRIMARY KEY,
	[Password] [nvarchar](50) NOT NULL,
	[Salt] [nvarchar](50) NOT NULL,
	[RoleId] [int] NOT NULL FOREIGN KEY REFERENCES [dbo].[USER_ROLES]([RoleId]),
	[BorrowerId] [nvarchar](13) NULL FOREIGN KEY REFERENCES [dbo].[BORROWER]([PersonId])
);
GO

INSERT INTO [dbo].[USER_ROLES] VALUES (0, 'Administratör')
INSERT INTO [dbo].[USER_ROLES] VALUES (1, 'Låntagare')
