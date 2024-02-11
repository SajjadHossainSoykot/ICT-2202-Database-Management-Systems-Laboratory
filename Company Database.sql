Consider following databases and draw ER diagram and convert entities and relationships to relation table for a given scenario. And, perform the following using SQL:
1.	Create company database.
2.	Viewing all databases.
3.	Viewing all Tables in a database.
4.	Creating Tables (With and Without Constraints).
5.	Inserting/Updating/Deleting Records in a Table.
6.	Retrieve total salary of employee group by employee name and count similar names.
7.	Display name of employee in ascending order.
8.	Display name of employee in descending order.
9.	Retrieve employee number and their salary.
10.	Retrieve average salary of all employee.
11.	Retrieve distinct number of employees.
12.	Retrieve the name of employees and their dept name.
13.	Retrieve the name of employees who born in the year 1990.
14.	Retrieve total salary of employee which is greater than >120000.
15.	Display details of employee whose name is AMIT and salary greater than 50000.
16.	How the resulting salaries if every employee working on the ‘Research’ Departments is given a 10 percent raise.
17.	Insert data in the company database using PHP form.
18.	Retrieve data from the company database using PHP.


COMPANY DATABASE:
EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN, DNo)
DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate)
DLOCATION (DNo,DLoc)
PROJECT (PNo, PName, PLocation, DNo)
WORKS_ON (SSN, PNo, Hours)

*SSN = Social Security Number
*DNo = Department Number
*DLoc = Department Location
*PNo= Project Number

 
Source Codes and Answer by Soykot:         

1. Create company database:
CREATE DATABASE IF NOT EXISTS COMPANY;

2. Viewing all databases.
SHOW DATABASES;

3. Viewing all Tables in a database.
SHOW TABLES FROM COMPANY;

4. Creating Tables (With and Without Constraints):
-- Create the EMPLOYEE table
CREATE TABLE IF NOT EXISTS EMPLOYEE (
    SSN INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL, 
    Address VARCHAR(255),
    Sex CHAR(1),
    DateOfBirth DATE,
    Salary DECIMAL(10, 2),
    SuperSSN INT,
    DNo INT,
    FOREIGN KEY (SuperSSN) REFERENCES EMPLOYEE(SSN)
);

-- Insert sample data into the EMPLOYEE table
INSERT INTO EMPLOYEE (SSN, Name, Address, Sex, DateOfBirth, Salary, SuperSSN, DNo)
VALUES 
(123456789, 'John Doe', '123 Main St', 'M', '1980-05-15', 60000.00, NULL, 1),
(987654321, 'Jane Smith', '456 Oak St', 'F', '1975-10-20', 70000.00, 123456789, 2),
(111223344, 'Alice Johnson', '789 Elm St', 'F', '1988-03-25', 55000.00, 123456789, 1),
(888999000, 'Amit', '999 Oak St', 'M', '1987-11-05', 70000.00, 987654321, 3),
(444555666, 'Bob Brown', '321 Maple St', 'M', '1990-12-10', 65000.00, 987654321, 3),
(555666777, 'Sarah Johnson', '555 Pine St', 'F', '1982-08-12', 60000.00, NULL, 2),
(666777888, 'Michael Williams', '777 Cedar St', 'M', '1970-06-30', 80000.00, NULL, 3),
(777888999, 'Emily Davis', '888 Birch St', 'F', '1990-02-18', 75000.00, 123456789, 1),
(999000111, 'Sophia Taylor', '111 Walnut St', 'F', '1992-09-20', 55000.00, 123456789, 1),
(123000456, 'Matthew Anderson', '456 Elm St', 'M', '1984-04-10', 65000.00, 987654321, 2);


-- Create the DEPARTMENT table
CREATE TABLE IF NOT EXISTS DEPARTMENT (
    DNo INT PRIMARY KEY,
    DName VARCHAR(255),
    MgrSSN INT,
    MgrStartDate DATE,
    FOREIGN KEY (MgrSSN) REFERENCES EMPLOYEE(SSN)
);


-- Insert sample data into the DEPARTMENT table
INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate)
VALUES 
(1, 'HR', 123456789, '2022-01-01'),
(2, 'IT', 987654321, '2022-01-01'),
(3, 'Research', 444555666, '2022-01-01');

-- Adding Foreign Key After Creation and Insertion
ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_department
FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo);

-- Create the DLOCATION table
CREATE TABLE IF NOT EXISTS DLOCATION (
    DNo INT,
    DLoc VARCHAR(255),
    PRIMARY KEY (DNo, DLoc),
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

-- Insert sample data into the DLOCATION table
INSERT INTO DLOCATION (DNo, DLoc)
VALUES 
(1, 'New York'),
(2, 'San Francisco'),
(3, 'Boston');

-- Create the PROJECT table
CREATE TABLE IF NOT EXISTS PROJECT (
    PNo INT PRIMARY KEY,
    PName VARCHAR(255),
    PLocation VARCHAR(255),
    DNo INT,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

-- Insert sample data into the PROJECT table
INSERT INTO PROJECT (PNo, PName, PLocation, DNo)
VALUES 
(1, 'Project A', 'New York', 1),
(2, 'Project B', 'San Francisco', 2),
(3, 'Project C', 'Boston', 3);

-- Create the WORKS_ON table
CREATE TABLE IF NOT EXISTS WORKS_ON (
    SSN INT,
    PNo INT,
    Hours INT,
    PRIMARY KEY (SSN, PNo),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (PNo) REFERENCES PROJECT(PNo)
);

-- Insert sample data into the WORKS_ON table
INSERT INTO WORKS_ON (SSN, PNo, Hours)
VALUES 
(123456789, 1, 40),
(987654321, 2, 35),
(111223344, 3, 30),
(444555666, 1, 45);


5 . Inserting/Updating/Deleting Records in a Table:
-- Insert a new department record
INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate)
VALUES (4, 'Finance', 555666777, '2023-01-01');

-- Update an existing department record
UPDATE DEPARTMENT
SET MgrSSN = 777888999 WHERE DNo = 4;

-- Delete a department record
DELETE FROM DEPARTMENT WHERE DNo = 4;

6.  Retrieve total salary of employee group by employee name and count similar names.
SELECT Name, SUM(Salary) AS TotalSalary, COUNT(*) AS NameCount
FROM EMPLOYEE
GROUP BY Name;

7. Display name of employee in ascending order
SELECT Name FROM EMPLOYEE ORDER BY Name ASC;

8.  Display name of employee in descending order
SELECT Name FROM EMPLOYEE ORDER BY Name DESC;

9.  Retrieve employee number and their salary.
SELECT SSN, Salary FROM EMPLOYEE;

10.  Retrieve average salary of all employee.
SELECT AVG(Salary) AS AverageSalary FROM EMPLOYEE; 

11. Retrieve distinct number of employees.
SELECT COUNT(DISTINCT SSN) AS UniqueEmployees FROM EMPLOYEE;

12.  Retrieve the name of employees and their dept name
SELECT e.Name, d.DName
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DNo = d.DNo;

13.  Retrieve the name of employees who born in the year 1990.
SELECT Name FROM EMPLOYEE WHERE YEAR(DateOfBirth) = 1990;

14.  Retrieve total salary of employee which is greater than >120000.
SELECT SUM(Salary) AS TotalSalary FROM EMPLOYEE WHERE Salary > 120000;

15.  Display details of employee whose name is AMIT and salary greater than 50000.
SELECT * FROM EMPLOYEE WHERE Name = 'AMIT' AND Salary > 50000;

16.  How the resulting salaries if every employee working on the ‘Research’ Departments is given a 10 percent raise.
UPDATE EMPLOYEE e
JOIN DEPARTMENT d ON e.DNo = d.DNo
SET e.Salary = e.Salary * 1.1
WHERE d.DName = 'Research';


17.  Insert data in the company database using PHP form.
To do this first we need to run XAAMP PHP Server. We Need to create 2 php files( Such as: form_employee.php, insert_employee.p¬¬hp)  in a folder such as name Experiment2. The folder must be on C:\xampp\htdocs\Experiment2 this directory. We will do the form design in form_employee.php file and style.css file. Other insertion and database connection will be done on insert_employee.php file. We will run the form_employee.php in the browser. The address will be http://localhost/Experiment2/form_employee.php. 
Now lets see the codes for the files.  
 
Form_employee.php
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Employee Form</title>
</head>
<body>
    <div class="container">
        <h2>Insert Employee Data</h2>
        <form action="insert_employee.php" method="post">
            <label for="ssn">SSN:</label>
            <input type="text" id="ssn" name="ssn" required>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            <label for="sex">Sex:</label>
            <select id="sex" name="sex" required>
                <option value="M">Male</option>
                <option value="F">Female</option>
            </select>
            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" required>
            <label for="salary">Salary:</label>
            <input type="number" id="salary" name="salary" required>
            <label for="super_ssn">Superior SSN:</label>
            <input type="text" id="super_ssn" name="super_ssn">
            <label for="department">Department No:</label>
            <input type="number" id="department" name="department" required><br><br>
            <input type="submit" class="btn btn-primary" name="submit" value="Submit">
        </form>

        <h2>Retrieve Employee Data</h2>
        <form action="retrieve_employee.php" method="post">
            <input type="submit" value="Retrieve">
        </form>
    </div>
</body>
</html>


 
style.css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}
.container {
    max-width: 600px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
h2 {
    color: #333;
}
form {
    margin-bottom: 20px;
}
label {
    display: block;
    margin-bottom: 5px;
    color: #333;
}
Input, select {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
input[type="submit"] {
    background-color: #4caf50;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
input[type="submit"]:hover {
    background-color: #45a049;
}


Insert_employee.php
<?php
$conn = mysqli_connect('localhost', 'root', '', 'company');
if (!$conn) {
    die('Could not connect to MySQL server: ' . mysqli_connect_error());
}

if (isset($_POST['submit'])) {
    // Get data from the form
    $ssn = $_POST["ssn"];
    $name = $_POST["name"];
    $address = $_POST["address"];
    $sex = $_POST["sex"];
    $dob = $_POST["dob"];
    $salary = $_POST["salary"];
    $super_ssn = $_POST["super_ssn"];
    $department = $_POST["department"];
    // Insert data into the EMPLOYEE table
    $sql = "INSERT INTO EMPLOYEE (SSN, Name, Address, Sex, DateOfBirth, Salary, SuperSSN, DNo)
            VALUES ('$ssn', '$name', '$address', '$sex', '$dob', '$salary', '$super_ssn', '$department')";

    if (mysqli_query($conn, $sql)) {
        echo "New record has been added successfully!";
    } else {
        echo "Error: " . $sql . "<br>" . mysqli_error($conn);
    }
    mysqli_close($conn);
}
?>


 
18. Retrieve data from the company database using PHP.
Same process as before. Here we will do the work in retrieve_employee.php file. We run the form_employee.php then select the option retrieve. 

retrieve_employee.php
<?php
$conn = mysqli_connect('localhost', 'root', '', 'company');
if (!$conn) {
    die('Could not connect to MySQL server: ' . mysqli_connect_error());
}
// SQL query to retrieve data from EMPLOYEE table
$sql = "SELECT * FROM EMPLOYEE";
$result = mysqli_query($conn, $sql);
// Display data
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        echo "SSN: " . $row["SSN"] . " - Name: " . $row["Name"] . " - Sex: " . $row["Sex"] . " - Salary: " . $row["Salary"] . "<br>";
    }
} else {
    echo "0 results";
}

mysqli_close($conn);
?>


