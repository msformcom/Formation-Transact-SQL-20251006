
-- Obtenir une selection avec toutes les dates entre les deux dates
-- Utiliser des variables de type TABLE => Plus rapide + plus simple
CREATE FUNCTION GetJours (
 @date1 DATE ,
 @date2 DATE
 )
 RETURNS  @MesDates TABLE(
	Date DATE
) AS 
BEGIN 
	-- Je travaille sur la table @MesDates
	WHILE @date1<=@date2
	BEGIN
		INSERT INTO @MesDates(Date) VALUES(@date1)
		SET @date1=DATEADD(day,1,@date1)
	END
	RETURN
END

SET DATEFORMAT DMY
SELECT * FROM GetJours('10/01/2006','25/12/2007')