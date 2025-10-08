-- Fonctions de fenétrage
SELECT 
-- Fenêtre Order By
-- ROW_NUMBER() OVER(ORDER BY unitprice) AS RowNumber,
--RANK() OVER(ORDER BY unitprice) AS Rank,
--DENSE_RANK() OVER(ORDER BY unitprice) AS DenseRank,
-- Fenêtre Partition BY
--RANK() OVER(PARTITION BY CategoryId ORDER BY unitprice ) AS RankBYCategory,
--MIN(unitprice) OVER(PARTITION BY Categoryid) AS PrixMiniCategorie,
--MAX(unitprice) OVER(PARTITION BY Categoryid) AS PrixMaxCategorie,
AVG(unitprice) OVER(PARTITION BY Categoryid) AS PrixMoyenCategorie,
COUNT(*)  OVER(PARTITION BY Categoryid) AS NbProduitsCategorie,
LAG(unitPrice)  OVER(PARTITION BY Categoryid ORDER BY unitprice) AS PrixPrecedent,
LEAD(unitPrice,1)  OVER(PARTITION BY Categoryid ORDER BY unitprice) AS Prixsuivant,

SUM(unitprice)  OVER(PARTITION BY Categoryid ORDER BY unitprice ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
* 
FROM [Production].[Products]
ORDER BY categoryid, unitprice