-- Fonctions aggregation
SELECT 
	COUNT(*) AS NbCommandes,
	SUM(freight) AS SommeFraisLivraison,
	MIN(freight) AS MinFraisLivraison,
	MAX(orderdate) AS DateDerniereCommande,
	AVG(freight) AS MoyenneFraisLivraison,
	COUNT(shippeddate) AS NbCommandesLivrees, --Nb de valeurs non nulles pour shippeddate
	COUNT(*)-COUNT(shippeddate) AS NbCommandesNonLivrées,
	COUNT(DISTINCT shipcountry) AS NbPays
FROM [Sales].[Orders]

-- Nombre de produits, moyenne des prix, prix mini, prix max
SELECT COUNT(*) AS nbProduits,
		AVG(unitprice) AS MoyennePrix,
		MIN(unitprice) AS PrixMin,
		MAX(unitprice) AS PrixMax
	 
FROM [Production].[Products]

SELECT DISTINCT shipcountry, shipregion 
FROM Sales.orders
ORDER BY shipcountry, shipregion