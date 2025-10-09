-- Liste des employes avec les deux pays sur lesquels ils ont fait le plus grand CA
-- | Nom employe | Pays			| CA			|
-- | Mauras      | France		| 897987		|
-- | Mauras      | Allemagne	| 670000		|

-- CROSS APPLY => Jointure basée sur une sous-requete

SELECT firstname,lastname, T.* FROM HR.Employees HE
CROSS APPLY (
	SELECT  SO.shipcountry, 
	SUM(SOD.qty*SOD.unitprice) AS CA
	FROM [Sales].[Orders] SO
	INNER JOIN [Sales].[OrderDetails] SOD ON SO.orderid=SOD.orderid
	WHERE SO.empid=HE.empid
	GROUP BY SO.shipcountry
	ORDER BY CA DESC
	OFFSET 0 ROWS
	FETCH NEXT 2 ROWS ONLY
) AS T
ORDER BY firstname,lastname, CA DESC




-- Les deux pays ou l'employe 4 a le plus vendu
SELECT  SO.shipcountry, 
	SUM(SOD.qty*SOD.unitprice) AS CA
FROM [Sales].[Orders] SO
INNER JOIN [Sales].[OrderDetails] SOD ON SO.orderid=SOD.orderid
WHERE SO.empid=4
GROUP BY SO.shipcountry
ORDER BY CA DESC
OFFSET 0 ROWS
FETCH NEXT 2 ROWS ONLY
