SELECT Productid AS IdProduit,
	SUM(qty) AS QuantiteVendue,
	AVG(unitprice) AS PrixMoyenConsenti,
	SUM(qty*unitprice) AS CA,
	SUM(qty*unitprice)/SUM(qty) AS PrixMoyenVente,
	COUNT(DISTINCT orderid) AS NbVentes
 FROM [Sales].[OrderDetails]
GROUP BY Productid
ORDER BY QuantiteVendue DESC
-- Par productid =>
-- Productid | QtyVendue | PrixMoyenVente | NombreDeVentes


SELECT * 
FROM [Sales].[OrderDetails]
ORDER BY productid