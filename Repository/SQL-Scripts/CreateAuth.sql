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

INSERT INTO [dbo].[USER_ROLES] VALUES (0, 'Administratör');
INSERT INTO [dbo].[USER_ROLES] VALUES (1, 'Låntagare');
/* Creates a admin account with user name 'admin' and password '1234' */
INSERT INTO ACCOUNT VALUES ('admin', '9p2YxVJQ8bhYItfpYi/fqVkOIDA=', '5v+8NzCtcBefUIjgkkd0DnTd7Gm2XzYp94oUX11zJ7I=', 0, NULL);