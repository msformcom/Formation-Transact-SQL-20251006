-- Fonctions scalaires

SELECT *,
	CASE WHEN unitprice<10 THEN 'Pas cher'
	WHEN unitprice<20 THEN 'Moyen'
	ELSE 'Cher' END AS IndicationPrix
FROM Production.Products
SELECT * ,
	CASE WHEN unitprice<10 THEN 'Pas cher'
		WHEN unitprice<20 THEN 'Moyen'
		ELSE 'Cher' END
FROM Sales.OrderDetails

SELECT *,
	Sales.indicationPrix(unitprice) AS IndicationPrix
FROM Sales.OrderDetails

CREATE OR ALTER FUNCTION Sales.indicationPrix(
	@price DECIMAL(18,2)
) RETURNS NVARCHAR(30) AS 
BEGIN
	RETURN  CASE WHEN @price<15 THEN 'Pas cher'
			WHEN @price<30 THEN 'Moyen'
			ELSE 'Cher' END

END

SELECT * FROM Production.ProductsWithCategorie