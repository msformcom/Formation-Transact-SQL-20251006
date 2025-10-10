SELECT TOP 20 * FROM Personnes
-- Recherche sans index => Scan (Parcours) de la table
SELECT * FROM Personnes WHERE Nom='C65AA91B-4B0A-4DC0-BC99-7213EF649CD0'
-- Création d'un index pour les recherches sur le nom
CREATE NONCLUSTERED INDEX IX_Nom ON Personnes(Nom)
-- Recherche avec index => 
SELECT * FROM Personnes WHERE Nom='C65AA91B-4B0A-4DC0-BC99-7213EF649CD0'

SELECT * FROM Personnes WHERE id='C65AA91B-4B0A-4DC0-BC99-7213EF649CD0'
CREATE NONCLUSTERED INDEX IX_Id ON Personnes(Id)

SELECT * FROM Personnes WHERE credit <20

-- Index non cluster => les lignes ne sont pas ordonnées
CREATE NONCLUSTERED INDEX IX_Credit ON Personnes(Credit)
SELECT * FROM Personnes
DROP INDEX IX_Credit ON Personnes
-- Index  cluster => les lignes  sont  ordonnées
CREATE CLUSTERED INDEX IX_Credit ON Personnes(Credit)
SELECT * FROM Personnes

SELECT * FROM Personnes WHERE credit >980
DROP INDEX IX_Credit ON Personnes

SELECT * FROM Personnes ORDER BY Credit
CREATE CLUSTERED INDEX IX_Credit ON Personnes(Credit)

-- Grandes tables
-- 1) Lors des requêtes => Plan exécution
-- 2) Lire les conseils et les appliquer si on comprends ce qu'on fait
-- 3) Creer des indexes sur les colonnes utilisees dans un WHERE
--		Id ?
-- 4) Choisir un index en cluster (unique sur une table)
-- 5) Chosiir les index non cluster (Critères de recherche )
--	Factures => 
--		Cluster Date car travail sur factures par date (les plus récentes)
--		Noncluster sur id,numero,idclient, pays

--		Products 
--		non cluster sur id, productname
--		cluster categoryid

CREATE STATISTICS ST_Credit ON Personnes(credit)
CREATE STATISTICS ST_Nom ON Personnes(Nom)
-- Le système sait que le nom est plus selectif que le credit
SELECT * FROM Personnes WHERE Credit<10 AND NOM ='toto'
-- Va être modifié par l'analyseur en plan execution
SELECT * FROM Personnes WHERE NOM ='toto' AND Credit <10