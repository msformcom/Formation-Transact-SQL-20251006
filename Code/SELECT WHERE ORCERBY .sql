SELECT TOP 10 *
FROM [Production].[Products]

-- Indicateur prix : Bon marché - 20 Moyen - 40 Cher
-- En Stock : Oui / Non
-- Nom produit sans 'Product'
-- | Nom du produit | Prix | Indicateur Prix | En Stock |

SELECT 
		SUBSTRING(productname,9,1000) AS Reference_produit,
		unitprice,
		CASE	WHEN unitprice<20 THEN 'Bon marché'
				WHEN unitprice<40 THEN 'Moyen'
				ELSE 'Cher' END	AS 'Indicateur Prix',
		CASE WHEN discontinued=0 THEN 'Oui' 
				ELSE 'Non' END AS 'En stock'
FROM [Production].[Products]
 WHERE discontinued=0
-- WHERE unitprice >=20 AND unitprice <40
-- WHERE [Indicateur Prix] ='Moyen' // Pas bon car le SELECT est exécuté après le WHERE
-- WHERE unitprice BETWEEN 20 AND 24

-- Ordre d'écriture : SELECT => FROM =>  WHERE => ORDER BY
-- Ordre exécution : FROM => WHERE =>  SELECT => ORDER BY 
ORDER BY [Indicateur Prix], unitprice DESC