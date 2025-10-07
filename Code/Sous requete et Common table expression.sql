
-- Concept => ecrire une requète en plusieurs étapes
-- Pour simplifier la lecture et la maintenance

/*
| Nom produit | Annee | Mois | Quantitevendue
livrées au portugal

1) Les tables
[Production].[Products] PP => Nom produit
[Sales].[OrderDetails] SOD => Quantitevendue
[Sales].[Orders] SO =>[shipcountry] [orderdate] => Annee | Mois 



SELECT Annee,Mois, NomProduit, SUM(Quantite) FROM 
							(
							-- Jointure : | NomProduit|Annee|Mois|Quantite
							SELECT  PP.productname AS NomProduit,
									DATEPART(year,SO.orderdate) AS Annee,
										DATEPART(month,SO.orderdate) AS Mois,
										SOD.qty AS Quantite
							 FROM [Production].[Products] PP
							INNER JOIN [Sales].[OrderDetails] SOD ON PP.productid=SOD.productid
							INNER JOIN [Sales].[Orders] SO ON SO.orderid=SOD.orderid
							WHERE SO.shipcountry='Portugal'
							) AS Jointure
GROUP BY Annee,Mois,NomProduit



-- Autre syntaxe : CTE Common table expressions
;WITH Jointure AS (
	-- Jointure : | NomProduit|Annee|Mois|Quantite
	SELECT  PP.productname AS NomProduit,
			DATEPART(year,SO.orderdate) AS Annee,
				DATEPART(month,SO.orderdate) AS Mois,
				SOD.qty AS Quantite
		FROM [Production].[Products] PP
	INNER JOIN [Sales].[OrderDetails] SOD ON PP.productid=SOD.productid
	INNER JOIN [Sales].[Orders] SO ON SO.orderid=SOD.orderid
	WHERE SO.shipcountry='Portugal')
SELECT Annee,Mois, NomProduit, SUM(Quantite) 
FROM Jointure
GROUP BY Annee,Mois,NomProduit