-- Table temporaires
-- Créée dans tempdb => ne pollue pas la BDD
-- Spécifique à ma connection => Les autres utilisateurs ne la verront pas
-- Automatiquement effacée quand je me déconnecte => espace disque libéré
SET DATEFORMAT DMY
DECLARE @date1 DATE ='21/12/2005'
DECLARE @date2 DATE ='13/11/2007'
-- Création de la table qui va contenir les dates à renvoyer
CREATE TABLE #MesDates(
	Date DATE
	 )
-- Boucle =>
-- Test des conditions pour continuer
WHILE @date1 <= @date2
BEGIN 
	-- Action à réaliser
	INSERT INTO #MesDates(Date) VALUES(@date1)
	-- Changement de situation => @date1 augmente d'un jour
	SET @date1=DATEADD(day,1,@date1)
END

SELECT * FROM #MesDates
WHERE DATEPART(WEEKDAY,Date)=1 -- Dimanche

DROP TABLE #MesDates