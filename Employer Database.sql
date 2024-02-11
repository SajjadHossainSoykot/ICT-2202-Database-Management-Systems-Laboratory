Consider following databases and draw ER diagram and convert entities and relationships to relation table for a given scenario. And, perform the following using SQL:

1.	Create Employer database.
2.	Viewing all Tables in a Database.
3.	Creating and Inserting Tables (With and Without Constraints).
4.	Modify the database so that Jones now lives in Newtown.
5.	Modify the database so that Johnson now lives in New York
6.	Find the company with the most employees.
7.	Find the company with the smallest payroll.
8.	Give all employees of First Bank Corporation a 10 percent salary raise.
9.	Give all managers in this database a 10 percent salary raise.
10.	Give all managers in this database a 10 percent salary raise, unless the salary would be greater than $100,000. In such cases, give only a 3 percent raise.
11.	Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.
12.	Delete all tuples in the works relation for employees of Small Bank Corporation.
13.	Insert data in the employer database using PHP form.
14.	Retrieve data from the employer company database using PHP.

Employer database:
employee (person-name, street, city)
works (person-name, company-name, salary) 
company (company-name, city)
manages (person-name, manager-name) 
Source Codes and Answer by Soykot:         

1. Create Employer database.
CREATE DATABASE IF NOT EXISTS Employer;
USE Employer;

2. Viewing all Tables in a Database.
SHOW TABLES;

3. Creating and Inserting Tables (With and Without Constraints).
-- Create employee table
CREATE TABLE IF NOT EXISTS employee (
    person_name VARCHAR(255) PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255)
);

-- Create works table
CREATE TABLE IF NOT EXISTS works (
    person_name VARCHAR(255),
    company_name VARCHAR(255),
    salary DECIMAL(10, 2),
    PRIMARY KEY (person_name, company_name),
    FOREIGN KEY (person_name) REFERENCES employee(person_name)
);

-- Create company table
CREATE TABLE IF NOT EXISTS company (
    company_name VARCHAR(255) PRIMARY KEY,
    city VARCHAR(255)
);

-- Create manages table
CREATE TABLE IF NOT EXISTS manages (
    person_name VARCHAR(255),
    manager_name VARCHAR(255),
    PRIMARY KEY (person_name),
    FOREIGN KEY (person_name) REFERENCES employee(person_name),
    FOREIGN KEY (manager_name) REFERENCES employee(person_name)
);

-- Insert sample data into employee table
INSERT INTO employee (person_name, street, city) VALUES
('Jones', '123 Main St', 'New York'),
('Johnson', '456 Oak St', 'Chicago'),
('Smith', '789 Elm St', 'Los Angeles'),
('Williams', '321 Maple St', 'Los Angeles'),
('Brown', '555 Pine St', 'Chicago'),
('Davis', '777 Cedar St', 'New York');

-- Insert sample data into works table
INSERT INTO works (person_name, company_name, salary) VALUES
('Jones', 'First Bank Corporation', 60000.00),
('Johnson', 'Small Bank Corporation', 70000.00),
('Smith', 'First Bank Corporation', 55000.00),
('Williams', 'First Bank Corporation', 65000.00),
('Brown', 'Small Bank Corporation', 60000.00),
('Davis', 'First Bank Corporation', 75000.00);

-- Insert sample data into company table
INSERT INTO company (company_name, city) VALUES
('First Bank Corporation', 'New York'),
('Small Bank Corporation', 'Chicago'),
('Second Bank Corporation', 'Chicago'),
('Third Bank Corporation', 'New York');

-- Insert sample data into manages table
INSERT INTO manages (person_name, manager_name) VALUES
('Jones', 'Johnson'),
('Williams', 'Jones'),
('Brown', 'Johnson'),
('Davis', 'Williams');

4. Modify the database so that Jones now lives in Newtown.
UPDATE employee SET city = 'Newtown' WHERE person_name = 'Jones';

5. Modify the database so that Johnson now lives in New York
UPDATE employee SET city = 'New York' WHERE person_name = 'Johnson';

6. Find the company with the most employees.
SELECT company_name
FROM works
GROUP BY company_name
ORDER BY COUNT(person_name) DESC
LIMIT 1;

7. Find the company with the smallest payroll.
SELECT company_name
FROM works
GROUP BY company_name
ORDER BY SUM(salary) ASC
LIMIT 1;
8. Give all employees of First Bank Corporation a 10 percent salary raise.
UPDATE works
SET salary = salary * 1.1
WHERE company_name = 'First Bank Corporation';

9. Give all managers in this database a 10 percent salary raise.
UPDATE works
SET salary = salary * 1.1
WHERE person_name IN (SELECT manager_name FROM manages);

10. Give all managers in this database a 10 percent salary raise, unless the salary would be greater than $100,000. In such cases, give only a 3 percent raise.
UPDATE works
SET salary = CASE 
                WHEN salary * 1.1 <= 100000 THEN salary * 1.1
                ELSE salary * 1.03
             END
WHERE person_name IN (SELECT manager_name FROM manages);

11. Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.
SELECT company_name
FROM works
GROUP BY company_name
HAVING AVG(salary) > (SELECT AVG(salary) FROM works WHERE company_name = 'First Bank Corporation');

12. Delete all tuples in the works relation for employees of Small Bank Corporation.
DELETE FROM works WHERE company_name = 'Small Bank Corporation';


13.  Insert data in the company database using PHP form.
To do this first we need to run XAAMP PHP Server. We Need to create 2 php files( Such as: form_company.php, insert_company.p¬¬hp)  in a folder such as name Experiment2. The folder must be on C:\xampp\htdocs\Experiment4 this directory. We will do the form design in form_company.php file and style.css file. Other insertion and database connection will be done on insert_company.php file. We will run the form_company.php in the browser. The address will be http://localhost/Experiment4/form_company.php. 
Now lets see the codes for the files.  
 
form_company.php
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Employer Form</title>
</head>

<body>
    <div class="container">
        <h2>Insert Company Data</h2>
        <form action="insert_company.php" method="post">
            <label for="company_name">Company Name:</label>
            <input type="text" id="company_name" name="company_name" required>
            <label for="city">City:</label>
            <input type="text" id="city" name="city" required><br><br>
            <input type="submit" class="btn btn-primary" name="submit" value="Submit">
        </form>

        <h2>Retrieve Company Data</h2>
        <form action="retrieve_company.php" method="post">
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


insert_company.php
<?php
$conn = mysqli_connect('localhost', 'root', '', ' employer ');
if (!$conn) {
    die('Could not connect to MySQL server: ' . mysqli_connect_error());
}

if (isset($_POST['submit'])) {
    // Get data from the form
    $company_name = $_POST["company_name"];
    $city = $_POST["city"];

    // Insert data into the COMPANY table
    $sql = "INSERT INTO company (company_name, city)
            VALUES ('$company_name', '$city')";

    if (mysqli_query($conn, $sql)) {
        echo "New record has been added successfully!";
    } else {
        echo "Error: " . $sql . "<br>" . mysqli_error($conn);
    }
    mysqli_close($conn);
}
?>



 
14. Retrieve data from the company database using PHP.
Same process as before. Here we will do the work in retrieve_company.php file. We run the form_company.php then select the option retrieve. 

retrieve_company.php
<?php
$conn = mysqli_connect('localhost', 'root', '', 'employer');
if (!$conn) {
    die('Could not connect to MySQL server: ' . mysqli_connect_error());
}

// Select data from the COMPANY table
$sql = "SELECT * FROM company";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    // Output data of each row
    while ($row = mysqli_fetch_assoc($result)) {
        echo "Company Name: " . $row["company_name"] . " - City: " . $row["city"] . "<br>";
    }
} else {
    echo "0 results";
}

mysqli_close($conn);
?>
