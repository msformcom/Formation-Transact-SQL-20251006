/*
| Categorie | NomProduit | Nom Supplier |Productid| Productid | NombreVendus |

Pour 2007
Tables :[Production].[Categories], [Production].[Products],[Production].[Suppliers],[Sales].[OrderDetails],[Sales].[Orders]
1) Premiere selection InfosProduits avec Categorie | NomProduit | Nom Supplier |Productid
2) Deuxieme selection Ventes2007 => lignes de ventes de 2007 => productid | qty
3) Troixieme selection CumulVentes2007 => Regrouper les Ventes2007 par productid => productid | quantitevendue
4) Select final => Jointure entre CumulVentes2007 et InfosProduits


;WITH InfosProduits 
AS (...)
SELECT * FROM InfosProduits

;WITH InfosProduits AS 
	(
	SELECT ... => | Categorie | NomProduit | Nom Supplier |Productid|
	),
Ventes2007 AS 
	(
	SELECT ...  	=> |  Productid | Quantite |
	utilsable InfosProduits mais pas obligé
	),
CumulVentes2007 AS 
	(
	SELECT ... => |  Productid | CumulQuantiteVendue |
	utilsable Ventes2007 ou InfosProduits mais pas obligé
	)
SELECT ... => | Categorie | NomProduit | Nom Supplier | CumulQuantiteVendue |
utilsable CumulVentes2007, Ventes2007 ou InfosProduits

*/

;WITH InfosProduits AS (
				SELECT PP.productid AS ProductId,
						PP.productname AS NomProduit,
						PC.categoryname AS NomCategorie,
						PS.companyname AS NomFournisseur
					 FROM [Production].[Products] AS PP
				INNER JOIN [Production].[Categories] AS PC ON PC.categoryid=PP.categoryid
				INNER JOIN [Production].[Suppliers] AS PS ON PS.supplierid=PP.supplierid
),
Ventes2007 AS (
	SELECT SOD.productid,
			SOD.qty AS Quantite
	FROM [Sales].[Orders] AS SO
	INNER JOIN [Sales].[OrderDetails] AS SOD ON SO.orderid=SOD.orderid
	WHERE DATEPART(year, SO.orderdate)=2007
),
CumulVentes2007 AS (
SELECT	productid, 
		SUM(Quantite) QuantiteVendue 
FROM Ventes2007
GROUP BY productid
)
SELECT IP.*, CV.QuantiteVendue FROM CumulVentes2007 AS CV
INNER JOIN InfosProduits IP ON CV.productid=IP.ProductId
