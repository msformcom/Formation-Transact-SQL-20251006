-- La liste des ventes avec le companyname du client

-- Liste des commandes limitées à celles ayant un client associéé
SELECT SO.orderid,
		SC.companyname FROM [Sales].[Orders] AS SO
INNER JOIN [Sales].[Customers] AS SC ON SO.custid=SC.custid

-- Liste des commandes non limitées à celles ayant un client associéé
SELECT SO.orderid,
		ISNULL(SC.companyname,'---') --  Remplacement des null par une valeur
		FROM [Sales].[Orders] AS SO
LEFT JOIN [Sales].[Customers] AS SC ON SO.custid=SC.custid

-- LEFT JOIN => Toutes les lignes de la table de gauche
-- RIGHT JOIN => Toutes les lignes de la table de droite    
-- FULL JOIN => Toutes les lignes des deux tables
-- inner JOIN => Seulement les lignes avec correspondance dans les deux tables


SELECT COUNT(*) FROM [Sales].[Orders]