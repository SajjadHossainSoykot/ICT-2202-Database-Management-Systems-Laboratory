Consider following databases and draw ER diagram and convert entities and relationships to relation table for a given scenario. And, perform the following using SQL:
1.	Create college database.
2.	Viewing all Tables in a Database.
3.	Creating Tables (With and Without Constraints).
4.	Inserting/Updating/Deleting Records in a Table.
5.	Add a new column PINCODE with not null constraints to the existing table DEPT.
6.	Rename the column DNAME to DEPT_NAME in dept table.
7.	Increase the final marks 15%.
8.	Find the student names with their corresponding marks.
9.	Delete all data in a table DEPT.
10.	Delete table DEPT.
11.	Find the student address who has taken three or more courses in a semester.
12.	Insert data in the college database using PHP form.
13.	Retrieve data from the college database using PHP.

COLLEGE DATABASE:
STUDENT (USN, SName, Address, Phone, Gender)
SEMSEC (SSID, Sem, Sec)
CLASS (USN, SSID)
SUBJECT (Subcode, Title, Sem, Credits)
IAMARKS (USN, Subcode, SSID, Test1, Test2, Test3, FinalIA)
*USN=unique University Seat Number
*SSIN=Statewide Student Identifier


Source Codes and Answer by Soykot:         

1. Create college database:
CREATE DATABASE college; USE college;

2. Viewing all Tables in a Database:
SHOW TABLES;

3. Creating Tables (With and Without Constraints):

-- Creating STUDENT table with constraints
CREATE TABLE STUDENT (
    USN VARCHAR(10) PRIMARY KEY,
    SName VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    Phone VARCHAR(15),
    Gender CHAR(1)
);

-- Insert sample data into STUDENT table
INSERT INTO STUDENT (USN, SName, Address, Phone, Gender)
VALUES 
    ('S001', 'John Doe', '123 Main St, City, Country', '1234567890', 'Male'),
    ('S002', 'Jane Smith', '456 Elm St, City, Country', '9876543210', 'Female'),
    ('S003', 'Alice Johnson', '789 Oak St, City, Country', '5551234567', 'Female');

-- Creating SEMSEC table without constraints
CREATE TABLE SEMSEC (
    SSID VARCHAR(10) PRIMARY KEY,
    Sem INT,
    Sec CHAR(1)
);

-- Insert sample data into SEMSEC table
INSERT INTO SEMSEC (SSID, Sem, Sec)
VALUES 
    ('SS001', 1, 'A'),
    ('SS002', 1, 'B'),
    ('SS003', 2, 'A');

CREATE TABLE CLASS (
    USN VARCHAR(10),
    SSID VARCHAR(10),
    PRIMARY KEY (USN, SSID),
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);

-- Insert sample data into CLASS table
INSERT INTO CLASS (USN, SSID)
VALUES 
    ('S001', 'SS001'),
    ('S001', 'SS002'),
    ('S002', 'SS001'),
    ('S002', 'SS003'),
    ('S003', 'SS003');

CREATE TABLE SUBJECT (
    Subcode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(100),
    Sem INT,
    Credits INT
);

-- Insert sample data into SUBJECT table
INSERT INTO SUBJECT (Subcode, Title, Sem, Credits)
VALUES 
    ('SUB001', 'Mathematics', 1, 3),
    ('SUB002', 'English', 1, 3),
    ('SUB003', 'Science', 2, 4);

CREATE TABLE DEPT (
    DeptCode VARCHAR(10) PRIMARY KEY,
    DName VARCHAR(100)
);

CREATE TABLE IAMARKS (
    USN VARCHAR(10),
    Subcode VARCHAR(10),
    SSID VARCHAR(10),
    Test1 INT,
    Test2 INT,
    Test3 INT,
    FinalIA INT,
    PRIMARY KEY (USN, Subcode, SSID),
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (Subcode) REFERENCES SUBJECT(Subcode),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);

-- Insert sample data into IAMARKS table
INSERT INTO IAMARKS (USN, Subcode, SSID, Test1, Test2, Test3, FinalIA)
VALUES 
    ('S001', 'SUB001', 'SS001', 80, 85, 75, 90),
    ('S001', 'SUB002', 'SS001', 75, 80, 70, 85),
    ('S001', 'SUB003', 'SS001', 75, 80, 70, 85),
    ('S002', 'SUB001', 'SS001', 85, 90, 80, 95),
    ('S002', 'SUB003', 'SS003', 90, 85, 95, 92),
    ('S003', 'SUB003', 'SS003', 85, 90, 88, 94);

4 . Inserting/Updating/Deleting Records in a Table:
-- Inserting records into STUDENT table
INSERT INTO STUDENT VALUES ('123', ‘Soykot’, ‘IU’, '123-456-7890', 'M');
-- Updating record in STUDENT table
UPDATE STUDENT SET Phone = '987-654-3210' WHERE USN = '123';
-- Deleting record from STUDENT table
DELETE FROM STUDENT WHERE USN = '123';

5.  Add a new column PINCODE with not null constraints to the existing table DEPT:
ALTER TABLE DEPT ADD COLUMN PINCODE INT NOT NULL;

6.  Rename the column DName to DEPT_NAME in dept table:
ALTER TABLE dept
CHANGE COLUMN DName DEPT_NAME VARCHAR(255);

7.  Increase the final marks 15%:
UPDATE iamarks
SET FinalIA = FinalIA * 1.15;

8.  Find the student names with their corresponding marks.:
SELECT S.Sname, I.Test1, I.Test2, I.Test3, I.FinalIA
FROM STUDENT S
JOIN IAMARKS I ON S.USN = I.USN;

9.  Delete all data in a table DEPT:
DELETE FROM DEPT;

10.  Delete table DEPT:
DROP TABLE DEPT; 

11. Find the student address who has taken three or more courses in a semester:
SELECT DISTINCT S.Address
FROM STUDENT S
JOIN IAMARKS I ON S.USN = I.USN
HAVING COUNT(DISTINCT I.Subcode) >= 3;

12.  Insert data in the college database using PHP form.
To do this first we need to run XAAMP PHP Server. We Need to create 2 php files( Such as: form.php, insert.p¬¬hp)  in a folder such as name Experiment1. The folder must be on C:\xampp\htdocs\Experiment1 this directory. We will do the form design in form_student.php file and style.css file. Other insertion and database connection will be done on insert_student.php file. We will run the form._student.php in the browser. The address will be http://localhost/Experiment1/form_student.php. 
Now lets see the codes for the files.  
 
form_student.php.
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Student Form</title>
</head>

<body>

    <div class="container">
        <h2>Insert Student Data</h2>
        <form action="insert_student.php" method="post">
            <label for="usn">USN:</label>
            <input type="text" id="usn" name="usn" required>
            <label for="sname">Name:</label>
            <input type="text" id="sname" name="sname" required>
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" required>
            <label for="gender">Gender:</label>
            <input type="text" id="gender" name="gender" required><br><br>
            <!-- This line was a problem -->
            <input type="submit" class="btn btn-primary" name="submit" value="Submit">
        </form>

        <h2>Retrieve Student Data</h2>
        <form action="retrieve_student.php" method="post">
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
input[type="text"] {
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

 
insert_student.php
<?php
$conn = mysqli_connect('localhost', 'root', '', "college");
if (!$conn) {
    die('Could not Connect MySql Server:' . mysqli_error($conn));
}

if (isset($_POST['submit'])) {
    // Get data from the form
    $usn = $_POST["usn"];
    $sname = $_POST["sname"];
    $address = $_POST["address"];
    $phone = $_POST["phone"];
    $gender = $_POST["gender"];
    $sql = "INSERT INTO student(USN, SName, Address, Phone, Gender)
        VALUES ('$usn', '$sname', '$address', '$phone', '$gender')";

    
if (mysqli_query($conn, $sql)) {
        echo "New record has been added successfully !";
    } else {
        echo "Error: " . $sql . ":-" . mysqli_error($conn);
    }
    mysqli_close($conn);
}

?>



 
13. Retrieve data from the college database using PHP.
Same process as before. Here we will do the work in retrive_student.php file. We run the form_student.php then select the option retrive. 

Retrive_student.php
<?php
$conn = mysqli_connect('localhost', 'root', '', "college");
if (!$conn) {
    die('Could not Connect MySql Server:' . mysqli_error($conn));
}
// SQL query to retrieve data from STUDENT table
$sql = "SELECT * FROM STUDENT";
$result = $conn->query($sql);

// Display data
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "USN: " . $row["USN"] . " - Name: " . $row["SName"] . " - Address: " . $row["Address"] . "<br>";
    }
} else {
    echo "0 results";
}
?>
