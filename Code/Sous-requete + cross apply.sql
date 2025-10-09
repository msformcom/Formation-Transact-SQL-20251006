-- Liste des produits avec le CA qu'ils ont généré pour 2007
-- | Nom produit | CA | Qty => une ligne par produit
-- Utiliser deux méthodes : Jointure VS SousRequetes => Autant de lignes que de produits

-- Avec sous-requête
WITH Requete1 AS(
SELECT
	PP.productid,
	PP.productname,
	(SELECT SUM(qty*unitprice) FROM Sales.OrderDetails WHERE productid=PP.productid) AS CA,
	(SELECT SUM(qty) FROM Sales.OrderDetails WHERE productid=PP.productid) AS Qty
FROM Production.Products PP
-- SELECT SUM(qty*unitprice) FROM Sales.OrderDetails WHERE productid=4 => CA pour produit 4
-- SELECT SUM(qty) FROM Sales.OrderDetails WHERE productid=4 => Qty pour produit 4
),
-- Avec Jointure
Requete2 AS (
	SELECT PP.productid,
	PP.productname,
	SUM(qty*SOD.unitprice) AS CA,
	SUM(qty) AS Qty FROM Production.Products PP
INNER JOIN Sales.OrderDetails SOD ON SOD.productid=PP.productid
GROUP BY PP.productid,
	PP.productname
	)
-- Comparaison des résultats => Résultats identiques
(SELECT * FROM Requete1
EXCEPT 
SELECT * FROM Requete2)
UNION 
(SELECT * FROM Requete2
EXCEPT 
SELECT * FROM Requete1)
-- Performances

--Méthode 3 : CROSS APPLY
SELECT
	PP.productid,
	PP.productname,
	T.*
	
FROM Production.Products PP
CROSS APPLY (	SELECT SUM(qty*unitprice) AS CA, SUM(Qty) AS qty 
				FROM Sales.OrderDetails 
				WHERE productid=PP.productid) AS T

