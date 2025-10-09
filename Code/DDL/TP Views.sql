-- View sur les produits Production.ProductsWithCategorie
--  | productid | Nom produit | Nom catégorie |

-- View Sales.ProductSales
-- | productid | Nom produit | Nom catégorie | CA
CREATE OR ALTER VIEW Production.ProductsWithCategorie AS
SELECT PP.productid AS IdProduit,
	PP.productname AS NomProduit,
	PC.categoryname AS NomCategorie
FROM [Production].[Products] PP 
INNER JOIN [Production].[Categories] PC ON PP.categoryid=PC.categoryid

CREATE OR ALTER VIEW Sales.ProductSales AS
SELECT PP.*, 
		SUM(qty*unitprice) AS CA FROM Production.ProductsWithCategorie PP
INNER JOIN [Sales].[OrderDetails] SOD ON SOD.productid=PP.IdProduit
GROUP BY IdProduit,NomProduit,NomCategorie