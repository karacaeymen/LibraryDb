USE LibraryDB;
GO

-- VIEW: Library_StockReport
CREATE View Library_StockReport
as
SELECT 
    L.LibraryID,
    L.LibraryName,
    - COUNT(DISTINCT CM.MovementID)   -- negatif transferler
    + COUNT(DISTINCT CM2.MovementID)  -- pozitif transferler
    - COUNT(DISTINCT CM3.MovementID)  -- Loan/Damage/Lost
    + COUNT(DISTINCT CM4.MovementID)  -- Return
    AS Stok
FROM Library L
LEFT JOIN CopyMovement CM  ON CM.FromLibraryID = L.LibraryID
LEFT JOIN CopyMovement CM2 ON CM2.ToLibraryID = L.LibraryID
LEFT JOIN BookCopy BC      ON L.LibraryID = BC.LibraryID
LEFT JOIN CopyMovement CM3 ON CM3.CopyID = BC.CopyID AND CM3.MovementTypeID IN (1,4,5)
LEFT JOIN BookCopy BC2     ON L.LibraryID = BC2.LibraryID
LEFT JOIN CopyMovement CM4 ON CM4.CopyID = BC2.CopyID AND CM4.MovementTypeID IN (2)
GROUP BY L.LibraryID, L.LibraryName

GO

-- VIEW: vw_Top10StudentsByLoanCount
CREATE VIEW vw_Top10StudentsByLoanCount AS SELECT TOP 10 s.StudentID, s.Name, s.Surname, COUNT(cm.MovementID) AS ToplamOduncSayisi FROM Student s JOIN CopyMovement cm ON cm.StudentID = s.StudentID JOIN MovementType mt ON mt.MovementTypeID = cm.MovementTypeID WHERE mt.TypeName = 'Loan' GROUP BY s.StudentID, s.Name, s.Surname ORDER BY COUNT(cm.MovementID) DESC;
GO
