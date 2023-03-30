-- 1. Показать адреса электронной почты (EmailAddress) и поля 
-- PersonType, FirstName, LastName из таблиц Person.Person, 
-- Person.EmailAddress.
SELECT Email.EmailAddress, Person.PersonType, Person.FirstName, Person.LastName
FROM Person.EmailAddress AS Email
INNER JOIN Person.Person AS Person
ON Person.BusinessEntityID = Email.BusinessEntityID;
-- 2. Показать список продуктов (поле Name) в котором указано, есть ли 
-- у продукта действительная цена (ActualCost) или нет, из таблиц 
-- Production.Product, Production.WorkOrderRouting, используя LEFT 
-- OUTER JOIN.
SELECT Product.[Name], Work.ActualCost
FROM Production.Product AS Product
LEFT OUTER JOIN Production.WorkOrderRouting AS Work
ON Product.ProductID = Work.ProductID;
-- 3. Показать список продуктов (поле Name) в котором указано, есть ли 
-- у продукта подкатегория или нет, из таблиц 
-- Production.ProductSubcategory, Production.Product, используя RIGHT 
-- OUTER JOIN.
SELECT Product.[Name], Subcategory. ProductSubcategoryID
FROM Production.ProductSubcategory AS Subcategory
RIGHT OUTER JOIN Production.Product AS Product
ON Subcategory.ProductSubcategoryID = Product.ProductSubcategoryID;
-- 4. Показать список подкатегорий продуктов (ProductSubcategoryID), 
-- которые имеют несколько нормативных цен (StandardCost), из таблицы 
-- Production.Product, используя SELF JOIN.SELECT DISTINCT Product1.ProductSubcategoryID, Product1.StandardCost
FROM Production.Product AS Product1
INNER JOIN Production.Product AS Product2
ON Product1.ProductSubcategoryID = Product2.ProductSubcategoryID
WHERE Product1.StandardCost <> Product2.StandardCost
ORDER BY ProductSubcategoryID;
-- 5. Показать список нормативных цен (StanderdCost), которые имеют 
-- несколько подкатегорий продуктов (ProductSubcategoryID), из таблицы 
-- Production.Product, используя SELF JOIN.SELECT DISTINCT Product1.StandardCost, Product1.ProductSubcategoryID
FROM Production.Product AS Product1
INNER JOIN Production.Product AS Product2
ON Product1.StandardCost = Product2.StandardCost
WHERE Product1.ProductSubcategoryID <> Product2.ProductSubcategoryID
ORDER BY StandardCost;
-- 6. Показать список типов спецпредложений (Type), которые имеют 
-- несколько значений минимального количества (MinQty) не меньше 15, 
-- из таблицы Sales.SpecialOffer, используя SELF JOIN.SELECT DISTINCT Sales1.Type, Sales1.MinQty
FROM Sales.SpecialOffer AS Sales1
INNER JOIN Sales.SpecialOffer AS Sales2
ON Sales1.Type = Sales2.Type
WHERE Sales1.MinQty <> Sales2.MinQty AND Sales1.MinQty > 15;
-- 7. Показать комбинированный список таблиц 
-- Person.BusinessEntityAddress, Person.BusinessEntityContact, 
-- используя UNION.SELECT *
FROM Person.BusinessEntityAddress
UNION
SELECT *
FROM Person.BusinessEntityContact;
-- 8. Показать список BusinessEntityID, которые содержатся в таблице 
-- Sales.SalesPerson, но не содержатся в таблице Sales.Store.SELECT BusinessEntityID
FROM Sales.SalesPerson
EXCEPT
SELECT BusinessEntityID
FROM Sales.Store;
