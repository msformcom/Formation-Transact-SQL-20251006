
CREATE SCHEMA Prospection
DROP SCHEMA Prospection


CREATE TABLE Prospection.Contacts(
	-- contactid INT PRIMARY KEY IDENTITY(1,1) => interdit de mettre une valeur
	contactid UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), -- Peut ne pas être fournie à l'insertion
	nom NVARCHAR(50) NOT NULL,
	prenom NVARCHAR(50) NULL,
	age INT DEFAULT CEILING(RAND()*100),
	dateDernierContact DATE NULL
)

-- INSERTION de données
INSERT INTO Prospection.Contacts(nom,prenom,age)
VALUES(N'MAURAS',N'Dominique',57)

INSERT INTO Prospection.Contacts(nom,prenom,age)
SELECT N'MAURAS',N'Dominique',57

INSERT INTO Prospection.Contacts(nom,prenom)
OUTPUT Inserted.* -- INsertion + Selection des données insérées
SELECT lastname,firstname FROM HR.Employees

SELECT * FROM Prospection.Contacts

INSERT INTO Prospection.Contacts(nom,prenom)
OUTPUT Inserted.contactid
VALUES(N'MAURAS',N'Toto')

SELECT @@IDENTITY -- Dernier id (INT) utilisé (IDENTITY(...)

-- SUPPRESSION de données dans la table
DELETE FROM Prospection.Contacts -- Supprime toutes les lignes de la table


BEGIN TRAN
DELETE FROM Prospection.Contacts
OUTPUT Deleted.*
WHERE age=57

ROLLBACK -- ou COMMIT

SELECT @@TRANCOUNT

-- Mise à jour
BEGIN TRAN
UPDATE Prospection.Contacts
SET age=age+1,
dateDernierContact=GETDATE()
OUTPUT DELETED.contactid, DELETED.nom, DELETED.age AS Avant,INSERTED.age AS Apres
WHERE nom=N'MAURAS'
COMMIT