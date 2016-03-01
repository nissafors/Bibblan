use master;
go

/* Exchange BibblanDatabase with your database name, 5 places*/ 
IF (EXISTS (SELECT * from sysdatabases WHERE name = 'BibblanDatabase'))
BEGIN
	DROP DATABASE BibblanDatabase
END
GO

IF (NOT EXISTS (SELECT * from sysdatabases WHERE name = 'BibblanDatabase'))
BEGIN
	CREATE DATABASE BibblanDatabase
END
GO

USE [BibblanDatabase]
GO

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
	[Signum] [nvarchar](50) NULL,
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
	[CatergoryId] [int] NOT NULL,
	[Category] [nvarchar](50) NULL,
	[Period] [smallint] NULL,
	[PenaltyPerDay] [int] NULL,
 CONSTRAINT [PK_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[CatergoryId] ASC
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
	REFERENCES [dbo].[CATEGORY] ([CatergoryId])
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


/* Exchange DBxxxx with the name of your database! 1 place */
use BibblanDatabase
go

DELETE FROM BORROW;
GO
DELETE FROM BORROWER;
GO
DELETE FROM CATEGORY;
GO
DELETE FROM COPY;
GO
DELETE FROM STATUS;
GO
DELETE FROM BOOK_AUTHOR;
GO
DELETE FROM AUTHOR;
GO
DELETE FROM BOOK;
GO
DELETE FROM CLASSIFICATION;
GO


/********** Table CATEGORY *****************************************************************************/

INSERT INTO [dbo].[CATEGORY]
           ([CatergoryId]
           ,[Category]
           ,[Period]
           ,[Penaltyperday])
     VALUES
           (1,'Extern',30,5);
GO
INSERT INTO [dbo].[CATEGORY]
           ([CatergoryId]
           ,[Category]
           ,[Period]
           ,[Penaltyperday])
     VALUES
           (2,'Personal',40,0);
GO
INSERT INTO [dbo].[CATEGORY]
           ([CatergoryId]
           ,[Category]
           ,[Period]
           ,[Penaltyperday])
     VALUES
           (3,'Studerande',60,1);
GO
INSERT INTO [dbo].[CATEGORY]
           ([CatergoryId]
           ,[Category]
           ,[Period]
           ,[Penaltyperday])
     VALUES
           (4,'Barn',30,0);
GO

/********** Table BORROWER *************************************************************************************/

INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19111111-1111','Elvansson','Elvan','Älvv.11 11111 Älvstad','0111-111111',1);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19121212-1212','Tolvansson','Tolvan','Tolvv.12 12121 Tolvstad','0121-121212',2);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19380528-7646','Ekeberg','Susanne','Slottsg. 10 Sturlestad','0646-782508',3);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19450202-0202','Axelsson','Per','Prostv. 7','0202-549102',2);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19630328-2267','Andersson','Anders','Kolanderst.5 12312 Kolstad','0762-823036',1);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19651024-7595','Wiberg','Dan','Ekelund 7','0957-420156',3);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19790229-1116','Karlsson','Jan','Fyrisv. 1 91213 Uppsala','0611-922097',1);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('19920227-5468','Rissner','Helena','Järpev. 32 55555 Järplanda','0864-722029',4);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('20010101-3454','Gunnarsson','Peter','Stureg. 4 43254','0454-101010',4);
GO
INSERT INTO [dbo].[BORROWER]
           ([PersonId]
           ,[LastName]
           ,[FirstName]
           ,[Address]
           ,[Telno]
           ,[CategoryId])
     VALUES
           ('20050301-1221','Potter','Harry','Jarlsg. 2 12354',NULL,4);
GO

/********** Table STATUS ***************************************************************************************/

INSERT INTO [dbo].[STATUS]
           ([statusid]
           ,[status])
     VALUES
           (1,'Available');
GO
INSERT INTO [dbo].[STATUS]
           ([statusid]
           ,[status])
     VALUES
           (2,'Borrowed');
GO
INSERT INTO [dbo].[STATUS]
           ([statusid]
           ,[status])
     VALUES
           (3,'Ordered from bookstore');
GO
INSERT INTO [dbo].[STATUS]
           ([statusid]
           ,[status])
     VALUES
           (4,'Reference copy');
GO
INSERT INTO [dbo].[STATUS]
           ([statusid]
           ,[status])
     VALUES
           (5,'Unknown');
GO

/********** Table CLASSIFICATION *******************************************************************************/

INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (1,'Pub',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (2,'Puba',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (3,'Pubb',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (4,'Pubbz Ada',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (5,'Pubbz AktiveX',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (6,'Pubbz BASIC',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (7,'Pubbz C',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (8,'Pubbz C++',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (9,'Pubbz COBOL',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (10,'Pubbz Delphi',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (11,'Pubbz Eiffel',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (12,'Pubbz FORTRAN',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (13,'Pubbz Java',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (14,'Pubbz JavaScript',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (15,'Pubbz PASCAL',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (16,'Pubbz PROLOG',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (17,'Pubbz QBASIC',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (18,'Pubbz VBScript',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (19,'Pubbz Visual Basic',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (20,'Pubbz VisualBASIC',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (21,'Pubbz VisualC',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (22,'Pubd',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (23,'Pubdb',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (24,'Pubdbz CP M',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (25,'Pubdbz DOS',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (26,'Pubdbz Linux',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (27,'Pubdbz MS DOS',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (28,'Pubdbz OS 12',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (29,'Pubdbz UNIX',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (30,'Pubdbz Windows 95',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (31,'Pubdbz Windows295',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (32,'Pubdbz WindowsNT',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (33,'Pubdh',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (34,'Pubdhz Access',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (35,'Pubdhz dBASE',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (36,'Pubdhz Filemaker',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (37,'Pubdhz LotusNotes',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (38,'Pubdhz Paradox',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (39,'Pubdi',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (40,'Pubdk',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (41,'Pubds',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (42,'Pubds REF',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (43,'Pubdz CorelDRAW',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (44,'Pubdz Excel',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (45,'Pubdz Framework',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (46,'Pubdz Frontpage',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (47,'Pubdz Illustrator',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (48,'Pubdz JavaScript',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (49,'Pubdz LATEX',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (50,'Pubdz Mathematica',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (51,'Pubdz MicrosoftOffice',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (52,'Pubdz Office',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (53,'Pubdz Photoshop',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (54,'Pubdz PowerPoint',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (55,'Pubdz QuarkXPress',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (56,'Pubdz Schedule',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (57,'Pubdz SPSS',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (58,'Pubdz TEX',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (59,'Pubdz Windows',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (60,'Pubdz WindowsNT',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (61,'Pubdz Word',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (62,'Pubdz WordforWindows',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (63,'Pubdz WordPerfect',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (64,'Pubdz Works',NULL);
GO
INSERT INTO [dbo].[CLASSIFICATION]
           ([SignId]
           ,[Signum]
           ,[Description])
     VALUES
           (65,'Pubdz13 D StudioMAX',NULL);
GO


/********** Table AUTHOR ***************************************************************************************/

INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Abnous','Razmik','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Adams','Joel','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Adamsson','Stig','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Adamsson','Stig','1937');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Adsjö','Johanna','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Agerberg','AnnaBie','1958');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Agerberg','Jonas','1923');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ahlandsberg','Thomas','1958');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ahlsén','Matts','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ahrenberg','Lars','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ahuja','Vijay','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Alger','Jeff','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Alschuler','Liora','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Amo','William C','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Andersson','StenGöran','1940');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Andréasson','Karin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Andréasson','Torbjörn','1957');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Andrén','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Angermeyer','John','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Appelgren','Mats','1963');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Arnold','William R','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Aronsson','Martin','1963');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Aronsson','Rolf','1942');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Aronsson','Åke','1940');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Arvidsson','Stefan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Arvidsson','Stefan','1967');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ask','Rikard','1966');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Asker','Bengt','1928');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Avdic','Anders','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bach','Maurice J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Back','Lennart','1935');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bacon','Jean','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bellovin','Steven M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Berard','Edward V','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Berild','Stig','1944');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Berndtson','Ola','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Berneryd','Jan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Berson','Alex','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bertino','Elisa','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bevemyr','Johan','1966');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bilting','Ulf','1955');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Björk','LarsEric','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Björklöf','Dag','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Blom','Katarina','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Booch','Grady','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Borgström','Håkan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bosrup','Lars','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bouzeghoub','Mokrane','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bowen','Kenneth A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bowie','John S','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Brandinger','Rune','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Brobst','Stephen','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Brooks','Frederick Phillips Jr','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Brookshear','J Glenn','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Brown','Donald P','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bryan','Martin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Burger','Jeff','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Burgess','Mark S','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Burholt','Olle','1963');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Burman','Sven','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Burman','Sven','1943');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Burns','Diane','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Burns','Pat J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Butzen','Fred','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bäckman','Bo','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Bäckman','Bo','1945');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cabanski','Thomas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Calvert','Charles','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cannan','Stephen John','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cattell','R G G','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('CDE','Documentation group','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ceri','Stefano','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cerny','E','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Checkland','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cheswick','William R','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Christiansson','Benneth','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cilwa','Paul S','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Clark','Robert G','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Clausen','Rolf','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cohn','Mike','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Conger','Jim','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Corbett','Mary','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Courtois','Todd','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cox','Brad J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Crawford','Sharon','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Crown','James','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Cumberbatch','John','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dahl','Serafim','1945');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dahlberg','Åsa','1968');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dahlbom','Bo','1949');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Daler','Torgeir','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Daly','Patrick W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Danesh','Arman','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dataföreningen','i Sverige','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dataföreningen','i Sverige DF','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('December','John','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Deitel','Harvey M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Denning','Peter J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dent','Arthur','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Derr','Kurt W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dexner','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dopping','Olle','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Dumas','Arthur','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Duntemann','Jeff','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Duran','Joe','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Eckel','Bruce','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ek','Jesper','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ek','Jesper','1964');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ekdahl','Bo','1951');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ekinge','Anna','1973');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Eklund','Per','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Eklund','Sven','1962');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Eklund','Sven','1964');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ekman','Rasmus','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ekman','Rasmus','1965');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ekman','Torgil','1935');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ekonomiska','EFI','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ellis','Margaret A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Elmasri','Ramez','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Engholm','Ahrvid','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Entsminger','Gary','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Erikson','Sven','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Eriksson','HansErik','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Eriksson','HansErik','1961');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Espinoza','Fredrik','1970');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Essler','Ulf','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Eykholt','Edward M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ezzell','Ben','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fahlgren','Martin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fenstermacher','Kurt D','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fernlund','Hans','1969');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Finn','Thomas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fischer','Charles N','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fisher','Maydene','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fites','Philip','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Forbes','Dorothy','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ford','Warwick','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Forsell','Anders','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fosselius','Lennart','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fowler','Martin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Foxall','James D','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fraternali','Piero','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Freese','Jan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Freese','Jan','1933');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Friedman','Daniel P','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Friedman','Frank L','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Futatsugi','Kokichi','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fåk','Viiveke','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Fägersten','Håkan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Galvin','Peter Baer','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gangemi','G T Sr','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gardarin','Georges','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Garlan','David','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gille','Ingebjörn','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Glader','Mats','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gloor','Peter A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Glynn','Jerry','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Golding','Mordy','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Goldkuhl','Göran','1949');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Goncalves','Marcus','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gratte','Ingvar','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gratte','Ingvar','1943');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gray','Theodore','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Greve','Jan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Groff','James R','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gullers','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gunnarsson','Stefan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gurewich','Nathan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gurewich','Ori','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Gustafsson','NilsErik','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Göransson','Håkan','1968');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Göranzon','Bo','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Göthe','Mats','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hamilton','Graham','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hamrin','Klas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Harold','Elliotte Rusty','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Harrington','Jan L','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Haynes','Christopher T','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hedemalm','Gunvald','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Heileman','Gregory L','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Heinckiens','Peter M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hergert','Douglas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hilley','Valda','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hipson','Peter D','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hohmann','Luke','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holm','Per','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holm','Per','1950');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holmberg','Sten','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holmberg','Sten','1943');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holmlid','Kolenda Magnus','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holsberg','Peter J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holub','Allen I','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holwell','Sue','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Holzner','Steven','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Horch','John W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Horstmann','Cay S','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hosbond','Petersen Niels','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Howe','Harold','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hughes','Larry J Jr','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hugo','Ian','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hutson','Mary','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hägerfors','Ann','1953');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hägglund','Sture','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Hällström','Mattias','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Infosec',NULL,'0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ingvarsson','Magnus','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Institutet','för verkstadsteknisk forskning IVF','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('International','logic programming conference 2 Uppsala','1984');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Isaksson','GullBritt','1959');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('IT','Nova','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Jaeger','Kevin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Janlert','LarsErik','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Janning','Marianne','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Japanese','Kanazawa','1996');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Jennings','Roger','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Johannesson','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Johansson','LarsÅke','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Johansson','Mikael','1962');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Johnston','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Jones','Capers','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Jonsson','Erland','1946');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Jonsson','Örjan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Karlsson','Conny','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Karlsson','Tord','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Katzeff','Cecilia','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kauler','Barry','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kernighan','Brian W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Keyes','Jessica','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Khoshafian','Setrag','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kirakowski','Jurek','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Klauer','Patricia','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kloos','C Delgado','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kläppe','Björn','1937');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Knuth','Donald E','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Knuth','Donald Ervin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Koffman','Elliot B','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kogan','Michael S','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kool','Peeter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kopka','Helmut','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Korobkin','Carl Philip','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kratz','Martin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Krokstäde','Per','1969');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kruglinski','David','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Krysander','Christian','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kungl','Tekniska högskolan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Kynning','Bengt','1936');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Köhler','Hans','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lafore','Robert','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Landmér','Karin','1958');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Langefors','Börje','1915');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Larman','Craig','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Larson','James A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Leavens','Alex','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('LeBlanc','Richard J Jr','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('LeBlond','Geoffrey T','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ledell','Göran','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Leestma','Sanford','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lennartzon','Per','1972');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lepp','Jaan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lepp','Jaan','1964');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Leringe','Örjan','1944');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Leventhal','Lance A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lewis','John','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lilja','Ingrid','1944');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lindberg','Björn','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Linde','Mats','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lindgren','Christer','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lindgren','Thomas','1966');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lindqvist','Kjell','1943');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lindström','Lena','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lingefjärd','Thomas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Link','Wolfgang','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Linköpings','universitet Institutionen för datavetenskap','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lippman','Stanley B','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lockheed','Martin Advanced Concepts Center','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Loftus','William','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lundahl','Tommy','1960');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lundberg','Kent','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lundell','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lundgren','Jan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lundin','Bengt','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lundin','Joakim','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lundmark','MarieTherese','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Lunell','Hans','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Långbacka','Thomas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Löwgren','Jonas','1964');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Magee','Stan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Maguire','Stephen A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Maier','David','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Maier','Mark W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Malm','Kristina','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Manchester','Business School','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mann','Anthony T','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Martin','Robert Cecil','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Martino','Lorenzo','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mathiassen','Lars','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mattison','Robert M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mattsson','Hans','1945');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('McConnell','Steve','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('McGhee','Colin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Medri','Gian','1933');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Medri','Margareta','1933');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mellström','Jill','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Meyer','Bertrand','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Meyers','Scott','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Miano','John','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Microsoft','Corporation','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mille','Hubert','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Miller','Howard Wilbert','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Minoli','Daniel','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Moll','Hans','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Moll','Hans','1947');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Monk','Andrew','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Montelius','Johan','1963');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Morrison','Ron','1946');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mueck','Thomas A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mumford','Enid','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Månsson','Erik','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Mäkilä','Kalle','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Möller','Anders','1952');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Navathe','Shamkant B','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nelson','Mark','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nicholson','John R','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nilsson','Anders','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nilsson','Anders G','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nilsson','Catherine','1966');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nilsson','Nils','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nilsson','Rolf','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nordin','Roger','1965');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Norell','Alexandra','1966');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Norén','KarlJohan','1971');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Norrby','Johannes','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Norton','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Novak','Marketa','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nyhoff','Larry','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nyquist','Erik','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Nyström','Dan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Näslund','Strömberg Britt','1952');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Objective','Ideas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('OBrien','Timothy M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ohlin','Mats','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ohlsson','Lennart','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('OLeary','Linda I','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('OLeary','Timothy J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Olofsson','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Olofsson','Svante','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Olovsson','Tomas','1959');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Olsson','Ingmar','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Olsson','Ingmar','1940');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Olsson','PerOlov','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Omander','Martin','1970');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Otten','Gerard M A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ottersten','Ingrid','1958');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Oxborrow','Elizabeth','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Palme','Jacob','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Paulk','Mark C','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pelagatti','Giuseppe','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Penker','Magnus','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Penttinen','Paula','1970');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pereira','Fernando C N','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Persson','Annika','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Petersen','Richard','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Peterson','Anders','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Peterson','James Lyle','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Peterson','Mark','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Petzold','Charles','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pfleeger','Charles P','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Platt','David S','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Poe','Vidette','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pogge','Steven J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pohl','Ira','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Polaschek','Martin L','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Poore','Jesse H','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Porta','Horacio','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Prague','Cary N','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pratt','Terrence W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pree','Wolfgang','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Pärletun','Lars Göran','1946');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Qwerin','Nils','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rantzer','Martin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rathbone','Andy','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rational','Software Corporation','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rechtin','Eberhardt','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Reese','George','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Reeve','Simon','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Reifer','Donald J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rejler','Olle','1936');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Riksrevisionsverket','RRV Avdelningen för effektivitetsrevision','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ritchey','Tim','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ritchie','Dennis M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Roberts','D W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Roberts','Eric','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Roberts','Graham','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Robinson','Hugh','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rogers','Jean B','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rosengren','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Roupé','Eric','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rubenking','Neil J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rudh','Gillis','1946');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rundqvist','Kjell','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Russell','Deborah','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rydén','Nils','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Rydergren','Olof','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Röstlinger','Annie','1950');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sand','Torbjörn','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sandberg','Dan','1965');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sandmark','Lars','1942');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sauer','Charles H','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Savitch','Walter J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Schildt','Herbert','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Schmucker','Kurt J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Schoonover','Michael A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Schultz','Thomas W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Scott','Kendall','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sedgewick','Robert','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sengupta','Saumyendra','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sessions','Roger','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Shaffer','Clifford A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Shaw','Mary','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sheldon','Thomas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Shieber','Stuart M','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Shneiderman','Ben','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sigfried','Stefan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Signore','Robert','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Silberschatz','Abraham','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Simon','Errol','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Simon','Richard J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Simpson','Alan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Singh','Harry','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Skansholm','Jan','1949');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Smith','Stephen J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Solomon','Christine','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sommerville','Ian','1951');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Song','William','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Soukup','Ron','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Spri',NULL,'0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Standardiseringen','i Sverige','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Statskontoret',NULL,'0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stbner','Bo','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stegman','Michael O','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Steinholtz','Bo','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stenström','Per','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stephens','Ryan K','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stewart','Robert W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stitt','Martin','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stoll','Clifford','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stolterman','Erik','1956');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stroustrup','Bjarne','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Stubbs','Daniel F','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sturmark','Christer','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sturmark','Christer','1964');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sundblad','Sten','1939');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sundgren','Bo','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Swan','Tom','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Svenska','institutet för systemutveckling','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Svenska','ITföretagens organisation SITO','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Svenska','kommunförbundet','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Svensson','Anna','1971');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Svensson','Per','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sveriges','mekanförbund','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Sveriges','verkstadsindustrier VI','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Särimner',NULL,'0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Söderbergh','Gunnar','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Söderström','Herbert','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Söderström','Peter','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Söderström','Rune','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Tanler','Rick','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Taylor','David A','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Tenevall','Thomas','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Termén','Olle','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Texel','Putnam P','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Thollander','Leif','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('ThorfveEverett','Yvonne','1956');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Thornell','Sören','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Trammell','Carmen J','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Tripp','Leonard L','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Tärnlund','StenÅke','1941');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Uhl','J Jerry','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Waern','Annika','1960');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Waite','Group','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Walden','Kim','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Valduriez','Patrick','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Walker','D W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Wand','Mitchell','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Wang','Wallace','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Vardi','Ilan','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Warren','David S','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Veanes','Margus','1966');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Webre','Neil W','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Weinberg','Paul N','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Weinz','Ragnar','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Weinz','Ragnar','1939');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Weinz','Ulla Britt','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Weinz','Ulla Britt','1943');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Weinz','UllaBritt','1943');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Welander','Tommy','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Venit','Sharyn','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Werner','Magnus','1968');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Vernick','Michael','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Westerberg','Per','1949');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('White','Geoffrey E','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Wiberg','Torbjörn','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Wiktorin','Lars','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Wiktorsson','Kristina','1967');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Williams','Charles B','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Wilson','Leslie B','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Winder','Russel','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Wingstedt','Ulf','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Ydenius','Bengt','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Zaks','Rodnay','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Zaratian','Beck','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Öhlund','StenErik','0');
GO
INSERT INTO [dbo].[AUTHOR]
           ([LastName]
           ,[FirstName]
           ,[BirthYear])
     VALUES
           ('Östlund','Björn','0');
GO

/********** Table BOOK ****************************************************************************************/

INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[PublicationInfo]
           ,[Pages])
     VALUES
           ('0070062722','Data warehousing data mining and OLAP',33,NULL,NULL,742);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0070067317','Prolog and expert systems',16,NULL,NULL,534);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0070246459','Firewalls complete',41,NULL,NULL,783);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0070278938','Data structures algorithms and objectoriented programming',3,NULL,NULL,534);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0070328137','Applied software measurement : assuring productivity and quality',3,NULL,NULL,276);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('007034678X','Datacasting : how to stream databases over the Internet',33,NULL,NULL,786);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0070410348','Data warehousing : strategies technologies and techniques',22,NULL,NULL,706);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0070425930','Analyzing outsourcing : reengineering information and communication systems',1,NULL,NULL,262);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0070490678','Paradox 5 0 for Windows',38,NULL,NULL,756);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0077076648','SQL : the standard handbook : based on the new SQL standard ISO 9075119E',33,NULL,NULL,714);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0077090764','Distributed information systems : from client server to distributed multimedia',33,NULL,NULL,750);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0078815037','dBASE IV : the complete reference',35,NULL,NULL,771);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0078816912','art of C : elegant programming solutions',7,NULL,NULL,304);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0078818095','C inside out',8,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0078824613','Linux : the complete reference',26,NULL,NULL,786);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0079310125','6800 assembly language programming',3,NULL,NULL,202);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0120455951','Network and Internet security',41,NULL,NULL,729);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0120499428','C for real programmers',7,NULL,NULL,786);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('012326426X','SQL clearly explained',33,NULL,NULL,803);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('013020207X','Windows assembly language systems programming : object oriented lowlevel systems programming in assembly language for Windows 3 x',3,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0131214845','Windows 95 and NT : Win32 API from scratch : a programmers workbook',31,NULL,NULL,747);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0131829572','Software architecture : perspectives on an emerging discipline',3,NULL,NULL,752);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0132038374','Designing objectoriented C applications using the Booch method',3,NULL,NULL,588);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0132366134','Journey of the software professional : a sociology of software development',3,NULL,NULL,707);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0132888955','Essays on objectoriented software engineering Vol 1',2,NULL,NULL,745);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0133374866','Security in computing',41,NULL,NULL,727);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('013591793X','Data warehousing : concepts technologies implementations and management',33,NULL,NULL,742);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0136301045','Class construction in C C : objectoriented programming fundamentals',3,NULL,NULL,505);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0136542867','Pascal : a new introduction to computer science',3,NULL,NULL,771);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0136609112','Practical introduction to data structures and algorithm analysis : Java edition',1,NULL,NULL,786);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0136630146','Advanced assembly language',3,NULL,NULL,222);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0136632041','C programming',8,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('013727405X','Use cases combined with BOOCH OMT UML : process and products',2,NULL,NULL,778);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0137488807','Applying UML and patterns : an introduction to objectoriented analysis and design',3,NULL,NULL,729);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0137538154','C and the 8051 : programming for multitasking',3,NULL,NULL,477);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0137696396','Building a data warehouse for decision support',33,NULL,NULL,742);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0137758006','C : an introduction to computing',7,NULL,NULL,758);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0137994532','Computer communications security : principles standards protocols and techniques',41,NULL,NULL,804);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0138504547','Java networking and communications',13,NULL,NULL,717);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01416778','Concurrent systems : an integrated approach to operatic systems database and distributed systems',23,NULL,NULL,528);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01529890','Computational recreations in Mathematica',50,NULL,NULL,522);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01539926','C programming language',8,NULL,NULL,479);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01548488','C primer',8,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01548895','design of OS 2',28,NULL,NULL,587);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01572702','Calculus Mathematica : basics tutorials and literacy sheets Part 1',50,NULL,NULL,481);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01572710','Calculus Mathematica : give it a try Part 1',50,NULL,NULL,481);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('01572869','Designing the user interface : strategies for effective humancomputer interaction',1,NULL,NULL,588);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201038099','art of computer programming Vol 1 Fundamental algorithms',3,NULL,NULL,305);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201060892','Operating system concepts',23,NULL,NULL,775);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201064677','Prolog primer',16,NULL,NULL,794);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201103931','Objectoriented programming : an evolutionary approach',3,NULL,NULL,760);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201134470','Computers typesetting',58,NULL,NULL,647);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201142279','Software development with Ada',4,NULL,NULL,535);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201184834','Comparative programming languages',3,NULL,NULL,516);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201309947','Object technology : a managers guide',3,NULL,NULL,764);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201309955','JDBC database access with Java : a tutorial and annotated reference',33,NULL,NULL,737);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201310139','Building scalable database applications : objectoriented design architectures and implementations',33,NULL,NULL,786);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201325632','UML distilled : applying the standard object modeling language',3,NULL,NULL,548);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201403692','Designing database applications with objects and rules : the ideas methodology',33,NULL,NULL,535);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201403943','SGML and HTML explained',22,NULL,NULL,620);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201422948','Design patterns for objectoriented software development',3,NULL,NULL,587);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('020142777X','guide to LATEX2epsilon : document preparation for beginners and advanced users',49,NULL,NULL,647);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('020148952X','Common desktop environment 1 0 : advanced users and system administrators guide',29,NULL,NULL,512);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201510596','Algorithms in C',8,NULL,NULL,244);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201514591','annotated C reference manual',8,NULL,NULL,267);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201526492','Problem solving abstraction and design using C',8,NULL,NULL,513);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201530678','Computers under attack : intruders worms and viruses',41,NULL,NULL,773);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201542625','Operating system concepts',23,NULL,NULL,783);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201543303','design and evolution of C',8,NULL,NULL,586);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201545411','Programming abstractions in C : a second course in computer science',7,NULL,NULL,771);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201546647','Capability maturity model : guidelines for improving the software process',3,NULL,NULL,786);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201563452','GNU emacs : UNIX text editing and programming',3,NULL,NULL,971);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201571641','Java software solutions : foundations of program design',13,NULL,NULL,713);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201581124','desktop multimedia bible',1,NULL,NULL,589);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201608286','Advanced Visual Basic : a developers guide',19,NULL,NULL,223);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201608669','Borland C 3 0 programming',8,NULL,NULL,430);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201624397','Objectoriented database systems : concepts and architectures',33,NULL,NULL,535);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201835959','mythical manmonth : essays on software engineering',2,NULL,NULL,747);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201847477','Mainstream videoconferencing : a developers guide to distance multimedia',40,NULL,NULL,535);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0201889544','C programming language',7,NULL,NULL,753);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0243','Grunderna i Pascal',15,NULL,NULL,987);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0262560674','Essentials of programming languages',3,NULL,NULL,749);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('028038','Dödliga data : berättelser från ett riskabelt Sverige',41,NULL,NULL,637);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('03808285','Designing human systems for new technology : the ETHICS method',2,NULL,NULL,588);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0412788101','Hardware description languages and their applications : specification modelling verification and synthesis of microelectronic systems',2,NULL,NULL,535);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0442008635','Effective computer user documentation',1,NULL,NULL,654);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0471147672','Practical objectoriented development in C and Java',7,NULL,NULL,727);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0471180041','Intranet data warehouse : tools and techniques for building an intranetenabled data warehouse',33,NULL,NULL,743);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0471191612','UML toolkit',3,NULL,NULL,727);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0471518026','Object orientation : concepts languages databases user interfaces',3,NULL,NULL,535);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0471578533','Practical software reuse',1,NULL,NULL,742);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0471958204','Information systems and information systems : making sense of the field',1,NULL,NULL,788);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0471976555','Developing Java software',13,NULL,NULL,713);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('05309039','Computer science : an overview',1,NULL,NULL,523);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('05321667','Crafting a compiler with C',22,NULL,NULL,541);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0672300974','Windows programmers guide to resources',3,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0672301687','Advanced C',7,NULL,NULL,222);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0672305941','Programming WinSock',3,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0672310228','Charlie Calverts Borland CBuilder',7,NULL,NULL,788);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0672310481','Visual Basic 5 : developers guide',20,NULL,NULL,803);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0734','Försvarets utveckling av informationssystem : en effektivitetsgranskning',2,NULL,NULL,945);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0792399714','Index data structures in objectoriented databases',33,NULL,NULL,792);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0805306005','Software engineering with Ada',4,NULL,NULL,758);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('080530911X','C for Pascal programmers',8,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0805322795','Succeeding with the Booch and OMT methods : a practical approach',2,NULL,NULL,618);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0805366814','Computing with logic : logic programming with Prolog',16,NULL,NULL,536);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('080537440X','Problem solving with C : the object of programming',8,NULL,NULL,513);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0810465655','Objectoriented programming for the Macintosh',3,NULL,NULL,756);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('081763911X','Elements of hypermedia design : techniques for navigation and visualization in cyberspace',39,NULL,NULL,782);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0830643273','C database applications with the Paradox engine',8,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0849378362','art of systems architecting',2,NULL,NULL,824);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('086238091X','Databases and database systems : concepts and issues',33,NULL,NULL,536);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0890068658','Practical guide to software quality management',1,NULL,NULL,511);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0890069190','Guide to software engineering standards and specifications',3,NULL,NULL,752);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0937073172','Prolog and naturallanguage analysis',16,NULL,NULL,771);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('0954','Fortsätt med Pascal : Turbo 5 5',15,NULL,NULL,858);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1410','Fortran : exempelsamling',12,NULL,NULL,858);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1453','Fundamentals of database systems',33,NULL,NULL,897);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1555581951','Reengineering legacy software systems',1,NULL,NULL,783);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1556153953','Programming Windows 3 1 : the microsoft guide to writing applications for Windows 3 1',3,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1556156502','Debugging the development process : practical strategies for stying focused hitting ship dates and building solid teams',3,NULL,NULL,576);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1556159005','Rapid development : taming wild software schedules',3,NULL,NULL,733);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1558284915','Linux database',26,NULL,NULL,644);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1558285342','QuarkXPress 4 0 handbook',55,NULL,NULL,794);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1558512160','data compression book : featuring fast efficient data compression techniques in C',3,NULL,NULL,558);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1558512969','Developing Paradox databases : an objectbased approach',38,NULL,NULL,595);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1558514880','Web scripting with VBScript',18,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1558515658','Advanced Visual C 5',21,NULL,NULL,644);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1562055089','Actully useful Internet security techniques',41,NULL,NULL,213);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('156205533X','Java',13,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1565922700','Database programming with JDBC and Java',33,NULL,NULL,783);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1568304102','Teach yourself Illustrator 7 in 24 hours',47,NULL,NULL,827);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1571690115','Windows 95 multimedia and ODBC API bible',3,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1571690840','JavaScript interactive course',14,NULL,NULL,828);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('157169109X','Borland CBuilder howto : the definitive CBuilder problem solver',7,NULL,NULL,788);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1572313315','Inside Microsoft SQL server 6 5',33,NULL,NULL,783);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1572313404','Microsoft Office 97 Visual Basic programmers guide',20,NULL,NULL,750);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1572313587','Microsoft Access 97 developers handbook',34,NULL,NULL,737);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1572314400','Microsoft Office 97 developers handbook',51,NULL,NULL,827);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1572315105','Microsoft Visual C owners manual : version 5 0',21,NULL,NULL,749);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1572315652','Inside Visual C',21,NULL,NULL,732);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1575210398','Presenting Java : an introduction to Java and HotJava',13,NULL,NULL,512);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1575213036','Teach yourself Visual Café 2 in 21 days',13,NULL,NULL,750);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1705','Grunderna i Pascal Turbo 5 5',15,NULL,NULL,987);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1850321973','ABCD SGML : a users guide to structured information',22,NULL,NULL,536);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1850323011','Object technology : concepts and methods',3,NULL,NULL,796);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1878739158','Waite Groups Windows API bible : the definitive programmers reference',3,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1883577004','Windows programming power with custom controls',3,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1884842100','Applying OMT : a practical stepbystep guide to using the object modeling technique',3,NULL,NULL,276);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1884842712','best of Booch : designing strategies for object technology',3,NULL,NULL,758);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('1918','Grafiska användargränssnitt : en utvecklingshandbok',1,NULL,NULL,977);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('21128995','bok om C',8,NULL,NULL,421);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('23630590','Börja med BASIC',6,NULL,NULL,476);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('24345768','Datorn i mätsystem',1,NULL,NULL,570);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('291019','Elektronisk post',40,NULL,NULL,698);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('292813','Elektronisk post i ett säkerhetsperspektiv',40,NULL,NULL,698);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('31097032','C for electronics and computer engineering technology',7,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('31103628','C programming language',7,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('315317','dos av DOS',25,NULL,NULL,626);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('31551515','Compiler design in C',22,NULL,NULL,519);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('32017571','design of the UNIX operating system',29,NULL,NULL,587);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('3243','Framework IV : en introduktion för ekonomer',45,NULL,NULL,862);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('32908670','Database directions : from relational to distributed multimedia and objectoriented database systems',33,NULL,NULL,560);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('34038190','Data structures : with abstract data types and Pascal',3,NULL,NULL,559);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('34092640','Data structures : with abstract data types and Pascal',15,NULL,NULL,559);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('3540609547','Object technologies for advanced software : second JSSST International Symposium ISOTAS 96 Kanazawa Japan March 11 15 1996 : proceedings',1,NULL,NULL,786);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('3574','Firewalls and Internet security : repelling the wily hacker',41,NULL,NULL,827);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('37175714','Computer security basics',41,NULL,NULL,524);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('380712','Dialog direct : en metod för att skapa grafiska användargränssnitt : användarhandledning',1,NULL,NULL,598);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('3944','Företagsintegriteten i datasamhället',41,NULL,NULL,930);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('40552004','Bättre ADBsystem : användarens uppgift',2,NULL,NULL,474);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('40802434','Boken om Pascal',15,NULL,NULL,423);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('410218','Dialogergonomi : effektiv interaktion människa dator',1,NULL,NULL,598);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('411583','Erfarenheter av objektorienterad systemutveckling',2,NULL,NULL,738);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('42285329','computer virus crisis',41,NULL,NULL,524);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('425511','DUPEK : dialogsystem för utveckling av ekonomisk planering och kontroll : systembeskrivning och kommandospråk',3,NULL,NULL,632);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44114818','Databehandling till lågpris',1,NULL,NULL,561);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44151926','Datalogi : en inledande översikt',1,NULL,NULL,563);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44151934','Datalogi : en inledande översikt',1,NULL,NULL,563);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44168411','Datorn som verktyg : krav och ansvar vid systemutveckling och datoranvändning',2,NULL,NULL,571);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44195443','Data om data',1,NULL,NULL,559);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44196822','Datorer : att leva med datorer 2 uppl',1,NULL,NULL,568);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44264615','Computer organization and assembly language programming : a gentle introduction',3,NULL,NULL,523);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44303017','Datatyper och algoritmer',1,NULL,NULL,565);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44309910','Datavirus',41,NULL,NULL,565);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44359918','Databasorienterad systemutveckling : grundläggande begrepp datamodellering systemkonstruktion',2,NULL,NULL,561);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44439210','Datoranvändning i företag : aspekter på företags anskaffning och utnyttjande av datorer och programvarulösningar',1,NULL,NULL,566);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('44444311','Datorekonomi',1,NULL,NULL,568);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('479257','Eiffel : the language',11,NULL,NULL,675);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('5097','Graphics programming with Visual Basic',19,NULL,NULL,979);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('528185','Exploring mathematics with Mathematica : dialogs concerning computers and mathematics',50,NULL,NULL,784);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('5554654X','Cleanroom software engineering : a reader',3,NULL,NULL,506);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('56151659','dBASE IV : complete reference for programmers',22,NULL,NULL,575);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('563649','Effective C : 50 specific ways to improve your programs and designs',8,NULL,NULL,654);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('5808','Fundamentals of humancomputer interaction',1,NULL,NULL,897);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('602083','Excel 5 handboken',44,NULL,NULL,776);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('60213X','Excel 5 i praktiken',44,NULL,NULL,776);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('602148','Excel 5 till max : proffsboken för Microsoft Excel 5 0',44,NULL,NULL,777);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('60308X','Excel 5 programmering : VBA och makroprogrammering för Excel 5 = Microsoft Excel 5 programmering VBA och makroprogrammering för Excel 5',44,NULL,NULL,776);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('62382327','Database analysis and design',22,NULL,NULL,560);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('6241','Funktionellt stöd för effektivare ITanvändare : en rapport från ITföretagen med råd och tips',1,NULL,NULL,898);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('63531806','Computer security : policy planning and practice',41,NULL,NULL,524);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('649X','Fungerande systemförvaltning',2,NULL,NULL,898);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('651X','FileMaker Pro : tips och möjligheter',36,NULL,NULL,815);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('662150','Distributed databases : principes and systems',33,NULL,NULL,612);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('6947','Fortsätt med struktur : strukturerad programmering',3,NULL,NULL,858);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('70270635','Dataprogram för småföretag : hur du väljer rätt program till din dator',1,NULL,NULL,564);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('7155829X','Debugging : creative techniques and tools for software repair',3,NULL,NULL,576);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('71709916','Control of evolving software systems : a languageindependent database approach',22,NULL,NULL,534);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('72202483','Brandväggar vid anslutning till Internet : skydd mot obehörigt intrång',41,NULL,NULL,442);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('72304406','Database developers guide : with Visual Basic 3',33,NULL,NULL,560);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('73825875','Datorn på mitt skrivbord',1,NULL,NULL,571);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('74980890','Bättre ADBprojekt : om hur man undviker de vanligaste fällorna vid utveckling av ADBsystem',2,NULL,NULL,474);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('7587','Grunderna i Pascal',15,NULL,NULL,987);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('78739166','Borland C developers Bible',8,NULL,NULL,430);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('79420028','Boken om MSDOS och PCDOS',27,NULL,NULL,423);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('79420478','Boken om DOS 4 : svenska programversioner',25,NULL,NULL,422);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('79791574','Borland Pascal 7 0 programming for Windows',15,NULL,NULL,431);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('8015','Grunderna i C',7,NULL,NULL,987);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('80400663','Computer based information systems : an introduction',1,NULL,NULL,523);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('8620002X','CP M : handboken med MP M',24,NULL,NULL,541);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('86200917','dBASE IV i praktiken',22,NULL,NULL,575);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('86656376','CASE : en plattform för 90talets systemutveckling',2,NULL,NULL,485);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('86656511','Dataolyckor : har det verkligen hänt någon gång',41,NULL,NULL,563);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('866X','Grunderna i PASCAL Turbo 6 0',15,NULL,NULL,987);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('87026155','Datasäkerhet : praktisk handbok för beslutsfattare = Dataosäkerhet',41,NULL,NULL,564);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('87941940','C : object oriented data structures',8,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('881X','Fortran 90 : en introduktion',12,NULL,NULL,858);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('88310906','Delphi programmering för dummies',10,NULL,NULL,581);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('88436020','Datalogi',1,NULL,NULL,563);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('884475','Effective methodology for the study of HCI',1,NULL,NULL,655);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9121127816','Bli effektiv med Windows 3 1',59,NULL,NULL,417);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('912113684X','Systemering med objekt händelseanalys och relationsdatabaser',2,NULL,NULL,669);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('912158804X','Fortsätt med Pascal : Turbo 5 5',15,NULL,NULL,537);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9121588384','Allt om DOS',25,NULL,NULL,252);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9121588503','Programmera med dBASE IV',22,NULL,NULL,736);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9123014024','Övningar till Word 6 0 : textbehandling affärsgrafik ritfunktioner bildhantering',61,NULL,NULL,814);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9138610191','Att specificera informationssystem : en användarorienterad och systematisk metodik',39,NULL,NULL,330);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9138610248','Att skriva strukturerade COBOLprogram',9,NULL,NULL,330);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9140624935','Fönster mot datavärlden : datakunskap 69 : Windows 3 X',59,NULL,NULL,717);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9140800946','dBase IV : en introduktion',35,NULL,NULL,739);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9140801551','Lär dig systemera med dBASE IV',35,NULL,NULL,764);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9140801594','Programmera med dBASE IV',35,NULL,NULL,736);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144000626','Programutveckling med Delphi : grundläggande programmering i Object Pascal',10,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('914400219X','Programutveckling med JAVA',13,NULL,NULL,722);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144002920','SPSS 7 5 för Windows 95 : en introduktion',57,NULL,NULL,615);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144004125','Kom igång med 3D Studio MAX',65,NULL,NULL,739);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144004567','Programutveckling med Delphi : grundläggande programmering i Object Pascal',10,NULL,NULL,753);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144005180','Problemlösning och algoritmer med Pascal',15,NULL,NULL,707);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144005997','Notes i ett nötskal',37,NULL,NULL,722);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144006268','Programkonstruktion med kvalitet : projekthantering och ISO 9000',3,NULL,NULL,762);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144006810','Design av informationsteknik : materialet utan egenskaper',1,NULL,NULL,815);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144006934','Objektorienterad analys och design',2,NULL,NULL,804);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144007361','Objektorienterad programmering och JAVA',13,NULL,NULL,804);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144146019','Att delta i ADBprojekt',1,NULL,NULL,317);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144160879','Praktisk ADB',1,NULL,NULL,512);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144183313','Att ställa krav på datasystemet : handledning och checklistor för analys av företagets behov av databehandling och upprättande av kravspecifikation för programvara',2,NULL,NULL,332);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('914421541X','dresserade datorn : konsten att utveckla datasystem på användarnas villkor',2,NULL,NULL,751);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144221819','Adaboken',4,NULL,NULL,698);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144252315','Ada från början',4,NULL,NULL,739);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144267312','Vägen till C',7,NULL,NULL,698);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144282613','ADB med användaren i fokus',1,NULL,NULL,216);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144294913','IBM OS 2 : en introduktion',28,NULL,NULL,753);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144297912','Excel : en introduktion till kalkylprogrammet',44,NULL,NULL,776);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144300719','Offensiva adbsystem',2,NULL,NULL,540);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144342217','JSP från början',3,NULL,NULL,713);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144342926','UNIX och X från början',29,NULL,NULL,829);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144365918','Att skriva med Word för Windows',61,NULL,NULL,329);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144375913','Objektorienterad programmering och algoritmer i Simula',3,NULL,NULL,540);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144381913','Programutveckling för Windows och Windows NT',3,NULL,NULL,720);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144384416','Design och programutveckling i Windows',3,NULL,NULL,587);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144384912','Programkonstruktion och projekthantering',3,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144402724','ADB systemarbete',2,NULL,NULL,218);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144461712','Objektorienterad utveckling med COOLmetoden : anpassningsbara och användbara administrativa informationssystem',2,NULL,NULL,540);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144470010','SGML : en introduktion till Standard Generalized Markup Language',22,NULL,NULL,753);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144476310','Datalogi : begreppen och tekniken',1,NULL,NULL,563);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144479719','ADBköparen : en bok om konsten att köpa ADBtjänster datorsystem programvara nätverk och andra ITprodukter',1,NULL,NULL,216);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144604114','Att samlära i systemdesign',2,NULL,NULL,540);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144605110','Administrativa standardsystem : en del av ITstrategin',2,NULL,NULL,221);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9144613016','Essays on infology : summing up and planning for the future',1,NULL,NULL,540);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9147000937','bok om C med introduktion i Java',7,NULL,NULL,645);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9147030097','Datakörkort : ECDL : Microsoft Office',51,NULL,NULL,584);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9147035099','Grunderna i C',7,NULL,NULL,744);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9147035129','Microsoft Excel 97 : avancerad',44,NULL,NULL,814);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9150611771','Dataparallel implementation of Prolog',16,NULL,NULL,788);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('915061181X','Compilation techniques for Prolog',16,NULL,NULL,785);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9150612158','Exploiting finegrain parallelism in concurrent constraint languages',3,NULL,NULL,793);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9150612174','On simultaneous rigid Eunification',1,NULL,NULL,824);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9152403645','ADB i praktiken',1,NULL,NULL,216);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9152411621','Ada och C vid objektorientering',3,NULL,NULL,213);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9157410127','ADBboken : grunder i databehandling',1,NULL,NULL,215);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9157800383','Millenniebomben : år 2000 hotet mot vårt digitaliserade samhälle',41,NULL,NULL,722);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('916301310X','Word för Windows 2 0 : grundkurs',62,NULL,NULL,722);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163024837','Terminologi för informationssäkerhet',42,NULL,NULL,753);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163404575','Access för Windows',34,NULL,NULL,206);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163405156','Windows 3 1 de första stegen',59,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163408201','Excel 5 för Windows : steg för steg',44,NULL,NULL,776);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163409399','ADB datasäkerhet',41,NULL,NULL,215);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163409410','Access 2 : spectrum',34,NULL,NULL,206);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163409445','Excel 5 avancerad',44,NULL,NULL,776);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163409453','Access 2 för Windows : steg för steg',34,NULL,NULL,206);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163411911','PowerPoint 4 för Windows steg för steg',54,NULL,NULL,511);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163420066','Från Windows 3 till Windows 95',30,NULL,NULL,893);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163420252','Microsoft Word 7 för Windows steg för steg',61,NULL,NULL,503);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163420260','Microsoft Excel 7 för Windows steg för steg',44,NULL,NULL,542);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163420880','Programmering Visual Basic',20,NULL,NULL,613);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('916360230X','Access 2 programmering',34,NULL,NULL,206);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163602318','Works 3 handboken',64,NULL,NULL,503);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163602377','WordPerfect 6 för Windows handboken',63,NULL,NULL,503);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163602636','CorelDRAW 4 handboken',43,NULL,NULL,536);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163602776','Programmera Windows med C C : beskriver Win32 API',7,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163602962','Excel tillämpningar : 100 lönsamma ekonomiska modeller',44,NULL,NULL,777);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163603004','Windows 95 till max : proffsboken om Windows 95',30,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163603233','Att byta till Windows 95',30,NULL,NULL,316);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604345','Windows 95 till max : proffsboken om Microsoft Windows 95',30,NULL,NULL,502);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604426','JavaScriptprogrammering',14,NULL,NULL,645);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604434','Photoshop 4 handboken',53,NULL,NULL,640);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604450','Internet och Microsoft Office 97 i praktiken',52,NULL,NULL,701);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604469','Programmera med Visual BASIC 5',20,NULL,NULL,542);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('916360454X','Lättpocket om Visual BASIC 5 : en bok för nybörjare',20,NULL,NULL,804);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604655','Assemblerprogrammering',3,NULL,NULL,621);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604663','Grunderna i Microsoft Excel 97 : teori övningar lösningsförslag',44,NULL,NULL,579);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('916360468X','Grunderna i Microsoft Access 97 : teori övningar lösningsförslag',34,NULL,NULL,590);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604698','Grunderna i Microsoft Office 97 : teori övningar lösningsförslag',51,NULL,NULL,579);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604701','Grunderna i Microsoft PowerPoint 97',54,NULL,NULL,579);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604736','Windows NT 4 till max',32,NULL,NULL,737);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604744','Javaprogrammering',13,NULL,NULL,767);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604760','Programmera Internet med Visual Basic 5',20,NULL,NULL,699);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604779','Lättpocket om JAVAprogrammering : en bok för kloka nybörjare',13,NULL,NULL,722);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604795','Frontpage 98 handboken',46,NULL,NULL,722);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604825','Lättpocket om Photoshop 4 : en bok för kloka nybörjare',53,NULL,NULL,734);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604833','Lättpocket om Frontpage 98 : en bok för kloka nybörjare',46,NULL,NULL,782);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604876','Lättpocket om JAVASCRIPT JSCRIPT : en bok för kloka nybörjare',14,NULL,NULL,794);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604965','Lär dig Visual C5 på 3 veckor',21,NULL,NULL,755);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163604973','Lär dig SQL på 3 veckor',33,NULL,NULL,804);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9163605031','Fortsättning i Word 97 : teori övningar lösningsförslag',61,NULL,NULL,722);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9164401472','Microsoft Windows NT workstation version 4',60,NULL,NULL,742);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9164401626','Java Internet',13,NULL,NULL,737);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170270937','Programguiden : administrativa datorprogram med tips till användare : för små och medelstora företag',22,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170990360','ADBsäkerhet Del 2 Säkerhetsanalys : att utveckla en handlingsplan',41,NULL,NULL,218);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170990379','ADBsäkerhet Del 4 Säkerhetsanalyser med scenarioteknik',41,NULL,NULL,218);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170990387','ADBsäkerhet Del 5 Säkerhetsanalyser med scenarioteknik : terminal',41,NULL,NULL,219);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170990395','ADBsäkerhet Del 6 Säkerhetsanalyser med scenarioteknik : PC',41,NULL,NULL,219);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170990409','ADBsäkerhet Del 1 Policy riktlinjer',41,NULL,NULL,218);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170990476','ADBsäkerhet Del 3 SBAscenario för kommunal verksamhet',41,NULL,NULL,218);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9170990484','ADBsäkerhet Del 7 Lär ut ADBsäkerhet : OHbilder',41,NULL,NULL,219);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9171531483','GCLA : the design use and implementation of a program development system',22,NULL,NULL,785);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9171534563','Recognising human plans : issues for plan recognition in humancomputer interaction',2,NULL,NULL,788);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9171537007','Analyzing groupware adoption : a framework and three case studies in Lotus notes deployment',40,NULL,NULL,765);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9171624058','Med datorn in i 2000talet : förbered dig nu undvik datakaos : handbok för små och medelstora organisationer',41,NULL,NULL,729);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9171972013','Practical experimentation as a tool for vulnerability analysis and security evaluation',41,NULL,NULL,511);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9171972374','quantitative approach to computer security from a dependability perspective',41,NULL,NULL,519);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9172200529','ADBsäkerhet vid åtta statliga myndigheter : en uppföljningsstudie',41,NULL,NULL,219);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9172201975','ADBsäkerhet inom rättsväsendet : en modell för bedömning av skyddsnivåer',41,NULL,NULL,219);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9172583266','Anskaffning av standardsystem för att utveckla verksamheter : utveckling och prövning av SIVmetoden',1,NULL,NULL,268);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9177384350','hacker i systemet',41,NULL,NULL,795);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('917871513X','Arbetsintegrerad systemutveckling med kalkylprogram',2,NULL,NULL,285);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('917871687X','Multidatabase integration using polymorphic queries and views',33,NULL,NULL,635);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9178717302','Quality functions for requirements engineering methods',1,NULL,NULL,635);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9178824133','Microsoft Excel 97',44,NULL,NULL,755);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9178824176','Lotus Notes 4 5 för Windows',37,NULL,NULL,772);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9178824230','Microsoft Access 97',34,NULL,NULL,769);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9179420133','Att förstå UNIX',29,NULL,NULL,320);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9179420214','Allt om OS 2',28,NULL,NULL,252);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186064002','ABC om programmering och dokumentation',6,NULL,NULL,205);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186064045','Basic II boken',6,NULL,NULL,374);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186200240','Avancerad MSDOS',25,NULL,NULL,343);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186201379','QBASIC : programmering',17,NULL,NULL,519);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186201476','Excel 4 referensboken',44,NULL,NULL,776);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186201751','Access för Windows handboken = Microsoft Access handboken',34,NULL,NULL,207);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186201905','Access för Windows i praktiken',34,NULL,NULL,207);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186656430','ADBdrift inför 90talet : en verksamhet i förändring',1,NULL,NULL,215);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186656597','ADBsäkerhet i användargenomförd systemutveckling : en utmaning',41,NULL,NULL,219);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9186656686','Client server och säkerhet',41,NULL,NULL,506);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9187026384','Dataosäkerhet : praktisk handbok för beslutsfattare',41,NULL,NULL,829);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188310132','201 bästa programmen inom shareware = Maxidata presenterar de 201 bästa programmen inom shareware',22,NULL,NULL,199);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188311236','Hemligheterna i Access 97',34,NULL,NULL,817);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188311279','Hemligheterna i Excel för Windows 95',44,NULL,NULL,590);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188311333','Hemligheterna i Windows NT server 4 0',32,NULL,NULL,807);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188311457','Hemligheterna i Java',13,NULL,NULL,743);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188311570','Windows NT 4 för dummies',32,NULL,NULL,710);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188311597','ActiveX för dummies',5,NULL,NULL,816);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('918831166X','Visual basic 5 för Windows för dummies',20,NULL,NULL,814);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188311821','Microsoft FrontPage 98',46,NULL,NULL,830);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188690210','Schedule',56,NULL,NULL,817);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188734080','ADBsäkerhet : grundbok för säker ADBhantering',41,NULL,NULL,677);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('918886202X','Återanvändning i verkligheten : rapport från projekt Särimner',2,NULL,NULL,505);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9188972348','Photoshop 4 0 för Windows : grundkurs',53,NULL,NULL,784);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9197115908','Adateknologi : viktiga aspekter på användningen av Ada',4,NULL,NULL,547);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('952120074X','interactive environment supporting the development of formally correct programs',3,NULL,NULL,824);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9521201924','ScanAgent : ett intelligent datainsamlingsverktyg',1,NULL,NULL,820);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('97029645','C programming language',7,NULL,NULL,478);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9905775390','Proceedings of the Second international programming conference Uppsala university Uppsala Sweden July 26 1984',3,NULL,NULL,787);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9916008507','Objektorienterad programmering och Simula',3,NULL,NULL,705);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9920948454','Säkerhet i elektronisk post',40,NULL,NULL,532);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9921577115','Program för sökning i databaser : en marknadsöversikt',39,NULL,NULL,515);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9922731614','Verktyg för programutveckling : en översikt',2,NULL,NULL,815);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9922731630','Verktyg för automatiserad testning av programvara med grafiska användargränssnitt : en översikt',3,NULL,NULL,729);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9922819953','Säkerhet i landstingets nätverk : handbok',41,NULL,NULL,533);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9923248305','Rapport från konferensen DAUG Strategies Resources The Repository Data Warehouse Connection',33,NULL,NULL,520);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9923950751','XLII : en öppen och flexibel utvecklingsmiljö',2,NULL,NULL,503);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9924068696','Metod för utveckling av IOsamverkan : Toppledarforum elektronisk handel för kommuner landsting och stat ett tillämpningsprojekt',2,NULL,NULL,533);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9924253248','Objektorienterade mjukvarukomponenter i datorbaserade informationssystem',1,NULL,NULL,533);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9924316797','Gruppdatorteknik : användningsmodeller för verksamhetsutveckling',1,NULL,NULL,763);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9924479831','Data Warehouse : en introduktion',33,NULL,NULL,747);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9924479866','Metodram för förnyelse av informationssystem',2,NULL,NULL,780);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9924479890','Synchronous collaboration over the Internet : incorporating synchronous collaboration tools into web based groupware systems',40,NULL,NULL,824);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9924880048','Agent software : en ny konferens om agentbaserad systemutveckling',2,NULL,NULL,798);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9925123852','Användare ett nödvändigt ont eller en självklar resurs : perspektiv på användarmedverkan i utvecklingen av en metod för användarcentrerad systemutveckling',2,NULL,NULL,738);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9925133521','Complex concept management and manipulation',39,NULL,NULL,716);
GO
INSERT INTO [dbo].[BOOK]
           ([ISBN]
           ,[Title]
           ,[SignId]
           ,[PublicationYear]
           ,[Publicationinfo]
           ,[Pages])
     VALUES
           ('9925157951','Programvarusystem : prototypning ökad träffsäkerhet vid systemutveckling',2,NULL,NULL,721);
GO

/******************** Update publicationinfo in table Book ********************/
UPDATE [dbo].[book]
	SET publicationinfo = 'New York : McGraw-Hill, 1994' WHERE pages > 0 AND pages < 41
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'London : McGraw-Hill, 1990' WHERE pages > 40 AND pages < 81
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Menlo Park, Calif. ; Harlow : Addison-Wesley, 1999' WHERE pages > 80 AND pages < 121
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Englewood Cliffs, New Jersey : Prentice-Hall, 1990' WHERE pages > 120 AND pages < 161
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Upper Saddle River, New Jersey : Prentice-Hall, 1995' WHERE pages > 160 AND pages < 201
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Englewood Cliffs, N.J. : Prentice-Hall, 1994' WHERE pages > 200 AND pages < 241
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Redmond, Washington : Microsoft Press, 1994' WHERE pages > 140 AND pages < 281
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Wokingham : Addison-Wesley, 1988' WHERE pages > 280 AND pages < 321
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Reading, Mass. : Addison-Wesley, 1997' WHERE pages > 320 AND pages < 361
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Reading, Massachusetts : Addison-Wesley, 1994' WHERE pages > 360 AND pages < 401 
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Reading : Addison-Wesley, cop. 1994' WHERE pages > 400 AND pages < 441
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Sveriges verkstadsindustrier, 1992' WHERE pages > 440 AND pages < 481
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Chichester : Wiley, 1998' WHERE pages > 480 AND pages < 521
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Pacific Grove, Calif. : Brooks/Cole, cop. 1989' WHERE pages > 520 AND pages < 561
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Indianapolis : SAMS, 1995' WHERE pages > 560 AND pages < 601
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'New York : McGraw-Hill, 1994' WHERE pages > 600 AND pages < 641
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'New York : McGraw-Hill, 1995' WHERE pages > 640 AND pages < 681
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Berkeley, California : McGraw-Hill, 1993' WHERE pages > 680 AND pages < 721
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Berkly : McGraw-Hill, 1978' WHERE pages > 720 AND pages < 761
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Almqvist & Wiksell dataförl., 1992' WHERE pages > 760 AND pages < 801
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Liber, 1990' WHERE pages > 800 AND pages < 841
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Malmö : LiberLäromedel, 1980' WHERE pages > 840 AND pages < 861
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Liber, 1990' WHERE pages > 860 AND pages < 901
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Liber, 1990' WHERE pages > 900 AND pages < 941
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Lund : Studentlitt., 1984' WHERE pages > 940 AND pages < 981
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Lund : Studentlitteratur, 1989' WHERE pages > 200 AND pages < 221
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Lund : Studentlitteratur, 1989' WHERE pages > 300 AND pages < 321
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Lund : Studentlitteratur, 1993' WHERE pages > 400 AND pages < 421
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Sveriges mekanförbund, 1989' WHERE pages > 500 AND pages < 521
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Sveriges verkstadsindustrier, 1993' WHERE pages > 600 AND pages < 621
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Liber utbildning dataförl., 1993' WHERE pages > 700 AND pages < 721
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm ; Helsingfors : Pagina, 1997' WHERE pages > 800 AND pages < 821
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : Pagina, 1998' WHERE pages > 900 AND pages < 921
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : SIS (Standardiseringen i Sverige), 1997' WHERE pages > 100 AND pages < 121
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Linköping : WT-konsult, Emmdata, 1980' WHERE pages > 260 AND pages < 281 
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Stockholm : DF förlag, 1991' WHERE pages > 460 AND pages < 481
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Sundsvall : Computer Press, cop. 1989' WHERE pages > 660 AND pages < 681
GO
UPDATE [dbo].[book]
	SET publicationinfo = 'Sebastopol, Calif. : O´Reilly, cop. 1991' WHERE pages > 860 AND pages < 881
GO
/****************************************************************************************/

/****** Object:  Table [dbo].[BAT]  a temporary table  Script Date: 2015-01-23 15:25:54 ******/
CREATE TABLE [dbo].[BAT](
	[ISBN] [nvarchar](15) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[BirthYear] [nvarchar](10) NULL
) ON [PRIMARY]
GO

/********** Table BAT **********************************************************************************/
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471518026','Razmik','Abnous','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137758006','Joel','Adams','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170270937','Stig','Adamsson','1937');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144221819','AnnaBie','Agerberg','1958');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144221819','Jonas','Agerberg','1923');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9178824230','Thomas','Ahlandsberg','1958');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924880048','Matts','Ahlsén','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0120455951','Vijay','Ahuja','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0120499428','Jeff','Alger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1850321973','Liora','Alschuler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311236','William C','Amo','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9140801551','StenGöran','Andersson','1940');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144342926','Torbjörn','Andréasson','1957');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9920948454','Mats','Appelgren','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9920948454','Mats','Appelgren','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9171531483','Martin','Aronsson','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188734080','Rolf','Aronsson','1942');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188734080','Rolf','Aronsson','1942');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188734080','Rolf','Aronsson','1942');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144002920','Åke','Aronsson','1940');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916360454X','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604760','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604760','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604760','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604469','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604345','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163603004','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163603004','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Stefan','Arvidsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188690210','Rikard','Ask','1966');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('918886202X','Bengt','Asker','1928');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9178824133','Lennart','Back','1935');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924479831','Stig','Berild','1944');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9923248305','Stig','Berild','1944');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070062722','Alex','Berson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201624397','Elisa','Bertino','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9150611771','Johan','Bevemyr','1966');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9150611771','Johan','Bevemyr','1966');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144267312','Ulf','Bilting','1955');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1884842712','Grady','Booch','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0805306005','Grady','Booch','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1850323011','Mokrane','Bouzeghoub','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070067317','Kenneth A','Bowen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137696396','Stephen','Brobst','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201835959','Frederick Phillips Jr','Brooks','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201403943','Martin','Bryan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163605031','Olle','Burholt','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916360468X','Olle','Burholt','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604663','Olle','Burholt','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604698','Olle','Burholt','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604701','Olle','Burholt','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('912113684X','Sven','Burman','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558285342','Diane','Burns','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311279','Pat J','Burns','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558284915','Fred','Butzen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('912113684X','Bo','Bäckman','1945');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('157169109X','Thomas','Cabanski','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0672310228','Charles','Calvert','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0672310228','Charles','Calvert','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0077076648','Stephen John','Cannan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201309955','R G G','Cattell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201403692','Stefano','Ceri','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0412788101','E','Cerny','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471958204','Peter','Checkland','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924253248','Benneth','Christiansson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924253248','Benneth','Christiansson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1883577004','Paul S','Cilwa','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1575213036','Mike','Cohn','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1878739158','Jim','Conger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0138504547','Todd','Courtois','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201103931','Brad J','Cox','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311570','Sharon','Crawford','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144375913','Serafim','Dahl','1945');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144375913','Serafim','Dahl','1945');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9178824176','Åsa','Dahlberg','1968');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144613016','Bo','Dahlbom','1949');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9187026384','Torgeir','Daler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('020142777X','Patrick W','Daly','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1571690840','Arman','Danesh','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('918886202X','i Sverige','Dataföreningen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1575210398','John','December','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201530678','Peter J','Denning','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0672305941','Arthur','Dumas','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1883577004','Jeff','Duntemann','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201847477','Joe','Duran','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604744','Jesper','Ek','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604744','Jesper','Ek','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604795','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604795','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604795','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604450','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604450','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604426','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604426','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604426','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604833','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604779','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604876','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604825','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916360454X','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604434','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604760','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604760','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604760','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604469','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602776','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604345','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163603004','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163603004','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','Jesper','Ek','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9140624935','Bo','Ekdahl','1951');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604833','Anna','Ekinge','1973');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604825','Anna','Ekinge','1973');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144006268','Sven','Eklund','1962');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144384912','Sven','Eklund','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144384912','Sven','Eklund','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604744','Rasmus','Ekman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604744','Rasmus','Ekman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604426','Rasmus','Ekman','1965');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604426','Rasmus','Ekman','1965');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604426','Rasmus','Ekman','1965');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602776','Rasmus','Ekman','1965');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144005180','Torgil','Ekman','1935');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144005180','Torgil','Ekman','1935');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471191612','HansErik','Eriksson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144381913','HansErik','Eriksson','1961');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144381913','HansErik','Eriksson','1961');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914400219X','HansErik','Eriksson','1961');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914400219X','HansErik','Eriksson','1961');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914400219X','HansErik','Eriksson','1961');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9164401626','Fredrik','Espinoza','1970');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9171537007','Ulf','Essler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1884842712','Edward M','Eykholt','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311597','Kurt D','Fenstermacher','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144006268','Hans','Fernlund','1969');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201309955','Maydene','Fisher','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558284915','Dorothy','Forbes','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137994532','Warwick','Ford','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9922731630','Anders','Forsell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9922731614','Anders','Forsell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201325632','Martin','Fowler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311236','James D','Foxall','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201403692','Piero','Fraternali','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9187026384','Jan','Freese','1933');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201526492','Frank L','Friedman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('3540609547','Kokichi','Futatsugi','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201542625','Peter Baer','Galvin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1850323011','Georges','Gardarin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0131829572','David','Garlan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('081763911X','Peter A','Gloor','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1568304102','Mordy','Golding','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070246459','Marcus','Goncalves','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9147030097','Ingvar','Gratte','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9147035099','Ingvar','Gratte','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163420880','Ingvar','Gratte','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604965','Nathan','Gurewich','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604965','Ori','Gurewich','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144461712','Håkan','Göransson','1968');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144461712','Håkan','Göransson','1968');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201309955','Graham','Hamilton','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311457','Elliotte Rusty','Harold','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('012326426X','Jan L','Harrington','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186201379','Gunvald','Hedemalm','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070278938','Gregory L','Heileman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201310139','Peter M','Heinckiens','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311333','Valda','Hilley','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0132366134','Luke','Hohmann','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9916008507','Per','Holm','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144007361','Per','Holm','1950');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9187026384','Sten','Holmberg','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471958204','Sue','Holwell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558515658','Steven','Holzner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558514880','Steven','Holzner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0890068658','John W','Horch','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471147672','Cay S','Horstmann','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144300719','Petersen Niels','Hosbond','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144300719','Petersen Niels','Hosbond','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('157169109X','Harold','Howe','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9171624058','Ian','Hugo','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9164401472','Mary','Hutson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144604114','Ann','Hägerfors','1953');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924880048','Mattias','Hällström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924316797','Mattias','Hällström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924479890','Magnus','Ingvarsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9905775390','logic programming conference 2 Uppsala','International','1984');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','GullBritt','Isaksson','1959');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','GullBritt','Isaksson','1959');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','GullBritt','Isaksson','1959');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604736','GullBritt','Isaksson','1959');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('3540609547','Kanazawa','Japanese','1996');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924479866','LarsÅke','Johansson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9178717302','Mikael','Johansson','1962');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9171972374','Erland','Jonsson','1946');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9925123852','Cecilia','Katzeff','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('013020207X','Barry','Kauler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('007034678X','Jessica','Keyes','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471518026','Setrag','Khoshafian','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137696396','Patricia','Klauer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0412788101','C Delgado','Kloos','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188972348','Björn','Kläppe','1937');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201134470','Donald Ervin','Knuth','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201526492','Elliot B','Koffman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9921577115','Peeter','Kool','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('020142777X','Helmut','Kopka','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144004125','Per','Krokstäde','1969');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572315652','David','Kruglinski','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144294913','Bengt','Kynning','1936');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144294913','Bengt','Kynning','1936');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144294913','Bengt','Kynning','1936');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144005997','Bengt','Kynning','1936');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163411911','Karin','Landmér','1958');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163411911','Karin','Landmér','1958');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144613016','Börje','Langefors','1915');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137488807','Craig','Larman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0672300974','Alex','Leavens','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0078815037','Geoffrey T','LeBlond','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137758006','Sanford','Leestma','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916360468X','Per','Lennartzon','1972');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604663','Jaan','Lepp','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604698','Jaan','Lepp','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9197115908','Örjan','Leringe','1944');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201571641','John','Lewis','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9140624935','Ingrid','Lilja','1944');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('915061181X','Thomas','Lindgren','1966');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144375913','Kjell','Lindqvist','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144375913','Kjell','Lindqvist','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604655','Wolfgang','Link','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604655','Wolfgang','Link','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0805322795','Martin Advanced Concepts Center','Lockheed','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201571641','William','Loftus','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188690210','Tommy','Lundahl','1960');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924068696','MarieTherese','Lundmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924068696','MarieTherese','Lundmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('952120074X','Thomas','Långbacka','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144006810','Jonas','Löwgren','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0890069190','Stan','Magee','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0805366814','David','Maier','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0849378362','Mark W','Maier','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0672310481','Anthony T','Mann','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201624397','Lorenzo','Martino','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144006934','Lars','Mathiassen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070410348','Robert M','Mattison','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144342217','Hans','Mattsson','1945');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1556159005','Steve','McConnell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9157800383','Colin','McGhee','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914421541X','Gian','Medri','1933');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914421541X','Gian','Medri','1933');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914421541X','Gian','Medri','1933');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914421541X','Margareta','Medri','1933');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914421541X','Margareta','Medri','1933');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('914421541X','Margareta','Medri','1933');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('157169109X','John','Miano','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572313404','Corporation','Microsoft','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1555581951','Howard Wilbert','Miller','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9147030097','Hans','Moll','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163420252','Hans','Moll','1947');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163405156','Hans','Moll','1947');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9150612158','Johan','Montelius','1963');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201142279','Ron','Morrison','1946');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0792399714','Thomas A','Mueck','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144470010','Anders','Möller','1952');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144470010','Anders','Möller','1952');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311279','John R','Nicholson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602377','Catherine','Nilsson','1966');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144004125','Roger','Nordin','1965');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604434','Alexandra','Norell','1966');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604450','KarlJohan','Norén','1971');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604450','KarlJohan','Norén','1971');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137758006','Larry','Nyhoff','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9923950751','Dan','Nyström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9123014024','Strömberg Britt','Näslund','1952');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572313587','Timothy M','OBrien','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163024837','Mats','Ohlin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070490678','Linda I','OLeary','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070490678','Timothy J','OLeary','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9521201924','Svante','Olofsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9521201924','Svante','Olofsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9171972013','Tomas','Olovsson','1959');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9147000937','Ingmar','Olsson','1940');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('912158804X','Ingmar','Olsson','1940');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9164401626','Martin','Omander','1970');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0077076648','Gerard M A','Otten','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144461712','Ingrid','Ottersten','1958');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144461712','Ingrid','Ottersten','1958');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('086238091X','Elizabeth','Oxborrow','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201546647','Mark C','Paulk','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471191612','Magnus','Penker','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602318','Paula','Penttinen','1970');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0937073172','Fernando C N','Pereira','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0078824613','Richard','Petersen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201060892','James Lyle','Peterson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1556153953','Charles','Petzold','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0133374866','Charles P','Pfleeger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0133374866','Charles P','Pfleeger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0131214845','David S','Platt','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137696396','Vidette','Poe','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572313587','Steven J','Pogge','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0792399714','Martin L','Polaschek','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311236','Cary N','Prague','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0136542867','Terrence W','Pratt','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144004125','Lars Göran','Pärletun','1946');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9925157951','Martin','Rantzer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311570','Andy','Rathbone','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0805322795','Software Corporation','Rational','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0849378362','Eberhardt','Rechtin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1565922700','George','Reese','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9157800383','Simon','Reeve','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471578533','Donald J','Reifer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144342217','Olle','Rejler','1936');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('156205533X','Tim','Ritchey','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201545411','Eric','Roberts','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471976555','Graham','Roberts','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201064677','Jean B','Rogers','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9921577115','Peter','Rosengren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163411911','Gillis','Rudh','1946');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163411911','Gillis','Rudh','1946');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9147030097','Torbjörn','Sand','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188311821','Dan','Sandberg','1965');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144000626','Lars','Sandmark','1942');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144004567','Lars','Sandmark','1942');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201847477','Charles H','Sauer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('080537440X','Walter J','Savitch','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0810465655','Kurt J','Schmucker','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201325632','Kendall','Scott','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0136609112','Clifford A','Shaffer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0131829572','Mary','Shaw','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0937073172','Stuart M','Shieber','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201060892','Abraham','Silberschatz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201542625','Abraham','Silberschatz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0077090764','Errol','Simon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1571690115','Richard J','Simon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('013591793X','Harry','Singh','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144252315','Jan','Skansholm','1949');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144342926','Jan','Skansholm','1949');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144267312','Jan','Skansholm','1949');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070062722','Stephen J','Smith','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572314400','Christine','Solomon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201142279','Ian','Sommerville','1951');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9925133521','William','Song','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572313315','Ron','Soukup','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9922819953','','Spri','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9171624058','i Sverige','Standardiseringen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604973','Ryan K','Stephens','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604973','Ryan K','Stephens','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604973','Ryan K','Stephens','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9177384350','Clifford','Stoll','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144006810','Erik','Stolterman','1956');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201889544','Bjarne','Stroustrup','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602377','Christer','Sturmark','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602318','Christer','Sturmark','1964');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9140800946','Sten','Sundblad','1939');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9121588503','Sten','Sundblad','1939');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9121588503','Sten','Sundblad','1939');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9140801594','Sten','Sundblad','1939');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9140801594','Sten','Sundblad','1939');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924880048','institutet för systemutveckling','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163604701','Anna','Svensson','1971');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('918886202X','','Särimner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471180041','Rick','Tanler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201309947','David A','Taylor','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('013727405X','Putnam P','Texel','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916301310X','Yvonne','ThorfveEverett','1956');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0890069190','Leonard L','Tripp','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9905775390','StenÅke','Tärnlund','1941');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1850323011','Patrick','Valduriez','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9150612174','Margus','Veanes','1966');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558285342','Sharyn','Venit','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9171534563','Annika','Waern','1960');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1878739158','Group','Waite','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('918831166X','Wallace','Wang','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0805366814','David S','Warren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163420260','Ragnar','Weinz','1939');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9147035129','Ragnar','Weinz','1939');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9147035129','Ulla Britt','Weinz','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163420260','UllaBritt','Weinz','1943');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('917871687X','Magnus','Werner','1968');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144160879','Per','Westerberg','1949');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572313587','Geoffrey E','White','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602377','Kristina','Wiktorsson','1967');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('013727405X','Charles B','Williams','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0471976555','Russel','Winder','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9921577115','Ulf','Wingstedt','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1572315105','Beck','Zaratian','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9924316797','StenErik','Öhlund','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('70270635','Stig','Adamsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('3243','Johanna','Adsjö','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','Lars','Ahrenberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144282613','Karin','Andréasson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('380712','Peter','Andrén','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1918','Peter','Andrén','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186200240','John','Angermeyer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201563452','William R','Arnold','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163603233','Stefan','Arvidsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('917871513X','Anders','Avdic','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('32017571','Maurice J','Bach','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01416778','Jean','Bacon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('3574','Steven M','Bellovin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0132888955','Edward V','Berard','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','Ola','Berndtson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','Ola','Berndtson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','Ola','Berndtson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('602083','Jan','Berneryd','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('23630590','LarsEric','Björk','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('24345768','Dag','Björklöf','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('24345768','Dag','Björklöf','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('881X','Katarina','Blom','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('028038','Håkan','Borgström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144146019','Lars','Bosrup','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201563452','John S','Bowie','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144402724','Rune','Brandinger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('05309039','J Glenn','Brookshear','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01572702','Donald P','Brown','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01572710','Donald P','Brown','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201581124','Jeff','Burger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201581124','Jeff','Burger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201608286','Mark S','Burgess','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('6947','Sven','Burman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('6947','Sven','Burman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('6947','Bo','Bäckman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('6947','Bo','Bäckman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('020148952X','Documentation group','CDE','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('662150','Stefano','Ceri','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('3574','William R','Cheswick','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201184834','Robert G','Clark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('651X','Rolf','Clausen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('884475','Mary','Corbett','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0442008635','James','Crown','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('425511','John','Cumberbatch','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186656430','i Sverige DF','Dataföreningen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186656686','i Sverige DF','Dataföreningen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86656511','i Sverige DF','Dataföreningen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','i Sverige DF','Dataföreningen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','i Sverige DF','Dataföreningen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','i Sverige DF','Dataföreningen','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01548895','Harvey M','Deitel','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('60213X','Arthur','Dent','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('602148','Arthur','Dent','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1884842100','Kurt W','Derr','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144605110','Peter','Dexner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144605110','Peter','Dexner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44114818','Olle','Dopping','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0078818095','Bruce','Eckel','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916360230X','Jesper','Ek','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163603233','Jesper','Ek','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9121127816','Jesper','Ek','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144384416','Jesper','Ek','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('60308X','Per','Eklund','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9172583266','EFI','Ekonomiska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9172583266','EFI','Ekonomiska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201514591','Margaret A','Ellis','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1453','Ramez','Elmasri','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1453','Ramez','Elmasri','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9188310132','Ahrvid','Engholm','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558512969','Gary','Entsminger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88436020','Sven','Erikson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88436020','Sven','Erikson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201608669','Ben','Ezzell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88436020','Martin','Fahlgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88436020','Martin','Fahlgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0830643273','Thomas','Finn','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('05321667','Charles N','Fischer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('42285329','Philip','Fites','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610248','Lennart','Fosselius','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610248','Lennart','Fosselius','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Jan','Freese','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Jan','Freese','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Jan','Freese','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Jan','Freese','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0262560674','Daniel P','Friedman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44309910','Viiveke','Fåk','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86656376','Håkan','Fägersten','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('37175714','G T Sr','Gangemi','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186201476','Ingebjörn','Gille','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44439210','Mats','Glader','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44439210','Mats','Glader','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44439210','Mats','Glader','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44439210','Mats','Glader','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('425511','Mats','Glader','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('528185','Jerry','Glynn','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610191','Göran','Goldkuhl','1949');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163404575','Ingvar','Gratte','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163409399','Ingvar','Gratte','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44196822','Ingvar','Gratte','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44196822','Ingvar','Gratte','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44196822','Ingvar','Gratte','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('8015','Ingvar','Gratte','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('528185','Theodore','Gray','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144297912','Jan','Greve','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9179420133','James R','Groff','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44168411','Peter','Gullers','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('380712','Stefan','Gunnarsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1918','Stefan','Gunnarsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','NilsErik','Gustafsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44168411','Bo','Göranzon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9152411621','Mats','Göthe','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144479719','Klas','Hamrin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0262560674','Christopher T','Haynes','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('56151659','Douglas','Hergert','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0672301687','Peter D','Hipson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Sten','Holmberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Sten','Holmberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Sten','Holmberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87026155','Sten','Holmberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144384416','Kolenda Magnus','Holmlid','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('31097032','Peter J','Holsberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('31551515','Allen I','Holub','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0136630146','Steven','Holzner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0136632041','Steven','Holzner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1562055089','Larry J Jr','Hughes','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','Sture','Hägglund','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86656511','','Infosec','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','för verkstadsteknisk forskning IVF','Institutet','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('411583','Nova','IT','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186200240','Kevin','Jaeger','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44303017','LarsErik','Janlert','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610248','Marianne','Janning','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610248','Marianne','Janning','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('72304406','Roger','Jennings','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('40802434','Peter','Johannesson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('42285329','Peter','Johnston','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070328137','Capers','Jones','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86656376','Örjan','Jonsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163409410','Conny','Karlsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163420066','Conny','Karlsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916360230X','Tord','Karlsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('31103628','Brian W','Kernighan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('31103628','Brian W','Kernighan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('97029645','Brian W','Kernighan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('884475','Jurek','Kirakowski','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201038099','Donald E','Knuth','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01548895','Michael S','Kogan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87941940','Carl Philip','Korobkin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('42285329','Martin','Kratz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','Christian','Krysander','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('71709916','Tekniska högskolan','Kungl','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44195443','Hans','Köhler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44195443','Hans','Köhler','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9179420214','Robert','Lafore','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('32908670','James A','Larson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('05321667','Richard J Jr','LeBlanc','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186656597','Göran','Ledell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86656511','Göran','Ledell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('60308X','Jaan','Lepp','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0079310125','Lance A','Leventhal','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0079310125','Lance A','Leventhal','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186656686','Björn','Lindberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602962','Mats','Linde','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('3243','Christer','Lindgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('74980890','Lena','Lindström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88436020','Thomas','Lingefjärd','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88436020','Thomas','Lingefjärd','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('917871513X','universitet Institutionen för datavetenskap','Linköpings','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','universitet Institutionen för datavetenskap','Linköpings','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01548488','Stanley B','Lippman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','Kent','Lundberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44444311','Peter','Lundell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186064002','Jan','Lundgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186064045','Jan','Lundgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('40802434','Jan','Lundgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186064002','Bengt','Lundin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1918','Joakim','Lundin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144476310','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44151926','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44151926','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44151926','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44151926','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44151926','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44151926','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44151934','Hans','Lunell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1556156502','Stephen A','Maguire','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144384416','Kristina','Malm','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('03808285','Business School','Manchester','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0132038374','Robert Cecil','Martin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602636','Jill','Mellström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('479257','Bertrand','Meyer','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('563649','Scott','Meyers','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('74980890','Hubert','Mille','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0070425930','Daniel','Minoli','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163409453','Hans','Moll','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('5808','Andrew','Monk','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('03808285','Enid','Mumford','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44195443','Erik','Månsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44195443','Erik','Månsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44196822','Erik','Månsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44196822','Erik','Månsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44196822','Erik','Månsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44168411','Kalle','Mäkilä','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1453','Shamkant B','Navathe','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1453','Shamkant B','Navathe','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1558512160','Mark','Nelson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610191','Anders','Nilsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9172583266','Anders G','Nilsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9172583266','Anders G','Nilsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163602962','Nils','Nilsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('23630590','Rolf','Nilsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144402724','Johannes','Norrby','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9121588384','Peter','Norton','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9121588384','Peter','Norton','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9179420214','Peter','Norton','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1410','Marketa','Novak','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9152411621','Erik','Nyquist','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9152411621','Ideas','Objective','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44264615','Lennart','Ohlsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186201905','Peter','Olofsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('21128995','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0954','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0954','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0243','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('7587','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1705','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1705','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1705','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('866X','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('866X','Ingmar','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144365918','PerOlov','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144365918','PerOlov','Olsson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('291019','Jacob','Palme','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('662150','Giuseppe','Pelagatti','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('1410','Annika','Persson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('315317','Anders','Peterson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('78739166','Mark','Peterson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('080530911X','Ira','Pohl','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('5554654X','Jesse H','Poore','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01572702','Horacio','Porta','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01572710','Horacio','Porta','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201422948','Wolfgang','Pree','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144479719','Nils','Qwerin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('74980890','RRV Avdelningen för effektivitetsrevision','Riksrevisionsverket','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0734','RRV Avdelningen för effektivitetsrevision','Riksrevisionsverket','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0734','RRV Avdelningen för effektivitetsrevision','Riksrevisionsverket','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0734','RRV Avdelningen för effektivitetsrevision','Riksrevisionsverket','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('31103628','Dennis M','Ritchie','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('31103628','Dennis M','Ritchie','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('97029645','Dennis M','Ritchie','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('63531806','D W','Roberts','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('62382327','Hugh','Robinson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610248','Eric','Roupé','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610248','Eric','Roupé','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88310906','Neil J','Rubenking','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('88310906','Neil J','Rubenking','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44444311','Kjell','Rundqvist','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('37175714','Deborah','Russell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('3944','Nils','Rydén','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('916360230X','Olof','Rydergren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9138610191','Annie','Röstlinger','1950');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0078816912','Herbert','Schildt','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201563452','Michael A','Schoonover','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0137538154','Thomas W','Schultz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201510596','Robert','Sedgewick','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('87941940','Saumyendra','Sengupta','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0136301045','Roger','Sessions','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('79420478','Thomas','Sheldon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('79420478','Thomas','Sheldon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('79420478','Thomas','Sheldon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('79420028','Thomas','Sheldon','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01572869','Ben','Shneiderman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9152411621','Stefan','Sigfried','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0830643273','Robert','Signore','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86200917','Alan','Simpson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9172201975','','Statskontoret','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9172200529','','Statskontoret','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9172200529','','Statskontoret','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('72202483','','Statskontoret','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0830643273','Michael O','Stegman','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('71709916','Bo','Steinholtz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44264615','Per','Stenström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('5097','Robert W','Stewart','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('7155829X','Martin','Stitt','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201514591','Bjarne','Stroustrup','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01539926','Bjarne','Stroustrup','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201543303','Bjarne','Stroustrup','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('34038190','Daniel F','Stubbs','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('34092640','Daniel F','Stubbs','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('34092640','Daniel F','Stubbs','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186656430','Bo','Stbner','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186201751','Christer','Sturmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186201905','Christer','Sturmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9121127816','Christer','Sturmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144384416','Christer','Sturmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('602083','Christer','Sturmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('60213X','Christer','Sturmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('602148','Christer','Sturmark','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44359918','Bo','Sundgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44359918','Bo','Sundgren','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('6241','ITföretagens organisation SITO','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170990409','kommunförbundet','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170990360','kommunförbundet','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170990476','kommunförbundet','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170990379','kommunförbundet','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170990387','kommunförbundet','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170990395','kommunförbundet','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9170990484','kommunförbundet','Svenska','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44168411','Per','Svensson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9152403645','mekanförbund','Sveriges','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('410218','mekanförbund','Sveriges','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9152411621','verkstadsindustrier VI','Sveriges','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('411583','verkstadsindustrier VI','Sveriges','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('79791574','Tom','Swan','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('40552004','Gunnar','Söderbergh','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('73825875','Herbert','Söderström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86656376','Peter','Söderström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('292813','Rune','Söderström','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('86656376','Thomas','Tenevall','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144183313','Olle','Termén','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9144183313','Olle','Termén','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44168411','Leif','Thollander','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186064002','Sören','Thornell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186064045','Sören','Thornell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('40802434','Sören','Thornell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('5554654X','Carmen J','Trammell','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01572702','J Jerry','Uhl','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01572710','J Jerry','Uhl','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('01529890','Ilan','Vardi','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0830643273','Michael','Vernick','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('71709916','Kim','Walden','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('80400663','D W','Walker','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0262560674','Mitchell','Wand','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('34038190','Neil W','Webre','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('34092640','Neil W','Webre','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('34092640','Neil W','Webre','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9179420133','Paul N','Weinberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9157410127','Ragnar','Weinz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163409445','Ragnar','Weinz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163408201','Ragnar','Weinz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163408201','Ragnar','Weinz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163409445','Ulla Britt','Weinz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163408201','Ulla Britt','Weinz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9163408201','Ulla Britt','Weinz','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','Tommy','Welander','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','Tommy','Welander','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('649X','Tommy','Welander','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44303017','Torbjörn','Wiberg','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('411583','Lars','Wiktorin','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('0201184834','Leslie B','Wilson','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('9186201751','Bengt','Ydenius','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('8620002X','Rodnay','Zaks','0');
GO
INSERT INTO [dbo].[BAT]
           ([Isbn]
		   ,[FirstName]
           ,[LastName]
           ,[BirthYear])
     VALUES
           ('44444311','Björn','Östlund','0');
GO

/****************************************************************************************/

/********** Table BOOK_AUTHOR **********************************************************************************/
INSERT INTO [dbo].[BOOK_AUTHOR]
           ([Isbn]
		   ,[Aid])
	SELECT DISTINCT b.Isbn,a.Aid FROM AUTHOR AS a, BAT AS b
	WHERE a.FirstName = b.FirstName AND a.LastName = b.LastName AND a.BirthYear = b.BirthYear
GO

/********** Restore and remove temporary settings/tables *********************************************************/
DROP TABLE BAT;
GO

UPDATE [dbo].[AUTHOR] SET BirthYear = NULL WHERE BirthYear = '0';
GO
/****************************************************************************************/

/********** Table COPY *****************************************************************************************/

INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000000986',NULL,1,'9144294913');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000001018',NULL,1,'9144294913');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000003122',NULL,1,'914421541X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000003159',NULL,1,'9144300719');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000008775',NULL,1,'9140801594');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000008978',NULL,1,'9121588503');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000012607',NULL,1,'9144375913');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000012618',NULL,1,'912113684X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000020053',NULL,1,'9144461712');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000021130',NULL,1,'9144381913');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000024942',NULL,1,'9144384912');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000026195',NULL,1,'9144470010');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000026651',NULL,1,'914421541X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000026746',NULL,1,'0077076648');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000026958',NULL,1,'9163411911');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000029048',NULL,1,'9188734080');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000030813',NULL,1,'9921577115');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000030817',NULL,1,'9923950751');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000033652',NULL,1,'9920948454');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000034733',NULL,1,'9163603004');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000034760',NULL,1,'9163420252');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000034761',NULL,1,'9163420260');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000034766',NULL,1,'9163405156');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000034788',NULL,1,'0201526492');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000034789',NULL,1,'080537440X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000037531',NULL,1,'9144604114');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000037535',NULL,1,'1575210398');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000037543',NULL,1,'9186201379');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000037546',NULL,1,'9144613016');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000037581',NULL,1,'1883577004');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000037582',NULL,1,'013020207X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000037583',NULL,1,'156205533X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000038301',NULL,1,'1850321973');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000038319',NULL,1,'1878739158');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000038341',NULL,1,'0672305941');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039601',NULL,1,'9163602318');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039621',NULL,1,'9163602377');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039658',NULL,1,'9163411911');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039725',NULL,1,'9163602776');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039953',NULL,1,'9163603004');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039956',NULL,1,'9171972374');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039957',NULL,1,'9171972013');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039962',NULL,1,'0672300974');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000039965',NULL,1,'1556153953');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000045661',NULL,1,'1571690115');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000045686',NULL,1,'0890068658');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000045694',NULL,1,'9144000626');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000045703',NULL,1,'918886202X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000045775',NULL,1,'1558514880');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046206',NULL,1,'9188734080');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046227',NULL,1,'9923248305');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046711',NULL,1,'9163604345');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046727',NULL,1,'9144384912');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046730',NULL,1,'9170270937');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046838',NULL,1,'9924253248');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046839',NULL,1,'9924253248');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046842',NULL,1,'9924068696');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046843',NULL,1,'9924068696');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046866',NULL,1,'0471518026');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046868',NULL,1,'9144375913');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046870',NULL,1,'0201624397');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046871',NULL,1,'0070067317');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046873',NULL,1,'0070278938');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046887',NULL,1,'0805366814');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046891',NULL,1,'912158804X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046892',NULL,1,'0201142279');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046894',NULL,1,'9197115908');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046895',NULL,1,'9144300719');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046896',NULL,1,'9144461712');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046934',NULL,1,'9163604469');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046941',NULL,1,'0201847477');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046942',NULL,1,'0412788101');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046965',NULL,1,'0201403692');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046971',NULL,1,'9178717302');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046977',NULL,1,'917871687X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000046990',NULL,1,'086238091X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047014',NULL,1,'9147030097');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047070',NULL,1,'9163604698');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047071',NULL,1,'9163604663');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047072',NULL,1,'9163604701');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047423',NULL,1,'9188311279');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047431',NULL,1,'916360468X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047593',NULL,1,'9163420880');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047639',NULL,1,'9163604655');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047675',NULL,1,'0201403943');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047766',NULL,1,'1558515658');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047779',NULL,1,'1558284915');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047782',NULL,1,'9147000937');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047783',NULL,1,'9163604655');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047784',NULL,1,'9163604426');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047807',NULL,1,'0201134470');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000047808',NULL,1,'020142777X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000050513',NULL,1,'9920948454');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000050585',NULL,1,'9922819953');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000051759',NULL,1,'9144160879');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000059611',NULL,1,'0805322795');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000059726',NULL,1,'0201325632');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000059864',NULL,1,'0070410348');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000060039',NULL,1,'9163604434');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000060068',NULL,1,'157169109X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074349',NULL,1,'9144002920');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074350',NULL,1,'9144267312');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074353',NULL,1,'9144221819');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074359',NULL,1,'9163604450');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074378',NULL,1,'9916008507');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074387',NULL,1,'9144005180');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074403',NULL,1,'9188311570');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074414',NULL,1,'9144005180');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074425',NULL,1,'0471976555');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074426',NULL,1,'0201571641');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074427',NULL,1,'9144342217');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074456',NULL,1,'9188734080');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074460',NULL,1,'914400219X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074461',NULL,1,'916301310X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074474',NULL,1,'9163604795');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074477',NULL,1,'9163604779');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000074478',NULL,1,'9157800383');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000081856',NULL,1,'0672310228');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000081966',NULL,1,'0201835959');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000081973',NULL,1,'9163604426');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000082033',NULL,1,'1572315652');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084790',NULL,1,'9144004125');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084859',NULL,1,'0131214845');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084864',NULL,1,'9924479831');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084901',NULL,1,'1572315105');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084907',NULL,1,'0077090764');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084931',NULL,1,'1572313404');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084940',NULL,1,'914421541X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084944',NULL,1,'0890069190');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084946',NULL,1,'0201889544');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084951',NULL,1,'9144470010');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084966',NULL,1,'9163024837');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084971',NULL,1,'9178824133');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000084999',NULL,1,'0810465655');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085001',NULL,1,'0070490678');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085020',NULL,1,'0805306005');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085021',NULL,1,'1884842712');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085027',NULL,1,'0137758006');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085031',NULL,1,'9163604965');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085044',NULL,1,'0201103931');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085078',NULL,1,'9144006268');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085102',NULL,1,'9924316797');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085130',NULL,1,'0201309947');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085374',NULL,1,'9178824230');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085376',NULL,1,'9163604744');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085382',NULL,1,'9178824176');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085391',NULL,1,'0078815037');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085403',NULL,1,'1572314400');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085419',NULL,1,'0136542867');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085424',NULL,1,'0937073172');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085426',NULL,1,'0201545411');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085478',NULL,1,'0201530678');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085496',NULL,1,'0201060892');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085577',NULL,1,'1555581951');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085588',NULL,1,'0070246459');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085590',NULL,1,'1565922700');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085591',NULL,1,'0201542625');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085594',NULL,1,'1572313315');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085631',NULL,1,'915061181X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085640',NULL,1,'9171531483');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085647',NULL,1,'0201546647');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085649',NULL,1,'0078824613');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085652',NULL,1,'0120499428');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085653',NULL,1,'0133374866');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085655',NULL,1,'0136609112');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085658',NULL,1,'3540609547');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085663',NULL,1,'0201310139');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085664',NULL,1,'007034678X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085669',NULL,1,'9905775390');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085673',NULL,1,'9150611771');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085674',NULL,1,'9150611771');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000085677',NULL,1,'9171534563');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086016',NULL,1,'9150612158');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086017',NULL,1,'0792399714');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086031',NULL,1,'0201064677');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086041',NULL,1,'1558285342');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086045',NULL,1,'1850323011');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086102',NULL,1,'012326426X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086103',NULL,1,'916360454X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086104',NULL,1,'9163604795');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086105',NULL,1,'9163604795');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086107',NULL,1,'0672310481');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086116',NULL,1,'0137994532');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086122',NULL,1,'9144006934');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086123',NULL,1,'9144007361');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086128',NULL,1,'9163604973');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086129',NULL,1,'9163604973');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086130',NULL,1,'9163604973');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086137',NULL,1,'9163604736');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086138',NULL,1,'9163604736');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086459',NULL,1,'0849378362');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086462',NULL,1,'9924479890');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086467',NULL,1,'9924880048');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086468',NULL,1,'9150612174');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086480',NULL,1,'952120074X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086743',NULL,1,'0138504547');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086745',NULL,1,'9925133521');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086765',NULL,1,'9140624935');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086860',NULL,1,'9925157951');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000086943',NULL,1,'9144381913');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000087592',NULL,1,'081763911X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000087947',NULL,1,'9188311333');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000089058',NULL,1,'0132366134');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000091498',NULL,1,'9163604744');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093500',NULL,1,'9163604426');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093501',NULL,1,'9163605031');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093504',NULL,1,'9163604450');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093505',NULL,1,'0471147672');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093507',NULL,1,'0133374866');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093508',NULL,1,'0471191612');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093509',NULL,1,'9144005997');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093518',NULL,1,'9171624058');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093526',NULL,1,'0120455951');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093527',NULL,1,'0137488807');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093535',NULL,1,'9163604825');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093536',NULL,1,'1556159005');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093538',NULL,1,'9922731630');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093544',NULL,1,'9164401626');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093553',NULL,1,'9121588503');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093557',NULL,1,'1572313587');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093558',NULL,1,'9163604736');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093559',NULL,1,'9163604736');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093560',NULL,1,'0201309955');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093570',NULL,1,'9925123852');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093576',NULL,1,'9140800946');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093578',NULL,1,'9140801594');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093584',NULL,1,'9164401472');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093586',NULL,1,'0471578533');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093590',NULL,1,'9144252315');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093591',NULL,1,'914400219X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093592',NULL,1,'914400219X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093593',NULL,1,'0137696396');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093594',NULL,1,'013591793X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093595',NULL,1,'0471180041');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093596',NULL,1,'9188311457');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093607',NULL,1,'0070062722');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093610',NULL,1,'9147035099');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093631',NULL,1,'1575213036');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093632',NULL,1,'0131829572');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093639',NULL,1,'9144004567');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093640',NULL,1,'9144294913');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093649',NULL,1,'9140801551');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093659',NULL,1,'9171537007');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093702',NULL,1,'9924479866');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093705',NULL,1,'9163604833');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093707',NULL,1,'013727405X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093710',NULL,1,'9188972348');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093720',NULL,1,'0471958204');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093722',NULL,1,'0672310228');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093735',NULL,1,'9163604876');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093736',NULL,1,'9177384350');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093743',NULL,1,'9163604760');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093744',NULL,1,'9163604760');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093755',NULL,1,'9147035129');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093767',NULL,1,'9163604760');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093769',NULL,1,'9144006810');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093771',NULL,1,'9922731614');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093778',NULL,1,'9123014024');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093780',NULL,1,'918831166X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093790',NULL,1,'9188311597');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093804',NULL,1,'9188690210');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000093805',NULL,1,'9188311236');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000096612',NULL,1,'9188311821');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000096615',NULL,1,'9187026384');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000103037',NULL,1,'9521201924');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000103038',NULL,1,'9521201924');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000104896',NULL,1,'9144342926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000104925',NULL,1,'1571690840');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('11577000104984',NULL,1,'1568304102');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000009',NULL,1,'0954');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000061',NULL,1,'44309910');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000411',NULL,1,'315317');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000535',NULL,1,'9179420133');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000568',NULL,1,'44439210');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000569',NULL,1,'44444311');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000571',NULL,1,'44114818');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000592',NULL,1,'86200917');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000593',NULL,1,'56151659');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000725',NULL,1,'9172200529');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000736',NULL,1,'9186200240');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000807',NULL,1,'9138610248');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000834',NULL,1,'34092640');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000849',NULL,1,'0243');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000852',NULL,1,'79420478');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000853',NULL,1,'79420478');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000878',NULL,1,'79420478');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000889',NULL,1,'1705');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000989',NULL,1,'44196822');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000000990',NULL,1,'44195443');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000001317',NULL,1,'44151926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000001661',NULL,1,'44151926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000001691',NULL,1,'44303017');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000001725',NULL,1,'44151926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000001726',NULL,1,'44151926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000001727',NULL,1,'1705');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000002096',NULL,1,'24345768');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000002097',NULL,1,'24345768');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000002098',NULL,1,'0079310125');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000002099',NULL,1,'0079310125');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000002393',NULL,1,'1705');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000002636',NULL,1,'86656376');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000002813',NULL,1,'884475');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003007',NULL,1,'7587');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003010',NULL,1,'1410');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003011',NULL,1,'44196822');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003090',NULL,1,'3944');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003123',NULL,1,'292813');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003139',NULL,1,'44439210');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003140',NULL,1,'44439210');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003147',NULL,1,'291019');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003173',NULL,1,'9144183313');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003209',NULL,1,'9152403645');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003210',NULL,1,'44168411');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003212',NULL,1,'73825875');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003220',NULL,1,'9144183313');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003232',NULL,1,'9157410127');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003237',NULL,1,'425511');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003286',NULL,1,'34038190');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003296',NULL,1,'03808285');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003297',NULL,1,'44264615');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003319',NULL,1,'9144146019');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003320',NULL,1,'6947');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003419',NULL,1,'8620002X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003420',NULL,1,'9144402724');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003421',NULL,1,'9186064045');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003422',NULL,1,'9186064002');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003429',NULL,1,'44439210');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003488',NULL,1,'71709916');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003604',NULL,1,'40552004');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003606',NULL,1,'9138610191');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003608',NULL,1,'9144282613');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003716',NULL,1,'80400663');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000003911',NULL,1,'9172200529');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004111',NULL,1,'44195443');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004163',NULL,1,'42285329');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004237',NULL,1,'44151926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004238',NULL,1,'44151926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004410',NULL,1,'40802434');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004411',NULL,1,'9179420214');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004534',NULL,1,'62382327');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004539',NULL,1,'6947');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004738',NULL,1,'63531806');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000004802',NULL,1,'0954');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000005131',NULL,1,'79420028');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000005431',NULL,1,'1453');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000005528',NULL,1,'34092640');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000005530',NULL,1,'9138610248');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000005556',NULL,1,'87026155');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000005557',NULL,1,'87026155');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000006076',NULL,1,'9121588384');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000006269',NULL,1,'44196822');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000006310',NULL,1,'44151934');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000006561',NULL,1,'028038');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000006589',NULL,1,'9172583266');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000006856',NULL,1,'87026155');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000006857',NULL,1,'87026155');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000007388',NULL,1,'649X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000007404',NULL,1,'23630590');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000007466',NULL,1,'9186656430');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000008876',NULL,1,'866X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000009316',NULL,1,'5808');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000009633',NULL,1,'649X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000009742',NULL,1,'31103628');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000009743',NULL,1,'31103628');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010002',NULL,1,'9121588384');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010022',NULL,1,'01548895');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010039',NULL,1,'479257');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010066',NULL,1,'9144297912');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010069',NULL,1,'88436020');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010070',NULL,1,'88436020');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010233',NULL,1,'651X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010460',NULL,1,'86656511');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010464',NULL,1,'44359918');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010467',NULL,1,'01572869');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010699',NULL,1,'649X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010789',NULL,1,'9172201975');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000010991',NULL,1,'37175714');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011009',NULL,1,'3243');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011054',NULL,1,'9170990379');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011055',NULL,1,'9170990387');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011061',NULL,1,'8015');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011105',NULL,1,'9170990409');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011106',NULL,1,'9170990360');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011107',NULL,1,'9170990476');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011108',NULL,1,'9170990395');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000011109',NULL,1,'9170990484');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012258',NULL,1,'21128995');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012413',NULL,1,'410218');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012421',NULL,1,'0078816912');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012455',NULL,1,'31097032');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012459',NULL,1,'32017571');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012480',NULL,1,'05321667');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012481',NULL,1,'0201510596');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012482',NULL,1,'0201184834');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012483',NULL,1,'01539926');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000012595',NULL,1,'0201581124');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000014644',NULL,1,'9186201751');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000014722',NULL,1,'0201038099');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000014775',NULL,1,'9144365918');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000014988',NULL,1,'01529890');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000014990',NULL,1,'528185');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000014992',NULL,1,'01572710');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000014993',NULL,1,'01572702');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000017298',NULL,1,'411583');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000017299',NULL,1,'9152411621');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000017689',NULL,1,'9186656597');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000018389',NULL,1,'866X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000020095',NULL,1,'1918');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000020584',NULL,1,'05309039');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021120',NULL,1,'9186201476');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021121',NULL,1,'602083');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021145',NULL,1,'9188310132');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021170',NULL,1,'380712');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021198',NULL,1,'9186201905');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021507',NULL,1,'0262560674');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021905',NULL,1,'9144384416');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021920',NULL,1,'0201543303');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000021921',NULL,1,'01548488');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000022428',NULL,1,'79791574');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000022436',NULL,1,'0136632041');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000022561',NULL,1,'60213X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000022565',NULL,1,'9163409410');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000022576',NULL,1,'9163602636');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000022577',NULL,1,'602148');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000022862',NULL,1,'97029645');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000023348',NULL,1,'0201608669');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000023349',NULL,1,'9121127816');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024218',NULL,1,'1453');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024269',NULL,1,'1558512969');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024270',NULL,1,'9163404575');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024272',NULL,1,'662150');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024558',NULL,1,'080530911X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024562',NULL,1,'0136630146');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024575',NULL,1,'9144365918');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024588',NULL,1,'01416778');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000024739',NULL,1,'78739166');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026363',NULL,1,'0201514591');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026366',NULL,1,'563649');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026478',NULL,1,'9172583266');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026679',NULL,1,'9163408201');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026680',NULL,1,'9163408201');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026681',NULL,1,'9163409453');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026707',NULL,1,'0136301045');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026708',NULL,1,'31551515');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026744',NULL,1,'0132888955');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026745',NULL,1,'72304406');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026747',NULL,1,'0201563452');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026901',NULL,1,'0672301687');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026906',NULL,1,'916360230X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026947',NULL,1,'9144479719');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000026954',NULL,1,'9144476310');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027504',NULL,1,'7155829X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027509',NULL,1,'0070328137');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027510',NULL,1,'0442008635');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027515',NULL,1,'0201422948');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027526',NULL,1,'1558512160');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027536',NULL,1,'9163409445');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027550',NULL,1,'87941940');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027552',NULL,1,'0201581124');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027555',NULL,1,'60308X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000027590',NULL,1,'3574');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000028161',NULL,1,'9163409399');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000028183',NULL,1,'0137538154');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000028214',NULL,1,'9163602962');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000028869',NULL,1,'9186656686');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000028870',NULL,1,'881X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000028871',NULL,1,'74980890');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000028984',NULL,1,'1556156502');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000029013',NULL,1,'0078818095');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000029015',NULL,1,'0201608286');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000029091',NULL,1,'0132038374');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000029282',NULL,1,'917871513X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000029590',NULL,1,'0070425930');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000030740',NULL,1,'88310906');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000032618',NULL,1,'0734');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000032619',NULL,1,'0734');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000032620',NULL,1,'0734');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000033610',NULL,1,'32908670');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000033618',NULL,1,'72202483');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000033648',NULL,1,'9163603233');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034068',NULL,1,'88310906');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034069',NULL,1,'9163420066');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034092',NULL,1,'5097');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034379',NULL,1,'6241');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034383',NULL,1,'020148952X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034386',NULL,1,'1562055089');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034396',NULL,1,'1884842100');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034732',NULL,1,'70270635');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034734',NULL,1,'9144605110');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000034735',NULL,1,'9144605110');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000037530',NULL,1,'44359918');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000038314',NULL,1,'5554654X');
GO
INSERT INTO [dbo].[COPY]
           ([Barcode]
           ,[Location]
           ,[StatusId]
           ,[ISBN])
     VALUES
           ('1577000081399',NULL,1,'0830643273');
GO
/****************************************************************************************/
/******************** Update location and library in table Copy ************************/
UPDATE [dbo].[copy]
	SET location = 'Pubdbz OS 12',library = 'Huskvarna' WHERE barcode ='11577000000986';
GO
UPDATE [dbo].[copy]
	SET location = 'Referens',library = 'Huskvarna' WHERE barcode ='11577000001018';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='11577000003122';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000003159';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz dBASE',library = 'Taberg' WHERE barcode ='11577000008775';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Taberg' WHERE barcode ='11577000008978';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000012607';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000012618';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000020053';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000021130';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000024942';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Taberg' WHERE barcode ='11577000026195';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='11577000026651';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Taberg' WHERE barcode ='11577000026746';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz PowerPoint',library = 'Huskvarna' WHERE barcode ='11577000026958';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='11577000029048';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdi',library = 'Huskvarna' WHERE barcode ='11577000030813';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000030817';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdk',library = 'Taberg' WHERE barcode ='11577000033652';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Windows 95',library = 'Taberg' WHERE barcode ='11577000034733';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Word',library = 'Huskvarna' WHERE barcode ='11577000034760';
GO
UPDATE [dbo].[copy]
	SET location = 'Referens',library = 'Huskvarna' WHERE barcode ='11577000034761';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Windows',library = 'Taberg' WHERE barcode ='11577000034766';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Huskvarna' WHERE barcode ='11577000034788';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Huskvarna' WHERE barcode ='11577000034789';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='11577000037531';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000037535';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz QBASIC',library = 'Taberg' WHERE barcode ='11577000037543';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='11577000037546';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000037581';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000037582';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000037583';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='11577000038301';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000038319';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000038341';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Works',library = 'Taberg' WHERE barcode ='11577000039601';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz WordPerfect',library = 'Taberg' WHERE barcode ='11577000039621';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz PowerPoint',library = 'Huskvarna' WHERE barcode ='11577000039658';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Taberg' WHERE barcode ='11577000039725';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Windows 95',library = 'Taberg' WHERE barcode ='11577000039953';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Taberg' WHERE barcode ='11577000039956';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Huskvarna' WHERE barcode ='11577000039957';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000039962';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000039965';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000045661';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000045686';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Delphi',library = 'Taberg' WHERE barcode ='11577000045694';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000045703';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VBScript',library = 'Taberg' WHERE barcode ='11577000045775';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='11577000046206';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Taberg' WHERE barcode ='11577000046227';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Windows 95',library = 'Taberg' WHERE barcode ='11577000046711';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000046727';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Huskvarna' WHERE barcode ='11577000046730';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000046838';
GO
UPDATE [dbo].[copy]
	SET location = 'Magasin',library = 'Huskvarna' WHERE barcode ='11577000046839';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000046842';
GO
UPDATE [dbo].[copy]
	SET location = 'Referens',library = 'Huskvarna' WHERE barcode ='11577000046843';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000046866';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000046868';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000046870';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PROLOG',library = 'Taberg' WHERE barcode ='11577000046871';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='11577000046873';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PROLOG',library = 'Stadsbiblioteket' WHERE barcode ='11577000046887';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PASCAL',library = 'Stadsbiblioteket' WHERE barcode ='11577000046891';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz ADA',library = 'Taberg' WHERE barcode ='11577000046892';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz ADA',library = 'Stadsbiblioteket' WHERE barcode ='11577000046894';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000046895';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000046896';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Taberg' WHERE barcode ='11577000046934';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdk',library = 'Huskvarna' WHERE barcode ='11577000046941';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000046942';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000046965';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Taberg' WHERE barcode ='11577000046971';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000046977';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000046990';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz MicrosoftOffice',library = 'Stadsbiblioteket' WHERE barcode ='11577000047014';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz MicrosoftOffice',library = 'Huskvarna' WHERE barcode ='11577000047070';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Huskvarna' WHERE barcode ='11577000047071';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz PowerPoint',library = 'Huskvarna' WHERE barcode ='11577000047072';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Huskvarna' WHERE barcode ='11577000047423';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Huskvarna' WHERE barcode ='11577000047431';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Taberg' WHERE barcode ='11577000047593';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='11577000047639';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Taberg' WHERE barcode ='11577000047675';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualC',library = 'Stadsbiblioteket' WHERE barcode ='11577000047766';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Linux',library = 'Huskvarna' WHERE barcode ='11577000047779';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='11577000047782';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='11577000047783';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz JavaScript',library = 'Huskvarna' WHERE barcode ='11577000047784';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz TEX',library = 'Stadsbiblioteket' WHERE barcode ='11577000047807';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz LATEX',library = 'Huskvarna' WHERE barcode ='11577000047808';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdk',library = 'Taberg' WHERE barcode ='11577000050513';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Taberg' WHERE barcode ='11577000050585';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000051759';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000059611';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000059726';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='11577000059864';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Photoshop',library = 'Huskvarna' WHERE barcode ='11577000060039';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='11577000060068';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz SPSS',library = 'Taberg' WHERE barcode ='11577000074349';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Taberg' WHERE barcode ='11577000074350';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Ada',library = 'Stadsbiblioteket' WHERE barcode ='11577000074353';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Office',library = 'Huskvarna' WHERE barcode ='11577000074359';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000074378';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Pascal',library = 'Huskvarna' WHERE barcode ='11577000074387';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz WindowsNT',library = 'Taberg' WHERE barcode ='11577000074403';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Pascal',library = 'Huskvarna' WHERE barcode ='11577000074414';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Stadsbiblioteket' WHERE barcode ='11577000074425';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000074426';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000074427';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='11577000074456';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Taberg' WHERE barcode ='11577000074460';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz WordforWindows',library = 'Taberg' WHERE barcode ='11577000074461';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Frontpage',library = 'Stadsbiblioteket' WHERE barcode ='11577000074474';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000074477';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Huskvarna' WHERE barcode ='11577000074478';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='11577000081856';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000081966';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz JavaScript',library = 'Huskvarna' WHERE barcode ='11577000081973';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualC',library = 'Huskvarna' WHERE barcode ='11577000082033';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz13 D StudioMAX',library = 'Huskvarna' WHERE barcode ='11577000084790';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Windows295',library = 'Taberg' WHERE barcode ='11577000084859';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000084864';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualC',library = 'Huskvarna' WHERE barcode ='11577000084901';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000084907';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Huskvarna' WHERE barcode ='11577000084931';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='11577000084940';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000084944';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='11577000084946';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Taberg' WHERE barcode ='11577000084951';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds REF',library = 'Taberg' WHERE barcode ='11577000084966';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Huskvarna' WHERE barcode ='11577000084971';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000084999';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Paradox',library = 'Huskvarna' WHERE barcode ='11577000085001';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Ada',library = 'Taberg' WHERE barcode ='11577000085020';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='11577000085021';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='11577000085027';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualC',library = 'Huskvarna' WHERE barcode ='11577000085031';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000085044';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000085078';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000085102';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000085130';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Huskvarna' WHERE barcode ='11577000085374';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000085376';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz LotusNotes',library = 'Huskvarna' WHERE barcode ='11577000085382';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz dBASE',library = 'Stadsbiblioteket' WHERE barcode ='11577000085391';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz MicrosoftOffice',library = 'Huskvarna' WHERE barcode ='11577000085403';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000085419';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PROLOG',library = 'Taberg' WHERE barcode ='11577000085424';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Taberg' WHERE barcode ='11577000085426';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='11577000085478';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdb',library = 'Huskvarna' WHERE barcode ='11577000085496';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Taberg' WHERE barcode ='11577000085577';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='11577000085588';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000085590';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdb',library = 'Huskvarna' WHERE barcode ='11577000085591';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000085594';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PROLOG',library = 'Stadsbiblioteket' WHERE barcode ='11577000085631';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Huskvarna' WHERE barcode ='11577000085640';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='11577000085647';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Linux',library = 'Huskvarna' WHERE barcode ='11577000085649';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='11577000085652';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Taberg' WHERE barcode ='11577000085653';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000085655';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000085658';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000085663';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000085664';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000085669';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PROLOG',library = 'Stadsbiblioteket' WHERE barcode ='11577000085673';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PROLOG',library = 'Stadsbiblioteket' WHERE barcode ='11577000085674';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000085677';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='11577000086016';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000086017';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PROLOG',library = 'Taberg' WHERE barcode ='11577000086031';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz QuarkXPress',library = 'Taberg' WHERE barcode ='11577000086041';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000086045';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Taberg' WHERE barcode ='11577000086102';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Huskvarna' WHERE barcode ='11577000086103';
GO
UPDATE [dbo].[copy]
	SET location = 'Referens',library = 'Stadsbiblioteket' WHERE barcode ='11577000086104';
GO
UPDATE [dbo].[copy]
	SET location = 'Magasin',library = 'Stadsbiblioteket' WHERE barcode ='11577000086105';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Taberg' WHERE barcode ='11577000086107';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='11577000086116';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000086122';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000086123';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000086128';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000086129';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000086130';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz WindowsNT',library = 'Taberg' WHERE barcode ='11577000086137';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz WindowsNT',library = 'Taberg' WHERE barcode ='11577000086138';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='11577000086459';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdk',library = 'Taberg' WHERE barcode ='11577000086462';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='11577000086467';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000086468';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000086480';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000086743';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdi',library = 'Stadsbiblioteket' WHERE barcode ='11577000086745';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Windows',library = 'Huskvarna' WHERE barcode ='11577000086765';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000086860';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000086943';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdi',library = 'Stadsbiblioteket' WHERE barcode ='11577000087592';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz WindowsNT',library = 'Huskvarna' WHERE barcode ='11577000087947';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='11577000089058';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000091498';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz JavaScript',library = 'Huskvarna' WHERE barcode ='11577000093500';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Word',library = 'Stadsbiblioteket' WHERE barcode ='11577000093501';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Office',library = 'Huskvarna' WHERE barcode ='11577000093504';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Huskvarna' WHERE barcode ='11577000093505';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Taberg' WHERE barcode ='11577000093507';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000093508';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz LotusNotes',library = 'Huskvarna' WHERE barcode ='11577000093509';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Huskvarna' WHERE barcode ='11577000093518';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Huskvarna' WHERE barcode ='11577000093526';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='11577000093527';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Photoshop',library = 'Huskvarna' WHERE barcode ='11577000093535';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000093536';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000093538';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000093544';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz dBASE',library = 'Taberg' WHERE barcode ='11577000093553';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Huskvarna' WHERE barcode ='11577000093557';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz WindowsNT',library = 'Taberg' WHERE barcode ='11577000093558';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz WindowsNT',library = 'Taberg' WHERE barcode ='11577000093559';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000093560';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='11577000093570';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz dBASE',library = 'Stadsbiblioteket' WHERE barcode ='11577000093576';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz dBASE',library = 'Taberg' WHERE barcode ='11577000093578';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz WindowsNT',library = 'Huskvarna' WHERE barcode ='11577000093584';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000093586';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Ada',library = 'Stadsbiblioteket' WHERE barcode ='11577000093590';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Taberg' WHERE barcode ='11577000093591';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Taberg' WHERE barcode ='11577000093592';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000093593';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000093594';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Huskvarna' WHERE barcode ='11577000093595';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Huskvarna' WHERE barcode ='11577000093596';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='11577000093607';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Huskvarna' WHERE barcode ='11577000093610';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Java',library = 'Taberg' WHERE barcode ='11577000093631';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Taberg' WHERE barcode ='11577000093632';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Delphi',library = 'Taberg' WHERE barcode ='11577000093639';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz OS 12',library = 'Huskvarna' WHERE barcode ='11577000093640';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz dBASE',library = 'Huskvarna' WHERE barcode ='11577000093649';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdk',library = 'Stadsbiblioteket' WHERE barcode ='11577000093659';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='11577000093702';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Frontpage',library = 'Huskvarna' WHERE barcode ='11577000093705';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000093707';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Photoshop',library = 'Huskvarna' WHERE barcode ='11577000093710';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='11577000093720';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='11577000093722';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz JavaScript',library = 'Huskvarna' WHERE barcode ='11577000093735';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Huskvarna' WHERE barcode ='11577000093736';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Huskvarna' WHERE barcode ='11577000093743';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Huskvarna' WHERE barcode ='11577000093744';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Huskvarna' WHERE barcode ='11577000093755';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Huskvarna' WHERE barcode ='11577000093767';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='11577000093769';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Taberg' WHERE barcode ='11577000093771';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Word',library = 'Taberg' WHERE barcode ='11577000093778';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz VisualBASIC',library = 'Taberg' WHERE barcode ='11577000093780';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz AktiveX',library = 'Stadsbiblioteket' WHERE barcode ='11577000093790';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Schedule',library = 'Taberg' WHERE barcode ='11577000093804';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Huskvarna' WHERE barcode ='11577000093805';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz FrontPage',library = 'Huskvarna' WHERE barcode ='11577000096612';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='11577000096615';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Taberg' WHERE barcode ='11577000103037';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Taberg' WHERE barcode ='11577000103038';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz UNIX',library = 'Taberg' WHERE barcode ='11577000104896';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz JavaScript',library = 'Huskvarna' WHERE barcode ='11577000104925';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Illustrator',library = 'Taberg' WHERE barcode ='11577000104984';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000000061';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz UNIX',library = 'Stadsbiblioteket' WHERE barcode ='1577000000535';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000000568';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000000569';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000000571';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='1577000000592';
GO
UPDATE [dbo].[copy]
	SET location = 'Referens',library = 'Stadsbiblioteket' WHERE barcode ='1577000000593';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000000725';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz DOS',library = 'Stadsbiblioteket' WHERE barcode ='1577000000736';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz COBOL',library = 'Stadsbiblioteket' WHERE barcode ='1577000000807';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Pascal',library = 'Stadsbiblioteket' WHERE barcode ='1577000000834';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PASCAL',library = 'Huskvarna' WHERE barcode ='1577000000849';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz DOS',library = 'Stadsbiblioteket' WHERE barcode ='1577000000852';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz DOS',library = 'Stadsbiblioteket' WHERE barcode ='1577000000853';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz DOS',library = 'Stadsbiblioteket' WHERE barcode ='1577000000878';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000000989';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000000990';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000001317';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000001661';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000001691';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000001725';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000001726';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000002098';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000002099';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000002636';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000002813';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PASCAL',library = 'Huskvarna' WHERE barcode ='1577000003007';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003011';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003139';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003140';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000003173';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003209';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000003210';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003212';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000003220';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003232';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000003237';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000003286';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000003296';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000003297';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003319';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000003320';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz CP M',library = 'Stadsbiblioteket' WHERE barcode ='1577000003419';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000003420';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz BASIC',library = 'Stadsbiblioteket' WHERE barcode ='1577000003421';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz BASIC',library = 'Stadsbiblioteket' WHERE barcode ='1577000003422';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003429';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='1577000003488';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000003604';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdi',library = 'Stadsbiblioteket' WHERE barcode ='1577000003606';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003608';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000003716';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000003911';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000004111';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000004163';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000004237';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000004238';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PASCAL',library = 'Stadsbiblioteket' WHERE barcode ='1577000004410';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz OS 12',library = 'Stadsbiblioteket' WHERE barcode ='1577000004411';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='1577000004534';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000004539';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000004738';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz MS DOS',library = 'Stadsbiblioteket' WHERE barcode ='1577000005131';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='1577000005431';
GO
UPDATE [dbo].[copy]
	SET location = 'Referens',library = 'Stadsbiblioteket' WHERE barcode ='1577000005528';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz COBOL',library = 'Stadsbiblioteket' WHERE barcode ='1577000005530';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000005556';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000005557';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz DOS',library = 'Stadsbiblioteket' WHERE barcode ='1577000006076';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000006269';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000006310';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000006561';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000006589';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000006856';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000006857';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000007388';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000007466';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PASCAL',library = 'Huskvarna' WHERE barcode ='1577000008876';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000009316';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000009633';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='1577000009742';
GO
UPDATE [dbo].[copy]
	SET location = 'Magasin',library = 'Stadsbiblioteket' WHERE barcode ='1577000009743';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz DOS',library = 'Stadsbiblioteket' WHERE barcode ='1577000010002';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz OS 12',library = 'Stadsbiblioteket' WHERE barcode ='1577000010022';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Eiffel',library = 'Stadsbiblioteket' WHERE barcode ='1577000010039';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000010066';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000010069';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000010070';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Filemaker',library = 'Stadsbiblioteket' WHERE barcode ='1577000010233';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000010460';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000010464';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000010467';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000010699';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000010789';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000010991';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000011054';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000011055';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Huskvarna' WHERE barcode ='1577000011061';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000011105';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000011106';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000011107';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000011108';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000011109';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000012413';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='1577000012421';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='1577000012480';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000012481';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000012482';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000012483';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000012595';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Stadsbiblioteket' WHERE barcode ='1577000014644';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000014722';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Word',library = 'Stadsbiblioteket' WHERE barcode ='1577000014775';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Mathematica',library = 'Stadsbiblioteket' WHERE barcode ='1577000014988';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Mathematica',library = 'Stadsbiblioteket' WHERE barcode ='1577000014990';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Mathematica',library = 'Stadsbiblioteket' WHERE barcode ='1577000014992';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Mathematica',library = 'Stadsbiblioteket' WHERE barcode ='1577000014993';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000017298';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000017299';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000017689';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz PASCAL',library = 'Huskvarna' WHERE barcode ='1577000018389';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='1577000020095';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000020584';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000021120';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000021121';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='1577000021145';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Stadsbiblioteket' WHERE barcode ='1577000021198';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000021507';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000021905';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000021920';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000021921';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Pascal',library = 'Stadsbiblioteket' WHERE barcode ='1577000022428';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000022436';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000022561';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Stadsbiblioteket' WHERE barcode ='1577000022565';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz CorelDRAW',library = 'Stadsbiblioteket' WHERE barcode ='1577000022576';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000022577';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='1577000022862';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000023348';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Windows',library = 'Stadsbiblioteket' WHERE barcode ='1577000023349';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='1577000024218';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Paradox',library = 'Stadsbiblioteket' WHERE barcode ='1577000024269';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Stadsbiblioteket' WHERE barcode ='1577000024270';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='1577000024272';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000024558';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000024562';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Word',library = 'Stadsbiblioteket' WHERE barcode ='1577000024575';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdb',library = 'Stadsbiblioteket' WHERE barcode ='1577000024588';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000024739';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000026363';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000026366';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000026478';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000026679';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000026680';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Stadsbiblioteket' WHERE barcode ='1577000026681';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000026707';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubd',library = 'Stadsbiblioteket' WHERE barcode ='1577000026708';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000026744';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='1577000026745';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Huskvarna' WHERE barcode ='1577000026747';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C',library = 'Stadsbiblioteket' WHERE barcode ='1577000026901';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdhz Access',library = 'Stadsbiblioteket' WHERE barcode ='1577000026906';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000026947';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000026954';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000027504';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000027509';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000027510';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000027515';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000027526';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000027536';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000027550';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000027552';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000027555';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000027590';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000028161';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000028183';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdz Excel',library = 'Stadsbiblioteket' WHERE barcode ='1577000028214';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000028869';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz FORTRAN',library = 'Stadsbiblioteket' WHERE barcode ='1577000028870';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000028871';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000028984';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000029013';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Visual Basic',library = 'Stadsbiblioteket' WHERE barcode ='1577000029015';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000029091';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000029282';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000029590';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Delphi',library = 'Stadsbiblioteket' WHERE barcode ='1577000030740';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='1577000032618';
GO
UPDATE [dbo].[copy]
	SET location = 'Referens',library = 'Huskvarna' WHERE barcode ='1577000032619';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Huskvarna' WHERE barcode ='1577000032620';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdh',library = 'Stadsbiblioteket' WHERE barcode ='1577000033610';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000033618';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Windows 95',library = 'Stadsbiblioteket' WHERE barcode ='1577000033648';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Delphi',library = 'Stadsbiblioteket' WHERE barcode ='1577000034068';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz Windows 95',library = 'Stadsbiblioteket' WHERE barcode ='1577000034069';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz Visual Basic',library = 'Huskvarna' WHERE barcode ='1577000034092';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Huskvarna' WHERE barcode ='1577000034379';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubdbz UNIX',library = 'Stadsbiblioteket' WHERE barcode ='1577000034383';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubds',library = 'Stadsbiblioteket' WHERE barcode ='1577000034386';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000034396';
GO
UPDATE [dbo].[copy]
	SET location = 'Pub',library = 'Stadsbiblioteket' WHERE barcode ='1577000034732';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000034734';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000034735';
GO
UPDATE [dbo].[copy]
	SET location = 'Puba',library = 'Stadsbiblioteket' WHERE barcode ='1577000037530';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubb',library = 'Stadsbiblioteket' WHERE barcode ='1577000038314';
GO
UPDATE [dbo].[copy]
	SET location = 'Pubbz C++',library = 'Stadsbiblioteket' WHERE barcode ='1577000081399';
GO
/****************************************************************************************/
/********** Table BORROW *************************************************************************************/

INSERT INTO [dbo].[BORROW]
           ([Barcode]
           ,[PersonId]
           ,[BorrowDate]
           ,[ToBeReturnedDate]
           ,[ReturnDate])
     VALUES
           ('11577000026746','19630328-2267','Feb  2 2000 12:00AM','Mar  2 2000 12:00AM','Mar 10 2000 12:00AM'); 
GO
INSERT INTO [dbo].[BORROW]
           ([Barcode]
           ,[PersonId]
           ,[BorrowDate]
           ,[ToBeReturnedDate]
           ,[ReturnDate])
     VALUES
           ('11577000026746','19790229-1116','Oct  1 1999 12:00AM','Nov  1 1999 12:00AM','Dec 10 1999 12:00AM'); 
GO
INSERT INTO [dbo].[BORROW]
           ([Barcode]
           ,[PersonId]
           ,[BorrowDate]
           ,[ToBeReturnedDate]
           ,[ReturnDate])
     VALUES
           ('11577000085594','19111111-1111','Sep 20 1999 12:00AM','Oct 20 1999 12:00AM','Oct 19 1999 12:00AM'); 
GO
INSERT INTO [dbo].[BORROW]
           ([Barcode]
           ,[PersonId]
           ,[BorrowDate]
           ,[ToBeReturnedDate]
           ,[ReturnDate])
     VALUES
           ('11577000085594','19630328-2267','Feb  2 2000 12:00AM','Mar  2 2000 12:00AM','Mar 10 2000 12:00AM'); 
GO
INSERT INTO [dbo].[BORROW]
           ([Barcode]
           ,[PersonId]
           ,[BorrowDate]
           ,[ToBeReturnedDate]
           ,[ReturnDate])
     VALUES
           ('11577000093805','19630328-2267','Feb  2 2000 12:00AM','Mar  2 2000 12:00AM','Mar 10 2000 12:00AM'); 
GO
INSERT INTO [dbo].[BORROW]
           ([Barcode]
           ,[PersonId]
           ,[BorrowDate]
           ,[ToBeReturnedDate]
           ,[ReturnDate])
     VALUES
           ('11577000093805','19920227-5468','Oct  2 1999 12:00AM','Nov  2 1999 12:00AM','Nov 15 1999 12:00AM'); 
GO


/********** END ************************************************************************************************/