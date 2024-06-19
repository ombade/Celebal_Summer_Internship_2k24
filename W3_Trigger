-- Drop tables if they exist (for demonstration purposes)
DROP TABLE IF EXISTS StudentDetails;
DROP TABLE IF EXISTS SubjectDetails;
DROP TABLE IF EXISTS StudentPreference;
DROP TABLE IF EXISTS Allotments;
DROP TABLE IF EXISTS UnallotedStudents;

-- Create StudentDetails table
CREATE TABLE StudentDetails (
    StudentId VARCHAR(20) PRIMARY KEY,
    StudentName VARCHAR(100),
    GPA DECIMAL(3,1),
    Branch VARCHAR(50),
    Section VARCHAR(10)
);

-- Insert sample data into StudentDetails
INSERT INTO StudentDetails (StudentId, StudentName, GPA, Branch, Section) VALUES
('159103036', 'Mohit Agarwal', 8.9, 'CCE', 'A'),
('159103037', 'Rohit Agarwal', 5.2, 'CCE', 'A'),
('159103038', 'Shohit Garg', 7.1, 'CCE', 'B'),
('159103039', 'Mrinal Malhotra', 7.9, 'CCE', 'A'),
('159103040', 'Mehreet Singh', 5.6, 'CCE', 'A'),
('159103041', 'Arjun Tehlan', 9.2, 'CCE', 'B');

-- Create SubjectDetails table
CREATE TABLE SubjectDetails (
    SubjectId VARCHAR(20) PRIMARY KEY,
    SubjectName VARCHAR(100),
    MaxSeats INT,
    RemainingSeats INT
);

-- Insert sample data into SubjectDetails
INSERT INTO SubjectDetails (SubjectId, SubjectName, MaxSeats, RemainingSeats) VALUES
('PO1491', 'Basics of Political Science', 60, 2),
('PO1492', 'Basics of Accounting', 120, 119),
('PO1493', 'Basics of Financial Markets', 90, 90),
('PO1494', 'Eco philosophy', 60, 50),
('PO1495', 'Automotive Trends', 60, 60);

-- Create StudentPreference table
CREATE TABLE StudentPreference (
    StudentId VARCHAR(20),
    SubjectId VARCHAR(20),
    Preference INT,
    PRIMARY KEY (StudentId, SubjectId),
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId),
    FOREIGN KEY (SubjectId) REFERENCES SubjectDetails(SubjectId)
);

-- Insert sample data into StudentPreference
INSERT INTO StudentPreference (StudentId, SubjectId, Preference) VALUES
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 2),
('159103036', 'PO1493', 3),
('159103036', 'PO1494', 4),
('159103036', 'PO1495', 5);

-- Create Allotments table
CREATE TABLE Allotments (
    SubjectId VARCHAR(20),
    StudentId VARCHAR(20),
    PRIMARY KEY (SubjectId),
    FOREIGN KEY (SubjectId) REFERENCES SubjectDetails(SubjectId),
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId)
);

-- Create UnallotedStudents table
CREATE TABLE UnallotedStudents (
    StudentId VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId)
);

-- Delimiter change for stored procedure creation
DELIMITER //

-- Create stored procedure for subject allocation
CREATE PROCEDURE AllocateSubjects()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE student_id VARCHAR(20);
    DECLARE subject_id VARCHAR(20);
    DECLARE preference INT;

    -- Cursor to iterate through students and their preferences
    DECLARE student_cursor CURSOR FOR 
        SELECT sp.StudentId, sp.SubjectId, sp.Preference
        FROM StudentPreference sp
        ORDER BY sp.StudentId, sp.Preference;

    -- Error handling
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN student_cursor;

    allocation_loop: LOOP
        FETCH student_cursor INTO student_id, subject_id, preference;
        IF done = 1 THEN
            LEAVE allocation_loop;
        END IF;

        -- Check if subject still has available seats
        DECLARE remaining_seats INT;
        SELECT RemainingSeats INTO remaining_seats
        FROM SubjectDetails
        WHERE SubjectId = subject_id;

        -- Variable to check if the subject has been allotted
        DECLARE subject_allotted INT DEFAULT 0;

        IF remaining_seats > 0 THEN
            -- Allocate subject to the student
            INSERT INTO Allotments (SubjectId, StudentId)
            VALUES (subject_id, student_id);

            -- Update remaining seats for the subject
            UPDATE SubjectDetails
            SET RemainingSeats = RemainingSeats - 1
            WHERE SubjectId = subject_id;

            -- Set subject_allotted flag
            SET subject_allotted = 1;
       
