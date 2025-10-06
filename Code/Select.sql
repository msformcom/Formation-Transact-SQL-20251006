-- Changement de contexte de BDD
USE TSQL

SELECT	1 AS COL1, 
		2 AS COL2 , 
		2+2 AS COL3

SELECT * FROM sys.tables
SELECT * FROM sys.databases
SELECT * FROM sys.schemas


-- Les clauses (Instructions SQL) => Majuscule
/*
	Indentation + retour à la ligne pour mieux lire
	Systématiquement donner des alias aux colonnes

*/
SELECT	empid AS [Id Employe],
		firstname AS 'Prenom Employé', 
		lastname AS Nom_Employé, -- Pas d'accents
		birthdate AS Date_Naissance, -- Bonne pratique => Plusieurs mots sépare avec _
		region AS region,
		GETDATE() AS DateJour,
		DATEDIFF(year, Birthdate, GETDATE()) AS Age
FROM HR.Employees


