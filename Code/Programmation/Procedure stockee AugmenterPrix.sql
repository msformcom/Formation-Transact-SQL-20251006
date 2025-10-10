-- Procédure stockée

EXEC AugmenterPrix 1,0.10, 0.05
/*
	Augmente tous les prix des produits de 10% mais au moins de 1€
	Doit générer une erreur si l'augmentation Moyen est supérieure à 5%
*/
CREATE OR ALTER PROCEDURE AugmenterPrix(
 @min DECIMAL(18,2),  -- Minimum 1€
 @percentplus DECIMAL(18,2), -- 10% Sinon
 @percentmax DECIMAL(18,2)=0.05) -- Erreur si 5% augmentation totale
 AS 
 BEGIN
	BEGIN TRAN
		DECLARE @avant DECIMAL(18,2)=( SELECT SUM(unitprice) FROM Production.Products)
		PRINT @avant
		UPDATE Production.products 
		SET unitprice=IIF(unitprice*@percentplus>@min,unitprice*(1+@percentplus),unitprice+@min)
		DECLARE @apres DECIMAL(18,2)=( SELECT SUM(unitprice) FROM Production.Products)
		PRINT @apres
		SELECT @apres/@avant-1
		IF @apres > @avant *(1+@percentmax)
		BEGIN 
			ROLLBACK
			;THROW 50000,'Augmentation trop grande',1
		END

	COMMIT
END
--UPDATE production.products SET unitprice=unitprice*20