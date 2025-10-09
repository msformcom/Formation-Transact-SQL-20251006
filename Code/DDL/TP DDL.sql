-- CRéer une table permettant de noter les produits
-- productid
-- note => TINYINT 
-- custid
-- DDL CREATE DROP ALTER
DROP TABLE Sales.Notes
CREATE TABLE Sales.Notes(
	productid INT NOT NULL,
	note TINYINT NOT NULL,
	custid INT NOT NULL
)
-- Clés étrangères 
ALTER TABLE sales.Notes 
ADD  FOREIGN KEY(productid) REFERENCES Production.products(productid)
ALTER TABLE sales.Notes 
ADD  FOREIGN KEY(custid) REFERENCES sales.customers(custid)
-- Clé primaire
ALTER TABLE  sales.Notes ADD PRIMARY KEY(productid,custid)


-- le client 5 donne la note 3 au produit 6
INSERT INTO  sales.Notes (productid,note,custid)
VALUES(6,3,5)--,(3,2,3)

-- le client 5 modifie la note du produit 6 => 5
BEGIN TRAN
UPDATE sales.Notes 
SET note=5 WHERE custid=5 AND productid=6 
SELECT * FROM Sales.Notes
COMMIT


-- le client 5 supprime sa note sur le produit 6
BEGIN TRAN
	DELETE FROM Sales.notes WHERE custid=5 AND productid=6 
	SELECT * FROM Sales.Notes WHERE custid=5 AND productid=6 
COMMIT

-- le client 5 donne la note 3 à tous les produits de la catégorie 5
BEGIN TRAN
INSERT INTO Sales.notes(productid,note,custid)
SELECT productid , 3, 5
FROM Production.Products WHERE categoryid=5

SELECT * FROM sales.notes
COMMIT

-- le client 5 augmente toutes les notes des produits de la categorie 5 de 1
BEGIN TRAN
UPDATE sales.notes
SET note=note+1
WHERE productid IN (
	SELECT productid FROM Production.Products WHERE categoryid=5
) -- valable dans SELECT 
COMMIT

SELECT * FROM Production.Products 
WHERE productid IN (1,5)
