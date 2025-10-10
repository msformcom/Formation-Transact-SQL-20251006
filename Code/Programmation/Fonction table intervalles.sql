-- Fonction de type table qui renvoit des intervalles
-- SELECT * FROM Intervalles(0,10,100)
-- | Debut		| Fin		|
-- | 0			| 10		|
-- | 10			| 20		|
-- | 20			| 30		|
-- ...
-- | 90			| 100		|


CREATE OR ALTER FUNCTION Intervalles(
 @Debut INT ,
 @Pas INT ,
 @Fin INT )
 RETURNS  @Resultats TABLE(
	Debut INT,
	Fin INT
) AS 
BEGIN

	WHILE @Debut < @Fin
	BEGIN
		INSERT INTO @Resultats(Debut,Fin) VALUES(@Debut,@Debut+@pas)
		SET @Debut=@Debut+@pas
	END
	RETURN
END


-- Donner le CA en fonction du prix du produit 
-- Par tranches de 100 € de 0 à 500
-- SELECT * FROM Intervalles(0,100,500)

-- Puis CA en fonction du prix produit
-- | Debut		| Fin		| CA		|
-- | 0			| 20		| 10101		|
-- | 20			| 40		| 189779	|
--- ...
-- | 80			| 100		| 8978979	|
SELECT * FROM Intervalles(0,20,1000)
SELECT Debut,Fin,
	ISNULL(SUM(unitprice*qty),0) AS Montant

 FROM Sales.OrderDetails SOD
RIGHT JOIN Intervalles(
	(SELECT MIN(unitprice) FROM Sales.orderdetails), -- Debut
	(SELECT (MAX(unitprice)-MIN(unitPrice))/10 FROM Sales.orderdetails),
	(SELECT MAX(unitprice) FROM Sales.orderdetails) -- Fin
	) I
ON SOD.unitprice>=I.Debut AND SOD.unitprice < I.fin
GROUP BY Debut,Fin