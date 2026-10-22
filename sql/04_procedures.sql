USE LibraryDB;
GO

-- SQL_STORED_PROCEDURE: usp_GetAllBooks
CREATE PROCEDURE usp_GetAllBooks
AS
BEGIN
SELECT BookID, BookName, Author, Category
    FROM Book;
    END;
GO
