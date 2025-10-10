-- Procedures stockées + Transactions
SELECT TOP 10 * FROM Personnes ORDER BY Nom

-- Virement de 1€ du credit de 
-- 23611C39-CBFF-46F1-B926-821CAC2B79FA vers 7AC298B4-8549-40D4-A3AD-D2481190CD82
CREATE OR ALTER PROCEDURE Transfert(
@idDebiteur UNIQUEIDENTIFIER,
@Montant DECIMAL(18,2),
@idCrediteur UNIQUEIDENTIFIER)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
		-- Block d'instruction avec gestion des erreurs
			UPDATE Personnes SET Credit=credit-@Montant WHERE id=@idDebiteur
			-- Alimentation down
			--SELECT 1/0
			UPDATE Personnes SET Credit=credit+@Montant WHERE id=@idCrediteur
			SELECT * FROM Personnes WHERE id IN (@idDebiteur, @idCrediteur)
		END TRY
		BEGIN CATCH
			ROLLBACK
			;THROW 50000,'Mal passé',1
		END CATCH
	COMMIT
END
-- TRANSACTION 
-- Atomicite => Tout ou rien => BEGIN TRAN COMMIT/ROLLBACK
-- Coherence
-- Isolation
-- Durablite => une fois validée RIEN ne doit peut l'annuler

EXEC Transfert '23611C39-CBFF-46F1-B926-821CAC2B79FA',10,'7AC298B4-8549-40D4-A3AD-D2481190CD82'

