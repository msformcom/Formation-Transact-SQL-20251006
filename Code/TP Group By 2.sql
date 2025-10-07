-- Par employe, et par annee :
-- | Empid | Annee | NbCommandes | NbCommandesLivrees

-- 1) Identifier la ou les tables impliquées dans notre requtète
-- 2) Créer des groupes 
SELECT empid AS EmployeID,  
		DATEPART(year,orderdate) AS Annee, 
		DATEPART(quarter,orderdate) AS trimestre, 
		COUNT(orderid) AS NbCommandes,
		COUNT(shippeddate) AS NbCommandesLivrees
FROM Sales.Orders
GROUP BY Empid,DATEPART(year,orderdate), DATEPART(quarter,orderdate)
WITH CUBE
ORDER BY Empid,Annee, Trimestre