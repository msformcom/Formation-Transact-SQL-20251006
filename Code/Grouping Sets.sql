-- par pays,region, ville (du client), annee
-- le CA généré par les commandes 
-- Tables impliquees : 
-- [Sales].[Customers] => pays,region, ville
-- [Sales].[Orders] => Jointure entre [Sales].[Customers] et [Sales].[OrderDetails] => annee
-- [Sales].[OrderDetails] => qty + unitprice => CA

-- Deux étapes => 
-- 1) Jointure => | Pays | Region | Ville | Annee | Montant (qty*unitprice)
-- 2) GroupBY => | Pays | Region | Ville | Annee | CA
WITH Donnees AS (
SELECT  ISNULL(SC.country,'---') AS Pays,
		ISNULL(SC.region,'---') AS Region,
		ISNULL(SC.city,'---') AS Ville,
		DATEPART(year,SO.orderdate) AS Annee,
		SOD.qty*SOD.unitprice AS Montant
 FROM  [Sales].[Customers] AS SC 
RIGHT JOIN [Sales].[Orders] AS SO ON SC.custid=SO.custid
INNER JOIN [Sales].[OrderDetails] AS SOD ON SOD.orderid=SO.orderid)
SELECT  Pays, Region, Ville, Annee, SUM(Montant) AS CA FROM Donnees
-- Permettent de définir les cumuls associés aux differentes combinaisons
-- de regroupement 
GROUP BY GROUPING SETS(
	(),
	pays,
	(pays,region),
	(pays,region,ville),
	Annee,
	(Annee,pays),
	(Annee,pays,region)
)
ORDER BY Pays,Region, Annee
