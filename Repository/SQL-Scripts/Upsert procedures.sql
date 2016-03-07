CREATE PROCEDURE UpsertBook
	@ISBN nvarchar(255),
	@Title nvarchar(255),
	@SignId int, 
	@PublicationYear nvarchar(10),
	@PublicationInfo nvarchar(255),
	@Pages smallint	
AS
	UPDATE BOOK
	SET Title = @Title, SignId = @SignId, PublicationYear = @PublicationYear, Pages = @Pages
	WHERE ISBN = @ISBN
	IF @@ROWCOUNT = 0
		INSERT INTO BOOK(ISBN, Title, SignId, PublicationYear, Pages)
		VALUES(@ISBN, @Title, @SignId, @PublicationYear, @Pages);
GO
		
/*----------------------*/
	
CREATE PROCEDURE UpsertCopy
	@Barcode nvarchar(20),
	@Location nvarchar(50),
	@StatusId int,
	@ISBN nvarchar(15),
	@Library nvarchar(50)
AS
	UPDATE COPY
	SET Location = @Location, StatusId = @StatusId, ISBN = @ISBN, Library = @Library
	WHERE Barcode = @Barcode
	IF @@ROWCOUNT = 0
		INSERT INTO COPY(Barcode, Location, StatusId, ISBN, Library)
		VALUES(@Barcode, @Location, @StatusId, @ISBN, @Library);
GO
		
/*----------------------*/
	
CREATE PROCEDURE UpsertAuthor
	@Aid int,
	@FirstName nvarchar(50),
	@LastName nvarchar(255),
	@BirthYear nvarchar(10)
AS
	UPDATE AUTHOR
	SET FirstName = @FirstName, LastName = @LastName, BirthYear = @BirthYear
	WHERE Aid = @Aid
	IF @@ROWCOUNT = 0
		INSERT INTO AUTHOR(Aid, FirstName, LastName, BirthYear)
		VALUES(@Aid, @FirstName, @LastName, @BirthYear);
GO
		
/*----------------------*/
	
CREATE PROCEDURE UpsertBorrower
	@PersonId nvarchar(13),
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Address nvarchar(50),
	@Telno nvarchar(50),
	@CategoryId int
AS
	UPDATE BORROWER
	SET FirstName = @FirstName, LastName = @LastName, Address = @Address, TelNo = @TelNo, CategoryId = @CategoryId
	WHERE PersonId = @PersonId
	IF @@ROWCOUNT = 0
		INSERT INTO BORROWER(PersonId, FirstName, LastName, Address, TelNo, CategoryId)
		VALUES(@PersonId, @FirstName, @LastName, @Address, @TelNo, @CategoryId);
GO
		
