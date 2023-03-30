-- 1. Найти максимальную цену товара (ListPrice) из
-- таблицы Production.Product.
SELECT MAX(ListPrice) AS MaxListPrice
FROM Production.Product;
-- 2. Найти минимальный вес (Weight) из таблицы Production.Product,
-- не учитывать пустые значени¤.
SELECT MAX(Weight) AS MaxWeight 
FROM Production.Product 
WHERE Weight IS NOT NULL;
-- 3. Найти средний возраст мужчин и женщин из таблицы 
-- HumanResources.Employee, не учитывать пустые значени¤.
SELECT Gender, AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) AS AvgBirthDate
FROM HumanResources.Employee 
WHERE BirthDate IS NOT NULL
GROUP BY Gender;
-- 4. Вывести страны, где количество городов = 1, из таблицы 
-- Person.StateProvince (из выборки исключить пустые поля).
SELECT CountryRegionCode
FROM Person.StateProvince
GROUP BY CountryRegionCode
HAVING COUNT(*) = 1;
-- 5. Вывести BusinessEntityID, LastReceiptDate и среднее по 
-- StandardPrice дл¤ BusinessEntityID с разными LastReceiptDate, 
-- предусмотреть вывод общего среднего дл¤ всех StandardPrice у 
-- различных BusinessEntityID из таблицы Purchasing.ProductVendor. 
-- (использовать ROOLUP)
SELECT BusinessEntityID, LastReceiptDate, AVG(StandardPrice) AS AvgStandardPrice
FROM Purchasing.ProductVendor
GROUP BY ROLLUP (BusinessEntityID, LastReceiptDate);
