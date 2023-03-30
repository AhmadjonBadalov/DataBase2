-- 1. Показать Фамилию Имя и Отчество самого молодого сотрудника
-- (Таблицы HumanResources.Employee и Person.Person).
-- Показать поля FirstName, MiddleName, LastName.
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE BusinessEntityID =
    (
        SELECT BusinessEntityID
        FROM HumanResources.Employee
		WHERE BirthDate =
			(
				SELECT MIN(BirthDate)
				FROM HumanResources.Employee
			)
    );
-- 2. Определить количество сотрудников и город, в
-- котором проживает максимальное число сотрудников
-- (Таблица Person.[Address]).
SELECT City, COUNT(*) AS LivingPersonCount
FROM Person.[Address]
WHERE City IS NOT NULL
GROUP BY City
HAVING COUNT(*) =
	(
		SELECT MAX(LivingPersonCount) AS MaxLivingPersonCount
		FROM
			(
				SELECT COUNT(*) AS LivingPersonCount
				FROM Person.[Address]
				WHERE City IS NOT NULL
				GROUP BY City
			)
		AS MaxLivingPersonCount
	);
-- 3. Показать категорию (ProductSubcategoryID) товаров, для 
-- которой существует более 7 размеров (Таблица Production.Product). 
-- Показать поля [Name], Size и ProductSubcategoryID.
SELECT Product1.ProductSubcategoryID
FROM Production.Product AS Product1
WHERE Product1.ProductSubcategoryID IS NOT NULL
AND Product1.Size IS NOT NULL
AND (
		SELECT COUNT(DISTINCT Product2.Size) AS SizeCount
		FROM Production.Product AS Product2
		WHERE Product2.Size IS NOT NULL
		AND Product1.ProductSubcategoryID =
		Product2.ProductSubcategoryID
	) > 7
GROUP BY ProductSubcategoryID;
-- 4. Показать товары, цена которых равна максимальной цене
-- товара из той же подкатегории (Таблица Production.Product). 
-- Показать поля [Name], ListPrice и ProductSubcategoryID.
SELECT Product1.[Name]
	, Product1.ListPrice
	, Product1.ProductSubcategoryID
FROM Production.Product AS Product1
JOIN
	(
		SELECT ProductSubcategoryID
			, MAX(ListPrice) AS MaxListPrice
		FROM Production.Product
		WHERE ProductSubcategoryID IS NOT NULL
		AND ListPrice > 0
		GROUP BY ProductSubcategoryID
	)
AS Product2
ON Product1.ProductSubcategoryID = Product2.ProductSubcategoryID
AND Product1.ListPrice = Product2.MaxListPrice;
-- 5. Показать товары, цена которых больше средней цены 
-- в любом размере (Таблица Production.Product). Показать 
-- поля [Name], Size и ListPrice.
SELECT [Name]
	, Size
	, ListPrice
FROM Production.Product
WHERE ListPrice > ANY
	(
		SELECT AVG(ListPrice) AS AvgListPrice
		FROM Production.Product
		WHERE Size IS NOT NULL
		GROUP BY Size
	);
