CREATE TABLE [People](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] nvarchar(200) NOT NULL,
	[Picture] VARBINARY(max) CHECK(LEN(PICTURE) <= 2 * 1024 * 1024),
	[Height] decimal (3,2),
	[Weight] decimal (5,2),
	[Gender] char CHECK(Gender = 'm' OR Gender = 'f') NOT NULL,
	[Birthdate] DATETIME2 NOT NULL,
	[Biography] nvarchar(max)

)

INSERT INTO [People] ([Name],[Height], [Weight], [Gender], [Birthdate], [Biography]) VALUES
('Petar', '1.8','80','m', '11.10.1996', 'Biografiq na choveka X'),
('Plamena', '1.6','50','f', '11.10.1990', 'Biografiq na choveka Y'),
('Petar', '1.76','101','m', '01.06.1993', 'Biografiq na choveka Z'),
('Petranka', '1.8','80','f', '11.01.1996', 'Biografiq na choveka A'),
('Pavel', '1.62','60','m', '11.10.1980', 'Biografiq na choveka B')
