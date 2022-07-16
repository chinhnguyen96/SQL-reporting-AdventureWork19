--P&L Statement
-- 1 Cal GL Amount each month of 2010, 2011, 2012
SELECT f.Date, ds.ScenarioName, SUM(f.Amount) as GL_Amount
FROM dbo.FactFinance f
JOIN DimScenario ds
ON f.ScenarioKey = ds.ScenarioKey
WHERE f.DateKey BETWEEN 20100101 AND 20121231 AND (ds.ScenarioName = 'Actual')
GROUP BY f.Date, month(f.Date), ds.ScenarioName
ORDER BY f.Date

-- 2. List departments with GL Amount > 5.000.000
SELECT f.Date,ds.ScenarioName, dd.DepartmentGroupName, SUM(f.Amount) as GL_Amount
FROM dbo.FactFinance f
JOIN DimScenario ds
ON f.ScenarioKey = ds.ScenarioKey
JOIN DimDepartmentGroup dd
ON f.DepartmentGroupKey = dd.DepartmentGroupKey
GROUP BY f.Date, dd.DepartmentGroupName,ds.ScenarioName
HAVING SUM(f.Amount) > 5000000 AND (ds.ScenarioName = 'Actual') 
ORDER BY f.Date

-- 3. Show GL Amount
SELECT da.AccountDescription as Report_Section, da.AccountType as Report_Heading, SUM(f.Amount) as GL_Amount 
FROM FactFinance f
JOIN DimAccount da
ON f.AccountKey = da.Accountkey
GROUP BY da.AccountDescription, da.AccountType

-- 4. GL Var
SELECT f.Date, do.OrganizationName,VAR(f.Amount) as GL_Varience
FROM dbo.FactFinance f
JOIN DimOrganization do
ON f.OrganizationKey = do.OrganizationKey
GROUP BY f.Date, do.OrganizationName

-- 5. List out in Jan 2012
SELECT f.Date, da.AccountDescription as Report_Section, da.AccountType as Report_Heading, da.ValueType as GL_Budget, SUM(f.Amount) as GL_Amount, VAR(f.Amount) as GL_Varience
FROM FactFinance f
JOIN DimAccount da
ON f.AccountKey = da.Accountkey
WHERE f.DateKey BETWEEN 20120101 AND 20120131
GROUP BY f.Date, da.AccountType, da.AccountDescription, da.AccountType,da.ValueType
ORDER BY f.Date