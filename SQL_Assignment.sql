-- 1)  Create two tables: EmployeeDetails and EmployeeSalary. Columns for
--EmployeeDetails: EmpId FullName ManagerId DateOfJoining City && Columns for 
    --EmployeeSalary: : EmpId Project Salary Variable.

-- Create the EmployeeDetails table
CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(255),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(50)
);

-- Create the EmployeeSalary table
CREATE TABLE EmployeeSalary (
    EmpId INT PRIMARY KEY,
    Project VARCHAR(255),
    Salary DECIMAL(10,2),
    Variable DECIMAL(10,2)
);

-- Insert data into EmployeeDetails table
INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES
    (12, 'VISHAL ', 23, '2019-05-22', 'HYDERABAD'),
    (23, 'RAMYA', 34, '2020-08-15', 'HYDERABAD'),
    (34, 'SAI RAM',12 , '2018-06-09', 'CHENNAI'),
    (56, 'RAINA', 34, '2018-09-21', 'MUMBAI'),
    (45, 'SARA', 56, '2020-01-28', 'BANGALORE');

-- Insert data into EmployeeSalary table
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
    (12, 'Project X', 30000, 10000),
    (34, 'Project Y', 60000, 9000),
    (45, 'Project Z', 90000, 11000);

-- 2) SQL Query to fetch records that are present in one table but not in another table.


SELECT ed.*
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es ON ed.EmpId = es.EmpId
WHERE es.EmpId IS NULL;

-- 3) SQL query to fetch all the employees who are not working on any project.

SELECT ed.*
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es ON ed.EmpId = es.EmpId
WHERE es.Project IS NULL;

-- 4) SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

SELECT *
FROM EmployeeDetails
WHERE DateOfJoining >= '2020-01-01' AND DateOfJoining < '2021-01-01';

-- 5) Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

SELECT ed.*
FROM EmployeeDetails ed
INNER JOIN EmployeeSalary es ON ed.EmpId = es.EmpId;

-- 6) Write an SQL query to fetch a project-wise count of employees.

SELECT Project, COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;

-- 7) Fetch employee names and salaries even if the salary value is not present for the employee.

SELECT ed.FullName, COALESCE(es.Salary, 'N/A') AS Salary
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es ON ed.EmpId = es.EmpId;

-- 8) Write an SQL query to fetch all the Employees who are also managers.

SELECT e.*
FROM EmployeeDetails e
INNER JOIN EmployeeDetails m ON e.EmpId = m.ManagerId;

-- 9) Write an SQL query to fetch duplicate records from EmployeeDetails.

SELECT EmpId, FullName, ManagerId, DateOfJoining, City, COUNT(*) AS DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId, FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1;

-- 10) Write an SQL query to fetch only odd rows from the table.

SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
  FROM EmployeeDetails
) AS T
WHERE T.RowNum % 2 = 1;

-- 11) Write a query to find the 3rd highest salary from a table without top or limit keyword.

SELECT Salary
FROM EmployeeSalary
WHERE Salary < (
    SELECT MAX(Salary)
    FROM EmployeeSalary
    WHERE Salary < (
        SELECT MAX(Salary)
        FROM EmployeeSalary
    )
)
ORDER BY Salary DESC
LIMIT 1;
