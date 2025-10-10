-- Create Table
CREATE TABLE Personnes(
Id UNIQUEIDENTIFIER DEFAULT Newid(),
Nom NVARCHAR(50),
Prenom NVARCHAR(50),
Credit DECIMAL(18,2)
)
GO
-- Insertion Ligne 1
INSERT INTO Personnes(Id,Nom,Prenom,Credit)
SELECT newid(),CONVERT(NVARCHAR(50),newid()),CONVERT(NVARCHAR(50),newid()),ROUND( RAND()*1000,2)
GO
-- Doublement des lignes
INSERT INTO Personnes(Id,Nom,Prenom,Credit)
SELECT newid(),CONVERT(NVARCHAR(50),newid()),CONVERT(NVARCHAR(50),newid()),ROUND( RAND()*1000,2)
FROM Personnes
GO
SELECT * FROM Personnes