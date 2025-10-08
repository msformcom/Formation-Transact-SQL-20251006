/* CA Ventes des produits en fonction des intervalles suivants 
<---- Intervalle------->
| MinPrix	| MaxPrix	| Qty	| CA	|
| 0			| 10		| 1000	| 67866	|
| 10		| 20		| 200	| 8768	|
| 20		| 50		| 23	| 7878	|
| 50		| 2000		| 12	| 1566	|
*/

SELECT * FROM Sales.OrderDetails OD
INNER JOIN  Intervalles I
ON OD.unitprice >= I.MinPrix AND Od.unitprice<I.MaxPrix



WITH Intervalles AS (
	SELECT *
	FROM ( VALUES (0,10), (10,20),(20,50),(50,2000)) AS T( MinPrice,MaxPrice )
	-- =>| MinPrice	| MaxPrice	|
),
Jointure AS (
	SELECT * FROM Intervalles AS I INNER JOIN Sales.orderdetails AS SOD 
	ON SOD.unitprice>=I.MinPrice AND SOD.unitprice<I.MaxPrice
	 -- ... => | MinPrice	| MaxPrice	| Qty | UnitPrice
	-- Associer les orderdetails avec les intervalles
)
SELECT MinPrice,MaxPrice,
	SUM(qty*unitprice) AS CA,
	SUM(qty) AS Qty,
	COUNT(DISTINCT orderid) AS NombredeVentes
 FROM Jointure
GROUP BY MinPrice,MaxPrice
... --GROUP BY
-- =>| MinPrice	| MaxPrice	| Qty | CA