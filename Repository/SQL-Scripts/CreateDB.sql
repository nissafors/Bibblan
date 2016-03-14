/**************************************************************************************/
/****** Remove tables *****************************************************************/
/****** Object:  Table [dbo].[BORROW]    Script Date: 2014-08-25 15:18:34 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_BORROW_COPY'))
BEGIN
	ALTER TABLE [dbo].[BORROW] DROP CONSTRAINT [FK_BORROW_COPY]
END
GO
IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_BORROW_BORROWER'))
BEGIN
	ALTER TABLE [dbo].[BORROW] DROP CONSTRAINT [FK_BORROW_BORROWER]
END
GO
IF (EXISTS (SELECT * from sysobjects WHERE name = 'BORROW'))
BEGIN
	DROP TABLE [dbo].[BORROW]
END
GO

/****** Object:  Table [dbo].[BORROWER]    Script Date: 2014-08-25 15:20:47 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_BORROWER_CATEGORY'))
BEGIN
	ALTER TABLE [dbo].[BORROWER] DROP CONSTRAINT [FK_BORROWER_CATEGORY]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BORROWER'))
BEGIN
	DROP TABLE [dbo].[BORROWER]
END
GO

/****** Object:  Table [dbo].[CATEGORY]    Script Date: 2014-08-25 15:22:02 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'CATEGORY'))
BEGIN
	DROP TABLE [dbo].[CATEGORY]
END
GO

/****** Object:  Table [dbo].[COPY]    Script Date: 2014-08-25 15:23:52 **********/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_COPY_STATUS'))
BEGIN
	ALTER TABLE [dbo].[COPY] DROP CONSTRAINT [FK_COPY_STATUS]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_COPY_BOOK'))
BEGIN
	ALTER TABLE [dbo].[COPY] DROP CONSTRAINT [FK_COPY_BOOK]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'COPY'))
BEGIN
	DROP TABLE [dbo].[COPY]
END
GO

/****** Object:  Table [dbo].[STATUS]    Script Date: 2014-08-25 15:24:36 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'STATUS'))
BEGIN
	DROP TABLE [dbo].[STATUS]
END
GO

/****** Object:  Table [dbo].[BOOK_AUTHOR]    Script Date: 2014-08-25 15:25:54 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_BOOK_AUTHOR_BOOK'))
BEGIN
	ALTER TABLE [dbo].[BOOK_AUTHOR] DROP CONSTRAINT [FK_BOOK_AUTHOR_BOOK]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_BOOK_AUTHOR_AUTHOR'))
BEGIN
	ALTER TABLE [dbo].[BOOK_AUTHOR] DROP CONSTRAINT [FK_BOOK_AUTHOR_AUTHOR]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BOOK_AUTHOR'))
BEGIN
	DROP TABLE [dbo].[BOOK_AUTHOR]
END
GO

/****** Object:  Table [dbo].[AUTHOR]    Script Date: 2014-08-25 15:27:41 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'AUTHOR'))
BEGIN
	DROP TABLE [dbo].[AUTHOR]
END
GO

/****** Object:  Table [dbo].[BOOK]    Script Date: 2014-08-25 15:28:14 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'FK_BOOK_CLASSIFICATION'))
BEGIN
	ALTER TABLE [dbo].[BOOK] DROP CONSTRAINT [FK_BOOK_CLASSIFICATION]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BOOK'))
BEGIN
	DROP TABLE [dbo].[BOOK]
END
GO

/****** Object:  Table [dbo].[CLASSIFICATION]    Script Date: 2014-08-25 15:28:58 ******/
IF (EXISTS (SELECT * from sysobjects WHERE name = 'CLASSIFICATION'))
BEGIN
	DROP TABLE [dbo].[CLASSIFICATION]
END
GO



/**************************************************************************************/
/****** Create tables *****************************************************************/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[CLASSIFICATION]    Script Date: 2014-08-25 15:28:58 ******/
CREATE TABLE [dbo].[CLASSIFICATION](
	[SignId] [int] NOT NULL,
	[Signum] [nvarchar](50) NULL, (
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_CLASSIFICATION] PRIMARY KEY CLUSTERED 
(
	[SignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[BOOK]    Script Date: 2014-08-25 15:28:14 ******/
CREATE TABLE [dbo].[BOOK](
	[ISBN] [nvarchar](15) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[SignId] [int] NULL,
	[PublicationYear] [nvarchar](10) NULL,
	[PublicationInfo] [nvarchar](255) NULL,
	[Pages] [smallint] NULL,
 CONSTRAINT [PK_BOOK] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'CLASSIFICATION'))
BEGIN
	ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_CLASSIFICATION] FOREIGN KEY([SignId])
	REFERENCES [dbo].[CLASSIFICATION] ([SignId])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_BOOK_CLASSIFICATION due to missing table CLASSIFICATION';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'CLASSIFICATION'))
BEGIN
	ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_BOOK_CLASSIFICATION]
END
GO

/****** Object:  Table [dbo].[AUTHOR]    Script Date: 2014-08-25 15:27:41 ******/
CREATE TABLE [dbo].[AUTHOR](
	[Aid] [int] IDENTITY(100,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[BirthYear] [nvarchar](10) NULL,
 CONSTRAINT [PK_AUTHOR] PRIMARY KEY CLUSTERED 
(
	[Aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[BOOK_AUTHOR]    Script Date: 2014-08-25 15:25:54 ******/
CREATE TABLE [dbo].[BOOK_AUTHOR](
	[ISBN] [nvarchar](15) NOT NULL,
	[Aid] [int] NOT NULL,
 CONSTRAINT [PK_BOOK_AUTHOR] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC,
	[Aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'AUTHOR'))
BEGIN
	ALTER TABLE [dbo].[BOOK_AUTHOR]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_AUTHOR_AUTHOR] FOREIGN KEY([Aid])
	REFERENCES [dbo].[AUTHOR] ([Aid])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_BOOK_AUTHOR_AUTHOR due to missing table AUTHOR';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'AUTHOR'))
BEGIN
	ALTER TABLE [dbo].[BOOK_AUTHOR] CHECK CONSTRAINT [FK_BOOK_AUTHOR_AUTHOR]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BOOK'))
BEGIN
	ALTER TABLE [dbo].[BOOK_AUTHOR]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_AUTHOR_BOOK] FOREIGN KEY([ISBN])
	REFERENCES [dbo].[BOOK] ([ISBN])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_BOOK_AUTHOR_BOOK due to missing table BOOK';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BOOK'))
BEGIN
	ALTER TABLE [dbo].[BOOK_AUTHOR] CHECK CONSTRAINT [FK_BOOK_AUTHOR_BOOK]
END
GO


/****** Object:  Table [dbo].[STATUS]    Script Date: 2014-08-25 15:24:36 ******/
CREATE TABLE [dbo].[STATUS](
	[StatusId] [int] NOT NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_STATUS] PRIMARY KEY CLUSTERED 
(
	[statusid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[COPY]    Script Date: 2014-08-25 15:23:52 ******/
CREATE TABLE [dbo].[COPY](
	[Barcode] [nvarchar](20) NOT NULL,
	[Location] [nvarchar](50) NULL,
	[StatusId] [int] NULL,
	[ISBN] [nvarchar](15) NULL,
	[Library] [nvarchar](50) NULL,
 CONSTRAINT [PK_COPY] PRIMARY KEY CLUSTERED 
(
	[Barcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BOOK'))
BEGIN
	ALTER TABLE [dbo].[COPY]  WITH CHECK ADD  CONSTRAINT [FK_COPY_BOOK] FOREIGN KEY([ISBN])
	REFERENCES [dbo].[BOOK] ([ISBN])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_COPY_BOOK due to missing table BOOK';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BOOK'))
BEGIN
	ALTER TABLE [dbo].[COPY] CHECK CONSTRAINT [FK_COPY_BOOK]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'STATUS'))
BEGIN
	ALTER TABLE [dbo].[COPY]  WITH CHECK ADD  CONSTRAINT [FK_COPY_STATUS] FOREIGN KEY([StatusId])
	REFERENCES [dbo].[STATUS] ([statusid])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_COPY_STATUS due to missing table STATUS';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'STATUS'))
BEGIN
	ALTER TABLE [dbo].[COPY] CHECK CONSTRAINT [FK_COPY_STATUS]
END


/****** Object:  Table [dbo].[CATEGORY]    Script Date: 2014-08-25 15:22:02 ******/

CREATE TABLE [dbo].[CATEGORY](
	[CategoryId] [int] NOT NULL,
	[Category] [nvarchar](50) NULL,
	[Period] [smallint] NULL,
	[PenaltyPerDay] [int] NULL,
 CONSTRAINT [PK_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[BORROWER]    Script Date: 2014-08-25 15:20:47 ******/
CREATE TABLE [dbo].[BORROWER](
	[PersonId] [nvarchar](13) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Adress] [nvarchar](50) NULL,
	[TelNo] [nvarchar](50) NULL,
	[CategoryId] [int] NULL,
 CONSTRAINT [PK_BORROWER] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'CATEGORY'))
BEGIN
	ALTER TABLE [dbo].[BORROWER]  WITH CHECK ADD  CONSTRAINT [FK_BORROWER_CATEGORY] FOREIGN KEY([CategoryId])
	REFERENCES [dbo].[CATEGORY] ([CategoryId])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_BORROWER_CATEGORY due to missing table CATEGORY';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'CATEGORY'))
BEGIN
	ALTER TABLE [dbo].[BORROWER] CHECK CONSTRAINT [FK_BORROWER_CATEGORY]
END
GO

/****** Object:  Table [dbo].[BORROW]    Create Script Date: 2014-08-25 15:18:34 ******/
CREATE TABLE [dbo].[BORROW](
	[Barcode] [nvarchar](20) NOT NULL,
	[PersonId] [nvarchar](13) NOT NULL,
	[BorrowDate] [datetime] NOT NULL,
	[ToBeReturnedDate] [datetime] NULL,
	[ReturnDate] [datetime] NULL,
 CONSTRAINT [PK_BORROW] PRIMARY KEY CLUSTERED 
(
	[Barcode] ASC,
	[PersonId] ASC,
	[BorrowDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BORROWER'))
BEGIN
	ALTER TABLE [dbo].[BORROW]  WITH CHECK ADD  CONSTRAINT [FK_BORROW_BORROWER] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[BORROWER] ([PersonId])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_BORROW_BORROWER due to missing table BORROWER';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'BORROWER'))
BEGIN
	ALTER TABLE [dbo].[BORROW] CHECK CONSTRAINT [FK_BORROW_BORROWER]
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'COPY'))
BEGIN
	ALTER TABLE [dbo].[BORROW]  WITH CHECK ADD  CONSTRAINT [FK_BORROW_COPY] FOREIGN KEY([Barcode])
	REFERENCES [dbo].[COPY] ([Barcode])
END
ELSE
BEGIN
	PRINT 'Could not create foreign key FK_BORROW_COPY due to missing table COPY';
END
GO

IF (EXISTS (SELECT * from sysobjects WHERE name = 'COPY'))
BEGIN
	ALTER TABLE [dbo].[BORROW] CHECK CONSTRAINT [FK_BORROW_COPY]
END
GO


