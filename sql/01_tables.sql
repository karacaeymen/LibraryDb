USE LibraryDB;
GO

CREATE TABLE dbo.[Book] (
    [BookID] int IDENTITY(1,1) NOT NULL,
    [BookName] varchar(150) NOT NULL,
    [Author] varchar(100) NOT NULL,
    [Category] varchar(50) NOT NULL,
    [Code] varchar(20) NOT NULL,
    [ISBN] varchar(20) NULL
);
GO

CREATE TABLE dbo.[BookCopy] (
    [CopyID] int IDENTITY(1,1) NOT NULL,
    [BookID] int NOT NULL,
    [LibraryID] int NOT NULL,
    [Barcode] varchar(30) NOT NULL,
    [Status] varchar(20) NOT NULL CONSTRAINT [DF__BookCopy__Status__04E4BC85] DEFAULT ('Available')
);
GO

CREATE TABLE dbo.[CopyMovement] (
    [MovementID] int IDENTITY(1,1) NOT NULL,
    [CopyID] int NOT NULL,
    [MovementTypeID] int NOT NULL,
    [StudentID] int NULL,
    [FromLibraryID] int NULL,
    [ToLibraryID] int NULL,
    [MovementDate] date NOT NULL,
    [DueDate] date NULL
);
GO

CREATE TABLE dbo.[Library] (
    [LibraryID] int IDENTITY(1,1) NOT NULL,
    [LibraryName] varchar(150) NOT NULL,
    [City] varchar(50) NOT NULL,
    [District] varchar(50) NOT NULL
);
GO

CREATE TABLE dbo.[MovementType] (
    [MovementTypeID] int IDENTITY(1,1) NOT NULL,
    [TypeName] varchar(30) NOT NULL
);
GO

CREATE TABLE dbo.[Student] (
    [StudentID] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(50) NOT NULL,
    [Surname] varchar(50) NOT NULL,
    [BirthDate] date NOT NULL
);
GO

ALTER TABLE dbo.[Book] ADD CONSTRAINT [PK__Book__3DE0C227237883C1] PRIMARY KEY ([BookID]);
GO
ALTER TABLE dbo.[Book] ADD CONSTRAINT [UQ__Book__A25C5AA715E42655] UNIQUE ([Code]);
GO
ALTER TABLE dbo.[BookCopy] ADD CONSTRAINT [PK__BookCopy__C26CCCE5DD69A734] PRIMARY KEY ([CopyID]);
GO
ALTER TABLE dbo.[BookCopy] ADD CONSTRAINT [UQ__BookCopy__177800D35A233C52] UNIQUE ([Barcode]);
GO
ALTER TABLE dbo.[CopyMovement] ADD CONSTRAINT [PK__CopyMove__D182246641086F12] PRIMARY KEY ([MovementID]);
GO
ALTER TABLE dbo.[Library] ADD CONSTRAINT [PK__Library__A13647BF48744447] PRIMARY KEY ([LibraryID]);
GO
ALTER TABLE dbo.[MovementType] ADD CONSTRAINT [PK__Movement__74FB1FF1E8BA7F6C] PRIMARY KEY ([MovementTypeID]);
GO
ALTER TABLE dbo.[MovementType] ADD CONSTRAINT [UQ__Movement__D4E7DFA8C6DF5898] UNIQUE ([TypeName]);
GO
ALTER TABLE dbo.[Student] ADD CONSTRAINT [PK__Student__32C52A792399BC28] PRIMARY KEY ([StudentID]);
GO
ALTER TABLE dbo.[BookCopy] ADD CONSTRAINT [FK__BookCopy__BookID__05D8E0BE] FOREIGN KEY ([BookID]) REFERENCES dbo.[Book] ([BookID]);
GO
ALTER TABLE dbo.[BookCopy] ADD CONSTRAINT [FK__BookCopy__Librar__06CD04F7] FOREIGN KEY ([LibraryID]) REFERENCES dbo.[Library] ([LibraryID]);
GO
ALTER TABLE dbo.[CopyMovement] ADD CONSTRAINT [FK__CopyMovem__CopyI__0C85DE4D] FOREIGN KEY ([CopyID]) REFERENCES dbo.[BookCopy] ([CopyID]);
GO
ALTER TABLE dbo.[CopyMovement] ADD CONSTRAINT [FK__CopyMovem__FromL__0F624AF8] FOREIGN KEY ([FromLibraryID]) REFERENCES dbo.[Library] ([LibraryID]);
GO
ALTER TABLE dbo.[CopyMovement] ADD CONSTRAINT [FK__CopyMovem__Movem__0D7A0286] FOREIGN KEY ([MovementTypeID]) REFERENCES dbo.[MovementType] ([MovementTypeID]);
GO
ALTER TABLE dbo.[CopyMovement] ADD CONSTRAINT [FK__CopyMovem__Stude__0E6E26BF] FOREIGN KEY ([StudentID]) REFERENCES dbo.[Student] ([StudentID]);
GO
ALTER TABLE dbo.[CopyMovement] ADD CONSTRAINT [FK__CopyMovem__ToLib__10566F31] FOREIGN KEY ([ToLibraryID]) REFERENCES dbo.[Library] ([LibraryID]);
GO
