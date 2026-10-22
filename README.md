# LibraryDB

A multi-branch library management database written in **T-SQL for Microsoft SQL Server**.
It tracks every physical copy of a book and every movement of that copy (loans, returns,
transfers between branches, damage, loss) through a single generalized movement table.

## Schema

| Table | Purpose |
|-------|---------|
| `Book` | Book titles: name, author, category, unique catalogue code, ISBN |
| `Library` | Library branches with city and district |
| `BookCopy` | Each physical copy of a book, with a unique barcode, its branch and a status (default `Available`) |
| `Student` | Library members |
| `MovementType` | Kinds of movement: Loan, Return, Transfer, Damage, Lost |
| `CopyMovement` | Every event in a copy's life: which copy, which movement type, the student (loans/returns), source and target branch (transfers), date and due date |

Relationships:

- `Book` 1 to N `BookCopy`: a title can have many physical copies
- `Library` 1 to N `BookCopy`: a branch holds many copies
- `BookCopy` 1 to N `CopyMovement`: a copy has a full movement history
- `MovementType` 1 to N `CopyMovement`: the type of each movement
- `Student` 1 to N `CopyMovement`: filled only for Loan/Return
- `Library` 1 to N `CopyMovement` (`FromLibraryID`, `ToLibraryID`): filled only for Transfer

Primary keys, foreign keys, unique constraints (`Book.Code`, `BookCopy.Barcode`,
`MovementType.TypeName`) and a default constraint (`BookCopy.Status`) enforce integrity.

### Design note (v2)

The first version had a `LibraryStock` counter table and a separate `Loan` table. Version 2
replaced them with copy-level tracking (`BookCopy`) and one generalized `CopyMovement` table
keyed by `MovementType`, so new kinds of movement (transfer, damage, loss) can be added as
data, without schema or code changes.

## Programmable objects

| Object | Type | What it does |
|--------|------|--------------|
| `dbo.CALCULATE_AGE(@BirthDate)` | Scalar function | Age in years from a birth date |
| `dbo.GetActiveLoanCount(@StudentID)` | Scalar function | Number of loans a student has not returned yet (a Loan with no later Return of the same copy) |
| `Library_StockReport` | View | Stock per branch, derived from movements: incoming and outgoing transfers, loans, damage and loss, returns |
| `vw_Top10StudentsByLoanCount` | View | The ten students with the most loans |
| `usp_GetAllBooks` | Stored procedure | Lists all books |

## Running it

Run the scripts in order in SQL Server Management Studio or with `sqlcmd`:

```
sqlcmd -S localhost -E -i sql/00_create_database.sql
sqlcmd -S localhost -E -i sql/01_tables.sql
sqlcmd -S localhost -E -i sql/02_functions.sql
sqlcmd -S localhost -E -i sql/03_views.sql
sqlcmd -S localhost -E -i sql/04_procedures.sql
```

The repository contains the schema and code only, no data.
