 SELECT 
 DATEADD(year,-1, DATEADD(YY, DATEPART(YYYY, GETDATE()) - DATEPART(YYYY,'1981-03-04'), '1981-03-04')) AS [Last Year], -- last year bday date
 DATEADD(YY, DATEPART(YYYY, GETDATE()) - DATEPART(YYYY,'1981-03-04'), '1981-03-04') AS [This Year] -- this year bday date
 
 