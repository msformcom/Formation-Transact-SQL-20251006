-- DDL : Data Definition Language => Structure des données => CREATE DROP ALTER
-- DML : Data Manipulation Language => changements des données => SELECT , INSERT, DELETE, UPDATE

CREATE SCHEMA Prospection
DROP SCHEMA Prospection

-- Créer une table
CREATE TABLE Prospection.Contacts(
	-- contactid INT PRIMARY KEY IDENTITY(1,10)
	contactid UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	-- CHAR(10) => 10 caractères => 10 octets
	-- Encodage ASCII rené FR 114 101 110 167 => DK => renô
	-- VARCHAR(10) => Max 10 caractère  => Dom => Dom** => 5 octets
	-- NCHAR(10) => Encodage unicode e=> 101 Ш => 156 134 12 => 10 caractères
	-- NVARCHAR(10) => Encodage unicode => Max 10 caractères 
	nom NVARCHAR(50) NOT NULL,
	prenom NVARCHAR(50) NULL,
	age INT DEFAULT CEILING(RAND()*100),
	dateDernierContact DATE NULL
)

-- DATE : 11/09/1968
-- SMALLDATETIME => Date + Heure 1 minute près
-- DATETIME => Date + Heure 33ms près
SET DATEFORMAT DMY -- interprétation des chaines en date
DECLARE @dateNaissance DATE ='11/09/15';
SELECT @dateNaissance


DECLARE @chaine VARCHAR(10)=N'DШm';
SELECT @Chaine + @chaine

DECLARE @nombre DECIMAL(18,2)=10.2 -- => exact
DECLARE @nombre2 FLOAT -- REAL => not exact

DECLARE @n FLOAT=0;
DECLARE @inc FLOAT=1
DECLARE @i INT=0;

WHILE @i<10
BEGIN
	-- 10 fois

	SET @n=@n+@inc/5
	PRINT @n
	SET @i=@i+1
END
IF @n=2
BEGIN
	SELECT 'Succes'
END

