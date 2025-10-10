-- liste des pays ou le shipper 2 a dejà livré
-- Fonction basée sur un seul SELECT
-- Créer une fonction qui s'utilise SELECT * FROM  sales.shipcountries(2)
CREATE FUNCTION  sales.shipcountries(
@shipperid INT =2
) RETURNS TABLE AS RETURN (
SELECT DISTINCT shipcountry FROM Sales.Orders WHERE shipperid=@shipperid
)

SELECT * FROM sales.shipcountries(2)


-- SELECT * FROM anneesMois('01/02/2005','21/10/2008')

/*
	| Annee | Mois	|
	| 2005	| 1		|
	| 2005	| 2		|
	| 2005	| 3		|
	----
	| 2008	| 12	|

*/

-- SELECT entre 2006 et 2007 en utilisant function  anneesMois et la vue orderswithamount
-- | Annee | Mois	| CA |

-- Avant d'écrire le code de création de la fonction
-- j'écris ma requête avec des variables
-- Qui deviendront les paramètres de la fonction

-- Création des combinaisons entre années et mois
CREATE FUNCTION AnneesMois(
 @Date1 DATE ,
 @Date2 DATE)
 RETURNS TABLE AS RETURN (
	WITH Annees AS (
	SELECT n AS Annee FROM Nums WHERE n BETWEEN DATEPART(year,@Date1) AND DATEPART(year,@Date2)
	), Mois AS (
	SELECT n AS Mois FROM Nums WHERE n BETWEEN 1 AND 12
	)
	SELECT Annee,Mois FROM Annees CROSS JOIN Mois
)

SET DATEFORMAT DMY
SELECT * FROM AnneesMois('10/11/2005','20/12/2008')


-- Calcul du CA par mois entre deux dates
CREATE FUNCTION CAParMois(
 @Date1 DATE ,
 @Date2 DATE)
 RETURNS TABLE AS RETURN (
SELECT AM.Annee,AM.Mois,
	ISNULL(SUM(freight),0) AS Freight,
	ISNULL(SUM(productamount),0) AS productamount,
	ISNULL(SUM(amount),0) AS TotalAmount

 FROM sales.orderswithamount  SO
RIGHT JOIN AnneesMois( @Date1, @Date2) AM
ON DATEPART(year,SO.orderdate)=AM.annee AND DATEPART(month,SO.orderdate)=AM.Mois
GROUP BY AM.Annee,AM.Mois
)

SET DATEFORMAT DMY
SELECT * FROM CAParMois('10/11/2005','20/12/2008')
ORDER BY Annee,Mois