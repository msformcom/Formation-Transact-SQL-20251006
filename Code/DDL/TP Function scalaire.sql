-- Fonction scalaire Sales.CalculMarge
-- recoit => montant DECIMAL(18,2) => 1+montant*1.1

SELECT *,
	Sales.CalculMarge(unitprice) AS unitPriceWithMarge
 FROM production.Products

-- Ajouter le prix avec marge dans la definition de la vue ProductsWithCategorie

CREATE OR ALTER FUNCTION Sales.CalculMarge(
	@montant DECIMAL(18,2)
) 
RETURNS DECIMAL(18,2)AS
BEGIN 

	-- RETURN 2+@montant*1.1
	-- Si le montant <10 => 3
	-- sinon montant*1.3
	DECLARE @resultat DECIMAL(18,2)
	IF @montant<10 
		BEGIN
			SET @resultat=3
		END
	ELSE
		BEGIN
			SET @resultat=@montant*1.3
		END
	RETURN @Resultat
END 

SELECT Sales.CalculMarge(100)