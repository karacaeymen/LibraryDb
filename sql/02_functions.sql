USE LibraryDB;
GO

-- SQL_SCALAR_FUNCTION: CALCULATE_AGE
  CREATE FUNCTION DBO.CALCULATE_AGE(@BIRTHDATE AS DATE)
  RETURNS INT
  AS
  BEGIN
  DECLARE @RESULT AS INT
  SET @RESULT = DATEDIFF(YEAR,@BIRTHDATE,GETDATE())

  RETURN @RESULT 
  END
GO

-- SQL_SCALAR_FUNCTION: GetActiveLoanCount

CREATE FUNCTION dbo.GetActiveLoanCount(@StudentID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT

    SET @Result = (
        SELECT COUNT(CM.MovementID) 
        FROM CopyMovement CM
        LEFT JOIN CopyMovement RT 
            ON RT.CopyID = CM.CopyID
           AND RT.StudentID = CM.StudentID
           AND RT.MovementTypeID = 2
           AND RT.MovementDate > CM.MovementDate
        WHERE CM.MovementTypeID = 1
          AND CM.StudentID = @StudentID
          AND RT.MovementID IS NULL
    )

    RETURN @Result
END
GO
