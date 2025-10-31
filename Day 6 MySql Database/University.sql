-- Active: 1761808069171@@127.0.0.1@3306@universitydb
CREATE DATABASE IF NOT EXISTS UniversityDB;
USE UniversityDB;

-- 1. Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);

-- 2. Student Table
CREATE TABLE Student (
    StudentID VARCHAR(10) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

-- 3. Course Table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 4. Instructor Table
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 5. Enrollment Table
CREATE TABLE Enrollment (
    StudentID VARCHAR(10),
    CourseID INT,
    InstructorID INT,
    Grade CHAR(1),
    PRIMARY KEY (StudentID, CourseID, InstructorID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Department Data
INSERT INTO Department VALUES (1, 'Computer Science');

-- Student Data
INSERT INTO Student VALUES ('S101', 'Asha Gupta');
INSERT INTO Student VALUES ('S102', 'Raj Verma');

-- Course Data
INSERT INTO Course VALUES (101, 'Database Systems', 1);
INSERT INTO Course VALUES (102, 'Data Structures', 1);

-- Instructor Data
INSERT INTO Instructor VALUES (201, 'Dr. Mehta', 1);
INSERT INTO Instructor VALUES (202, 'Dr. Sharma', 1);

-- Enrollment Data
INSERT INTO Enrollment VALUES ('S101', 101, 201, 'A');
INSERT INTO Enrollment VALUES ('S102', 102, 202, 'B');
INSERT INTO Enrollment VALUES ('S101', 102, 202, 'A');

SELECT 
    s.StudentName,
    c.CourseName,
    i.InstructorName,
    d.DeptName,
    e.Grade
FROM Enrollment e
JOIN Student s ON e.StudentID = s.StudentID
JOIN Course c ON e.CourseID = c.CourseID
JOIN Instructor i ON e.InstructorID = i.InstructorID
JOIN Department d ON c.DeptID = d.DeptID;

SELECT 
    i.InstructorName,
    c.CourseName
FROM Instructor i
JOIN Course c ON i.DeptID = c.DeptID;


SELECT 
    s.StudentName,
    c.CourseName,
    e.Grade
FROM Enrollment e
JOIN Student s ON e.StudentID = s.StudentID
JOIN Course c ON e.CourseID = c.CourseID
WHERE s.StudentName = 'Asha Gupta';


-- Department Table
INSERT INTO Department VALUES (1, 'Computer Science');
INSERT INTO Department VALUES (2, 'Information Technology');

-- Student Table
INSERT INTO Student VALUES ('S101', 'Asha Gupta');
INSERT INTO Student VALUES ('S102', 'Raj Verma');
INSERT INTO Student VALUES ('S103', 'Neha Singh');
INSERT INTO Student VALUES ('S104', 'Karan Patel');
INSERT INTO Student VALUES ('S105', 'Pooja Sharma');

-- Course Table
INSERT INTO Course VALUES (101, 'Database Systems', 1);
INSERT INTO Course VALUES (102, 'Data Structures', 1);
INSERT INTO Course VALUES (103, 'Operating Systems', 1);
INSERT INTO Course VALUES (104, 'Web Technologies', 2);
INSERT INTO Course VALUES (105, 'Networking Basics', 2);

-- Instructor Table
INSERT INTO Instructor VALUES (201, 'Dr. Mehta', 1);
INSERT INTO Instructor VALUES (202, 'Dr. Sharma', 1);
INSERT INTO Instructor VALUES (203, 'Dr. Reddy', 2);

-- Enrollment Table
INSERT INTO Enrollment VALUES ('S101', 101, 201, 'A');
INSERT INTO Enrollment VALUES ('S102', 102, 202, 'B');
INSERT INTO Enrollment VALUES ('S103', 103, 201, 'A');
INSERT INTO Enrollment VALUES ('S104', 104, 203, NULL);  -- Grade not yet assigned
INSERT INTO Enrollment VALUES ('S105', 105, NULL, NULL); -- No instructor yet


SELECT 
    s.StudentName,
    c.CourseName,
    i.InstructorName,
    e.Grade
FROM Enrollment e
INNER JOIN Student s ON e.StudentID = s.StudentID
INNER JOIN Course c ON e.CourseID = c.CourseID
LEFT JOIN Instructor i ON e.InstructorID = i.InstructorID;


SELECT 
    c.CourseName,
    d.DeptName
FROM Course c
INNER JOIN Department d ON c.DeptID = d.DeptID;


SELECT 
    s.StudentName,
    c.CourseName,
    e.Grade
FROM Student s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
LEFT JOIN Course c ON e.CourseID = c.CourseID;


SELECT 
    i.InstructorName,
    c.CourseName
FROM Enrollment e
RIGHT JOIN Instructor i ON e.InstructorID = i.InstructorID
LEFT JOIN Course c ON e.CourseID = c.CourseID
WHERE e.StudentID IS NULL;


SELECT DISTINCT
    s.StudentID,
    s.StudentName,
    c.CourseName,
    e.Grade
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID
WHERE e.Grade = 'A';


-- Step 1: Create a derived mapping using CASE
SELECT 
    c.CourseID,
    c.CourseName,
    AVG(
        CASE e.Grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            ELSE NULL
        END
    ) AS AvgGrade
FROM Course c
JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING AVG(
        CASE e.Grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            ELSE NULL
        END
    ) = (
        -- Subquery: Find the highest average grade among all courses
        SELECT MAX(AvgGrade)
        FROM (
            SELECT 
                AVG(
                    CASE e2.Grade
                        WHEN 'A' THEN 4
                        WHEN 'B' THEN 3
                        WHEN 'C' THEN 2
                        WHEN 'D' THEN 1
                        ELSE NULL
                    END
                ) AS AvgGrade
            FROM Enrollment e2
            JOIN Course c2 ON e2.CourseID = c2.CourseID
            GROUP BY c2.CourseID
        ) AS CourseAverages
    );


SELECT i.InstructorID, i.InstructorName
FROM Instructor i
WHERE (
    SELECT COUNT(DISTINCT e.CourseID)
    FROM Enrollment e
    WHERE e.InstructorID = i.InstructorID
) > 1;


SELECT s.StudentID, s.StudentName
FROM Student s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollment e
);


SELECT
    s.StudentID,
    s.StudentName,
    c.CourseID,
    c.CourseName,
    i.InstructorID,
    i.InstructorName,
    d.DeptID,
    d.DeptName,
    e.Grade
FROM Student s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
LEFT JOIN Course c ON e.CourseID = c.CourseID
LEFT JOIN Instructor i ON e.InstructorID = i.InstructorID
LEFT JOIN Department d ON 
    COALESCE(c.DeptID, i.DeptID) = d.DeptID
ORDER BY s.StudentName, c.CourseName;
