use AdventureWorksLT2022
Go



SELECT column_name, column_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'AdventureWorksLT2022' AND table_name = 'SalesLT';
