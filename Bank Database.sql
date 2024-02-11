Consider following databases and draw ER diagram and convert entities and relationships to relation table for a given scenario. And, perform the following using SQL:
1.	Create bank database.
2.	Viewing all Tables in a Database.
3.	Creating and Inserting Tables (With and Without Constraints).
4.	Find the names of all branches in the loan relation
5.	Find all customers having a loan, an account or both at the bank
6.	Find all customers who have both a loan and account at the bank
7.	Find all customers of the bank who have loan but not account.
8.	Find all customers of the bank who have an account but not a loan.
9.	Find average account balance at each branch
10.	Find the average account balance in the Needham branch
11.	Find the number of depositors for each branch.
12.	For all customer s who have a loan from the bank, find their names, loan numbers, and loan amount
13.	Find the average account balance at each branch whose average balance is greater than 1200.
14.	Find all loan numbers for loans made at the Perryridge branch with loan amount greater than $1200
15.	Find the names of all customers whose street address includes the substring ‘main’
16.	Delete all loans with loan amounts between $1300 and $1500
17.	Delete all account tuples in the Perryridge branch
18.	Delete all account tuples at every branch located in Needham.
19.	Insert data in the bank database using PHP form.
20.	Retrieve data from the bank company database using PHP. 

Bank database:
branch(branch_name, branch city, assets)
customer (customer_name, customer_street, customer_city)
loan (loan_number, branch_name, amount)
borrower (customer_name, loan_number)
account (account_number, branch_name, balance )
depositor (customer_name, account_number)
 
Source Codes and Answer by Soykot:         

1. Create bank database.
-- Create the BANK database
CREATE DATABASE IF NOT EXISTS BANK;
USE BANK;

2. Viewing all Tables in a Database.
SHOW TABLES;

3. Creating and Inserting Tables (With and Without Constraints).

-- Create the BRANCH table
CREATE TABLE IF NOT EXISTS BRANCH (
    branch_name VARCHAR(255),
    branch_city VARCHAR(255),
    assets DECIMAL(10, 2),
    PRIMARY KEY (branch_name)
);

-- Insert sample data into the BRANCH table
INSERT INTO BRANCH (branch_name, branch_city, assets)
VALUES 
('Perryridge', 'New York', 500000.00),
('Brighton', 'Brooklyn', 300000.00),
('Downtown', 'Brooklyn', 800000.00),
('Mianus', 'Fairfield', 400000.00),
('North Town', 'Rye', 600000.00),
('Needham', 'Rye', 700000.00),
('Round Hill', 'Harrison', 900000.00);

-- Create the CUSTOMER table
CREATE TABLE IF NOT EXISTS CUSTOMER (
    customer_name VARCHAR(255),
    customer_street VARCHAR(255),
    customer_city VARCHAR(255),
    PRIMARY KEY (customer_name)
);

-- Insert sample data into the CUSTOMER table
INSERT INTO CUSTOMER (customer_name, customer_street, customer_city)
VALUES 
('John Smith', '123 Main St', 'New York'),
('Jane Doe', '456 Oak St', 'Brooklyn'),
('Alice Johnson', '789 Elm St', 'Rye'),
('Bob Brown', '321 Maple St', 'Fairfield'),
('Sarah Johnson', '555 Pine St', 'Rye'),
('Michael Williams', '777 Cedar St', 'Harrison'),
('Emily Davis', '888 Birch St', 'Rye'),
('Sophia Taylor', '111 Walnut St', 'New York');

-- Create the LOAN table
CREATE TABLE IF NOT EXISTS LOAN (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(255),
    amount DECIMAL(10, 2)
);

-- Insert sample data into the LOAN table
INSERT INTO LOAN (loan_number, branch_name, amount)
VALUES 
(1, 'Perryridge', 10000.00),
(2, 'Brighton', 20000.00),
(3, 'Downtown', 30000.00),
(4, 'Mianus', 15000.00),
(5, 'North Town', 25000.00),
(6, 'Perryridge', 18000.00),
(7, 'Round Hill', 22000.00);

-- Create the BORROWER table
CREATE TABLE IF NOT EXISTS BORROWER (
    customer_name VARCHAR(255),
    loan_number INT,
    PRIMARY KEY (customer_name, loan_number),
    FOREIGN KEY (customer_name) REFERENCES CUSTOMER(customer_name),
    FOREIGN KEY (loan_number) REFERENCES LOAN(loan_number)
);

-- Insert sample data into the BORROWER table
INSERT INTO BORROWER (customer_name, loan_number)
VALUES 
('John Smith', 1),
('Jane Doe', 2),
('Alice Johnson', 3),
('Bob Brown', 4),
('Sarah Johnson', 5),
('Emily Davis', 6),
('Sophia Taylor', 7);

-- Create the ACCOUNT table
CREATE TABLE IF NOT EXISTS ACCOUNT (
    account_number INT PRIMARY KEY,
    branch_name VARCHAR(255),
    balance DECIMAL(10, 2)
);

-- Insert sample data into the ACCOUNT table
INSERT INTO ACCOUNT (account_number, branch_name, balance)
VALUES 
(101, 'Perryridge', 15000.00),
(102, 'Brighton', 25000.00),
(103, 'Downtown', 35000.00),
(104, 'Mianus', 20000.00),
(105, 'North Town', 30000.00),
(106, 'Perryridge', 18000.00),
(107, 'Round Hill', 22000.00);

-- Create the DEPOSITOR table
CREATE TABLE IF NOT EXISTS DEPOSITOR (
    customer_name VARCHAR(255),
    account_number INT,
    PRIMARY KEY (customer_name, account_number),
    FOREIGN KEY (customer_name) REFERENCES CUSTOMER(customer_name),
    FOREIGN KEY (account_number) REFERENCES ACCOUNT(account_number)
);

-- Insert sample data into the DEPOSITOR table
INSERT INTO DEPOSITOR (customer_name, account_number)
VALUES 
('John Smith', 101),
('Jane Doe', 102),
('Alice Johnson', 103),
('Bob Brown', 104),
('Sarah Johnson', 105),
('Emily Davis', 106),
('Sophia Taylor', 107);

4. Find the names of all branches in the loan relation
SELECT DISTINCT branch_name FROM loan;

5. Find all customers having a loan, an account or both at the bank
SELECT DISTINCT customer_name FROM (
    SELECT customer_name FROM borrower
    UNION
    SELECT customer_name FROM depositor
) AS customers_with_accounts_or_loans;

6. Find all customers who have both a loan and account at the bank
SELECT b.customer_name 
FROM borrower b
INNER JOIN depositor d ON b.customer_name = d.customer_name;

7. Find all customers of the bank who have loan but not account.
SELECT DISTINCT customer_name FROM borrower
WHERE customer_name NOT IN (SELECT customer_name FROM depositor);

8. Find all customers of the bank who have an account but not a loan.
SELECT DISTINCT customer_name FROM depositor
WHERE customer_name NOT IN (SELECT customer_name FROM borrower);

9. Find average account balance at each branch
SELECT branch_name, AVG(balance) AS avg_balance
FROM account
GROUP BY branch_name;

10. Find the average account balance in the Needham branch
SELECT AVG(balance) AS avg_balance
FROM account
WHERE branch_name = 'Needham';

11. Find the number of depositors for each branch.
SELECT a.branch_name, COUNT(DISTINCT d.customer_name) AS num_depositors
FROM depositor d
JOIN account a ON d.account_number = a.account_number
GROUP BY a.branch_name;

12. For all customer s who have a loan from the bank, find their names, loan numbers, and loan amount
SELECT borrower.customer_name, loan.loan_number, loan.amount
FROM borrower
JOIN loan ON borrower.loan_number = loan.loan_number;

13. Find the average account balance at each branch whose average balance is greater than 1200.
SELECT branch_name, AVG(balance) AS avg_balance
FROM account
GROUP BY branch_name
HAVING avg_balance > 1200;

14. Find all loan numbers for loans made at the Perryridge branch with loan amount greater than $1200
SELECT loan_number
FROM loan
WHERE branch_name = 'Perryridge' AND amount > 1200;

15. Find the names of all customers whose street address includes the substring ‘main’
SELECT customer_name
FROM customer
WHERE customer_street LIKE '%main%';

16. Delete all loans with loan amounts between $1300 and $1500
DELETE FROM loan
WHERE amount BETWEEN 1300 AND 1500;

17. Delete all account tuples in the Perryridge branch
DELETE FROM depositor WHERE account_number IN (SELECT account_number FROM account WHERE branch_name = 'Perryridge');

18. Delete all account tuples at every branch located in Needham.
DELETE FROM account
WHERE branch_name IN (SELECT branch_name FROM branch WHERE branch_city = 'Needham');



19.  Insert data in the bank database using PHP form.
To do this first we need to run XAAMP PHP Server. We Need to create 2 php files( Such as: form_customer.php, insert_customer.p¬¬hp)  in a folder such as name Experiment3. The folder must be on C:\xampp\htdocs\Experiment3 this directory. We will do the form design in form_customer.php file and style.css file. Other insertion and database connection will be done on insert_customer.php file. We will run the form_customer.php in the browser. The address will be http://localhost/Experiment3/form_customer.php. 
Now lets see the codes for the files.  
 
form_customer.php
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Bank Database Form</title>
</head>

<body>
    <div class="container">
        <h2>Insert or Retrieve Customer Data</h2>
        <form action="insert_customer.php" method="post">
            <label for="customer_name">Customer Name:</label>
            <input type="text" id="customer_name" name="customer_name" required><br><br>
            <label for="customer_street">Street Address:</label>
            <input type="text" id="customer_street" name="customer_street" required><br><br>
            <label for="customer_city">City:</label>
            <input type="text" id="customer_city" name="customer_city" required><br><br>
            <input type="submit" class="btn btn-primary" name="insert" value="Insert Customer Data">
        </form>
        <form action="retrieve_customer.php" method="post">
            <input type="submit" class="btn btn-primary" name="retrieve" value="Retrieve Customer Data">
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
input, select {
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


insert_customer.php
<?php
// Connect to MySQL server
$conn = mysqli_connect('localhost', 'root', '', 'bank');

// Check connection
if (!$conn) {
    die('Could not connect to MySQL server: ' . mysqli_connect_error());
}

if (isset($_POST['insert'])) {
    // Get data from the form
    $customer_name = $_POST["customer_name"];
    $customer_street = $_POST["customer_street"];
    $customer_city = $_POST["customer_city"];

    // Insert data into the CUSTOMER table
    $customer_sql = "INSERT INTO CUSTOMER (customer_name, customer_street, customer_city)
                     VALUES ('$customer_name', '$customer_street', '$customer_city')";

    // Execute query
    if (mysqli_query($conn, $customer_sql)) {
        echo "Customer record has been added successfully!";
    } else {
        echo "Error: " . $customer_sql . "<br>" . mysqli_error($conn);
    }
}

// Close connection
mysqli_close($conn);
?>


 
20. Retrieve data from the bank database using PHP.
Same process as before. Here we will do the work in retrieve_customer.php file. We run the form_customer.php then select the option retrieve. 

retrieve_customer.php
<?php
// Connect to MySQL server
$conn = mysqli_connect('localhost', 'root', '', 'bank');

// Check connection
if (!$conn) {
    die('Could not connect to MySQL server: ' . mysqli_connect_error());
}

if (isset($_POST['retrieve'])) {
    // Retrieve customer data from the CUSTOMER table
    $sql = "SELECT * FROM CUSTOMER";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        // Output data of each row
        while ($row = mysqli_fetch_assoc($result)) {
            echo "Customer Name: " . $row["customer_name"] . "<br>";
            echo "Street Address: " . $row["customer_street"] . "<br>";
            echo "City: " . $row["customer_city"] . "<br>";
            echo "<br>";
        }
    } else {
        echo "No results found.";
    }
}

// Close connection
mysqli_close($conn);
?>



