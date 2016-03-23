CREATE PROCEDURE UpsertBook
	@ISBN nvarchar(255),
	@Title nvarchar(255),
	@SignId int, 
	@PublicationYear nvarchar(10),
	@PublicationInfo nvarchar(255),
	@Pages smallint	
AS
	UPDATE BOOK
	SET Title = @Title, SignId = @SignId, PublicationYear = @PublicationYear, PublicationInfo = @PublicationInfo,Pages = @Pages
	WHERE ISBN = @ISBN
	IF @@ROWCOUNT = 0
		INSERT INTO BOOK(ISBN, Title, SignId, PublicationYear, PublicationInfo, Pages)
		VALUES(@ISBN, @Title, @SignId, @PublicationYear, @PublicationInfo, @Pages);
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
	
CREATE PROCEDURE UpsertBorrower
	@PersonId nvarchar(13),
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Adress nvarchar(50),
	@Telno nvarchar(50),
	@CategoryId int
AS
	UPDATE BORROWER
	SET FirstName = @FirstName, LastName = @LastName, Adress = @Adress, TelNo = @TelNo, CategoryId = @CategoryId
	WHERE PersonId = @PersonId
	IF @@ROWCOUNT = 0
		INSERT INTO BORROWER(PersonId, FirstName, LastName, Adress, TelNo, CategoryId)
		VALUES(@PersonId, @FirstName, @LastName, @Adress, @TelNo, @CategoryId);
GO

/*----------------------*/

CREATE PROCEDURE UpsertAccount
	@Username nvarchar(50),
	@Password nvarchar(50),	
	@Salt nvarchar(50),
	@RoleId int,
	@BorrowerId nvarchar(13)
AS
	UPDATE ACCOUNT
	SET Password = @Password, RoleId = @RoleId, Salt = @Salt
	WHERE Username = @Username
	IF @@ROWCOUNT = 0
		INSERT INTO ACCOUNT(Username, Password, Salt, RoleId, BorrowerId)
		VALUES(@Username, @Password, @Salt, @RoleId, @BorrowerId);
GO