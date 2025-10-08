-- Je veux calculer la prime de mes employes
-- mensuellement : 5€ + 5% du CA qu'ils ont réalisés dans le mois
-- Pour l'employé 5
-- | Annee | Mois | Prime
-- Tables :		[Sales].[Orders] SO=> | Annee | Mois
--				[Sales].[OrderDetails] SOD => qty et unitprice => CA
-- Jointure SO et SOD + WHERE + GroupBy
-- Id de l'employe

-- Je place des paramètres en fonction de la demande
DECLARE @idemploye INT =5 -- TINYINT SMALLINT INT BIGINT
DECLARE @primefixe DECIMAL(18,2)=5 -- 18 chiffres en tout 16 avant la , 2 après
DECLARE @primepercent DECIMAL(18,2)=5 

;WITH VentesDetails AS (
SELECT DATEPART(year,SO.orderdate) AS Annee,
		DATEPART(month,SO.orderdate) AS Mois,
		unitprice*qty AS Montant
FROM [Sales].[Orders] SO
INNER JOIN [Sales].[OrderDetails] SOD ON SO.orderid=SOD.orderid
WHERE SO.empid=@idemploye
)
SELECT Annee,Mois, 
		@primefixe + SUM(montant)*@primepercent/100 AS Prime
 FROM VentesDetails
GROUP BY Annee,Mois
ORDER BY Annee,Mois