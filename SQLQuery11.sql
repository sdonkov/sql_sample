USE [Minions]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 4/5/2022 11:09:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](30) NOT NULL,
	[Password] [varchar](26) NOT NULL,
	[ProfilePicture] [varbinary](max) NULL,
	[LastLoginTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_UsersCompositeIdUsername] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (len([ProfilePicture])<=(900000))
GO


ALTER TABLE [Users]
ADD CONSTRAINT Password CHECK (LEN(Password) >= 5)

ALTER TABLE Users
ADD CONSTRAINT DF_Users DEFAULT GETDATE() FOR LastLoginTime



ALTER TABLE Users
DROP CONSTRAINT PK_UsersCompositeIdUsername

ALTER TABLE Users
ADD CONSTRAINT PK_Id PRIMARY KEY ([Id])

ALTER TABLE Users
ADD CONSTRAINT Username UNIQUE(Username)

ALTER TABLE Users
ADD CONSTRAINT CHK_Username CHECK (LEN(Username) >=3) 


CREATE DATABASE [Movies]

CREATE TABLE [Directors] (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	DirectorName nvarchar(50) NOT NULL,
	Notes nvarchar(max)
	)

INSERT INTO Directors (DirectorName, Notes) VALUES
('Pavel', 'Belejki'),
('Mavel', 'Belejki'),
('Travel', 'Belejki'),
('Bavel', 'Belejki'),
('Xavel', 'Belejki')

CREATE TABLE [Genres] (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	GenreName nvarchar (50) NOT NULL,
	Notes nvarchar(max)
)

INSERT INTO Genres (GenreName) VALUES
('Joro'),
('Bekama'),
('Pepo'),
('Beta'),
('Bojigol')


CREATE TABLE [Categories] (
	Id INT Identity Primary key not null,
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR (MAX)
)


INSERT INTO Categories (CategoryName) VALUES
('Categoty one'),
('Categoty two'),
('Categoty three'),
('Categoty four'),
('Categoty five')

CREATE TABLE Movies (
	Id INT Identity PRIMARY KEY NOT NULL,
	Title NVARCHAR(255) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors (Id),
	CopyrightYear DATETIME2,
	Lenght NVARCHAR(50),
	GenreId INT FOREIGN KEY REFERENCES Genres(Id),
    CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	Rating INT,
    Notes NVARCHAR(MAX)


)


INSERT INTO Movies(Title, DirectorId, GenreId, CategoryId) VALUES
('Title One', 2,3,4),
('Title Two', 2,5,2),
('Title Three', 1,2,3),
('Title Four', 1,3,4),
('Title Five', 2,4,4)
 

 DROP DATABASE Movies


 CREATE DATABASE CarRental
 GO
 USE CarRental
CREATE TABLE [Categories] (
Id	INT PRIMARY KEY NOT NULL,
CategoryName nvarchar(50) NOT NULL,
[DailyRate] DECIMAL (10,2),
[WeeklyRate] DECIMAL (10,2),
[MonthlyRate] DECIMAL (10,2),
[WeekendRate] DECIMAL (10,2)
)
ALTER TABLE Categories 
ADD CONSTRAINT CheckCateg_ CHECK((DailyRate IS NOT NULL) OR (WeeklyRate IS NOT NULL) OR (MonthlyRate IS NOT NULL) OR (WeekendRate IS NOT NULL))

INSERT INTO [Categories] (Id, CategoryName, [DailyRate], [WeeklyRate], MonthlyRate, WeekendRate) VALUES
('1', 'Cars', '10','70','300','20'),
('2', 'Cars', '20','140','600','40'),
('3', 'Cars', '30','210','900','60')


CREATE TABLE [Cars] (
Id INT PRIMARY KEY NOT NULL,
PLateNumber NVARCHAR(10) NOT NULL,
Manufacturer NVARCHAR(50) NOT NULL,
Model NVARCHAR(50) NOT NULL,
CarYear INT,
CategoryId INT NOT NULL FOREIGN KEY REFERENCES [Categories]([Id]),
Doors INT,
Picture VARBINARY (MAX),
Condition NVARCHAR(50),
Availabale BIT DEFAULT 1
)

INSERT INTO [Cars] (Id, PLateNumber, Manufacturer, Model, CarYear,CategoryId,Availabale) VALUES
('1', 'CB1010AM', 'Mesla', 'Z', '2022', '3','1'),
('2', 'CB1010AM', 'Mesla', 'Z', '2022', '1','1'),
('3', 'CB10AM', 'Mesla', 'ZA', '2024', '2','0')

DROP TABLE Cars