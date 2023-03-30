-- 1. Показать все поля из Production.Document.
SELECT * FROM Production.Document;
-- 2. Показать поля ProductID, DocumentNode из
-- таблицы Production.ProductDocument.
SELECT ProductID, DocumentNode
FROM Production.ProductDocument;
-- 3. Показать поля ProductID, BusinessEntityID, AverageLeadTime, 
-- StandardPrice из таблицы Purchasing.ProductVendor, где средний 
-- промежуток времени (в днях) между размещением заказа у продавца и 
-- получением приобретенного продукта (AverageLeadTime) больше 16, а 
-- обычная отпускная цена продавца (StandardPrice) находится в 
-- диапазоне от $50 до $60. Использовать оператор BETWEEN.

SELECT ProductID, BusinessEntityID, AverageLeadTime, StandardPrice
FROM Purchasing.ProductVendor
WHERE AverageLeadTime > 16 AND StandardPrice BETWEEN 50 AND 60;
-- 4. Показать поля PurchaseOrderID, RevisionNumber, Status, ShipDate 
-- из таблицы Purchasing.PurchaseOrderHeader, для которых известна 
-- ориентировочная дата отгрузки от поставщика (ShipDate) и текущее 
-- состояние заказа "Ожидание" (= 1).

SELECT PurchaseOrderID, RevisionNumber, [Status], ShipDate
FROM Purchasing.PurchaseOrderHeader
WHERE ShipDate IS NOT NULL AND [Status] = 1;
-- 5. Показать cтандартный код ISO для стран и регионов 
-- (CountryRegionCode) и название страны или региона (Name), имеющие 
-- отношение к Конго (Congo) из таблицы Person.CountryRegion.

SELECT CountryRegionCode, [Name]
FROM Person.CountryRegion
WHERE [Name] LIKE '%Congo%';
-- 6. Показать поля AddressID, AddressLine1, City из таблицы 
-- Person.Address Показать только адреса из списка городов (Bothell, 
-- Dallas, Ottawa, Calgary). Использовать оператор IN.

SELECT AddressID, AddressLine1, City
FROM Person.Address
WHERE [City] IN ('Bothell', 'Dallas', 'Ottawa', 'Calgary');
-- 7. Показать поля BusinessEntityID, EmailAddressID и EmailAddress из 
-- таблицы Person.EmailAddress. Неизвестные значения поля EmailAddress 
-- заменить на 'no email'.

SELECT BusinessEntityID, EmailAddressID, ISNULL(EmailAddress, 'no email') AS EmailAddress
FROM Person.EmailAddress;
-- 8. Показать поля ProductID, Name из таблицы Production.Product с 
-- применением функции COALESCE(). Показать поле Meauserement, так, 
-- чтобы, если значение в поле известно Class, то показать его, а 
-- иначе, показать значение в поле Style. Если и в поле Style значение 
-- неизвестно, то вывести значение 'UNKNOWN'.

SELECT ProductID, [Name],
COALESCE(Class, Style, 'UNKNOWN') AS Meauserement
FROM Production.Product;
-- 9. Отсортировать строки таблицы Person.AddressType в алфавитном 
-- порядке наименования описания типа адреса (Name). Показать поля 
-- AddressTypeID и Name.

SELECT AddressTypeID, [Name]
FROM Person.AddressType
ORDER BY [Name] ASC;
-- 10. Заменить на NULL значение в поле цвет (Color), если цвет товара 
-- красный (red). Показать поля ProductID, Name, Color из таблицы 
-- Production.Product, если цвет товара определен (поле не пустое). 
SELECT ProductID, [Name], NULLIF(Color, 'Red')
FROM Production.Product
WHERE Color IS NOT NULL;
