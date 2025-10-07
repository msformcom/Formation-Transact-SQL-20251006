SELECT * FROM [Production].[Products]

SELECT * FROM Production.Categories

SELECT * FROM [Production].[Products] AS P,Production.Categories AS C
WHERE P.categoryid=C.categoryid AND unitprice<20

SELECT P.productid AS IdProduit,
		 P.productname AS NomProduit,
		C.categoryname AS NomCategorie,
		P.categoryid AS IdCategorie,
		C.categoryid AS IdCategorie
FROM [Production].[Products] AS P 
INNER JOIN Production.Categories AS C
ON P.categoryid=C.categoryid
WHERE  unitprice<20






-- Le companyname des clients avec les numeros et dates des commandes

-- 1) Tables associées : Sales.Customers (SC) et Sales.Orders (SO) => SC.CustId=SO.custid

SELECT SC.companyname AS NomEntreprise,
		SO.orderid,
		SO.orderdate
FROM Sales.Orders AS SO 
INNER JOIN Sales.Customers AS SC
ON SO.custid=SC.custid
