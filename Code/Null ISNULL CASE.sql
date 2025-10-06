/*
	Liste des Commandes avec 
	Date, DateLivraison, Nombre d'heures entre les deux => TempsLivraison(H)
*/

USE TSQL -- Bonne pratique 
GO -- Le GO permet de scinder l'analyse du texte SQL en 2

SELECT --TOP 10  
	orderdate AS [Date],
	ISNULL(CONVERT(NVARCHAR,shippeddate,103),'---') AS DateLivraison,
	ISNULL(CONVERT(NVARCHAR,DATEDIFF(hh, orderdate,shippeddate)),'Non livré') AS [TempsLivraison(H)],
	-- commentaire selon le temps de livraison -72 => Rapide 
	-- entre 72 et 144h => moyen
	-- 144 => insatisfaisant
	CASE	WHEN shippeddate IS NULL THEN 'Non livré'  -- NULL n'est pas égal à NULL => NULL = NULL Faux
		 	WHEN DATEDIFF(hh, orderdate,shippeddate)<72 THEN 'Rapide'
			WHEN DATEDIFF(hh, orderdate,shippeddate)<144 THEN 'Moyen'
			ELSE 'Insatisfaisant' 
			END AS Commentaire
FROM Sales.Orders
