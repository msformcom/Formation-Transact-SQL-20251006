/* Audit des performances de mes employes 
Pour un employe donné => Par ex 5 => 
1) Créer un paramêtre
On veut avoir en fonction du Annee et du mois Le CA qu'il génère
2) Jointure entre les tables nécessaire => | Annee | Mois | Qty | Unitprice => 150 lignes
3) Group BY pour regrouper les lignes par annee / mois => | Annee | Mois | CA | Qty => max 24 lignes
4) Creer une selection avec Annees 2006-2008 + selection avec 1 -12 mois => CROSS JOIN |Annee|Mois| => 36 
5) Jointure entre 3) et 4) => | Annee | Mois | CA | Qty 36 lignes exactement
6) Ajouter fenetres :
	- Rank Annee pour le CA
	- diffecrence de CA d'un mois à l'autre
	- pour une mois : % du CA / CA annuel 

*/

DECLARE @IdEmploye INT =5
DECLARE @AnneeDebut INT =2006 
DECLARE @AnneeFin INT =2008



;WITH Jointure AS(
	SELECT 
		DATEPART(year,orderdate) AS Annee,
		DATEPART(month,orderdate) AS Mois,
		qty*unitprice AS Montant,
		qty AS Quantite
	FROM [Sales].[Orders] SO 
	INNER JOIN [Sales].[OrderDetails] SOD ON SO.orderid=SOD.orderid
	WHERE empid=@IdEmploye
),
GroupBY AS (
SELECT Annee,
		Mois,
		SUM(montant) AS CA,
		SUM(Quantite) AS TotalQuantite
		
		FROM Jointure
GROUP BY Annee,Mois
),
Mois AS (SELECT n AS Mois FROM dbo.nums WHERE n BETWEEN 1 AND 12),
Annees AS (SELECT n AS Annee FROM dbo.nums WHERE n BETWEEN @AnneeDebut AND @AnneeFin),
AnneesMois AS (SELECT * FROM Annees CROSS JOIN Mois),
CAComplet AS (
SELECT AM.Annee,
		AM.mois,
		ISNULL(CA,0) AS CA,
		ISNULL(TotalQuantite,0) AS TotalQuantite
 FROM AnneesMois AM
LEFT JOIN GroupBY GB ON GB.Annee=AM.Annee AND GB.Mois=AM.mois)
SELECT *,
	SUM(CA) OVER (PARTITION BY Annee) AS CAAnnee,
	CA/SUM(CA) OVER (PARTITION BY Annee) AS PercentAnnee,
	CA-LAG(CA) OVER (ORDER BY Annee,Mois) AS DiffPrec,
	CA-AVG(CA) OVER(ORDER BY Annee,Mois ROWS BETWEEN 3 Preceding AND 1 PRECEDING)
FROM CAComplet
ORDER BY Annee,Mois