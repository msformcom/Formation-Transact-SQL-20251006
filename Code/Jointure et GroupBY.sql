-- Liste des ventes produit
-- | productid | NomProduit | Qty vendue | Prixvente
-- order by productid

-- 1) Identifier les tables 
--		[Production].[Products] PP
--		[Sales].[OrderDetails] SO
--		PP.productid=SO.productid

SELECT  PP.productid,
		PP.productname AS NomProduit, 
		SUM(SO.qty*SO.unitprice) AS CA, 
		SUM(SO.qty) AS QuantiteVendue
FROM [Production].[Products] AS PP
INNER JOIN [Sales].[OrderDetails] AS SO
ON PP.productid=SO.productid
GROUP BY PP.productid, PP.productname
	ORDER BY CA DESC