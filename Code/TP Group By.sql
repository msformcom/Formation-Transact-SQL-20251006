-- par pays et par ville
-- | Pays | Ville | Nombre de commandes | Moyenne des frais de livraison | Nombre employes impliqués
-- pour l'année 2007

-- SELECT - FROM - WHERE - GROUP BY - ORDER BY

SELECT  shipcountry AS Pays, 
		shipcity AS Ville, 
		COUNT(orderid) AS NbCommandes,
		AVG(freight) AS MoyenneFraisLivraison, 
		COUNT(DISTINCT empid) AS NbEmplyesImpliques
FROM [Sales].[Orders]
WHERE DATEPART(year,orderdate)=2007
GROUP BY shipcountry, shipcity
ORDER BY shipcountry, shipcity