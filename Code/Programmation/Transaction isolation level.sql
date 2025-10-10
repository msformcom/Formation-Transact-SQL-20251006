 -- SET TRANSACTION ISOLATION LEVEL CHAOS -- Aucun verrou
 -- Lecture des valeurs validées uniquement
  -- Lecture des valeurs même si non validées
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 -- Problème : Peut être bloquée si transaction en cours d'unautre user
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

-- SET TRANSACTION ISOLATION LEVEL  REPEATABLE READ => Verouiller tout ce que je lis
-- SELECT * FROM Personnes WHERE Credit=6 =>
	-- ligne avec credit 6 - bloquées
	--  INSERT avec credit=6 possible
-- SET TRANSACTION ISOLATION LEVEL  SERIALIZABLE => verouille tout
-- SELECT * FROM Personnes WHERE Credit=6 => INSERT avec credit=6 bloqué

SELECT TOP 10 * FROM Personnes ORDER BY Nom
