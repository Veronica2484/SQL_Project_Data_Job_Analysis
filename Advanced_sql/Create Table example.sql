--Create Table
-- Notes: CREATE, creates tables from scratch
--Format:
-- CREATE TABLE table_name(
--     column_name datatype,
--     column_name2 datatype,
-- );
CREATE TABLE job_applied(
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);
SELECT *
FROM job_applied;
--INSERT INTO
--Notes: used to insert data into a table
--VALUES - Specify the data you want to ass
--INSERT INTO table_name (column_name, column_name2, ...)
-- VALUES (VALUE1, VALUE2, ...)
INSERT INTO job_applied (
        job_id,
        application_sent_date,
        custom_resume,
        resume_file_name,
        cover_letter_sent,
        cover_letter_file_name,
        status
    )
VALUES (
        1,
        '2024-02-01',
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'
    ),
    (
        2,
        '2024-02-02',
        true,
        'resume_02.pdf',
        true,
        'cover_letter_02.pdf',
        'submitted'
    ),
    (
        3,
        '2024-02-03',
        true,
        'resume_03.pdf',
        true,
        'cover_letter_03.pdf',
        'ghosted'
    ),
    (
        4,
        '2024-02-04',
        true,
        'resume_04.pdf',
        false,
        NULL,
        'submitted'
    ),
    (
        5,
        '2024-02-05',
        true,
        'resume_05.pdf',
        true,
        'cover_letter_05.pdf',
        'rejected'
    );
--ALTER TABLE
--Notes
--ALTER TABLE - used to select the tablet that you will add, delete, or modify columns in
-- Similar to using FROM to specify a table for querying
--ALTER TABLE table_name
--ADD column_name datatype;
--RENAME COLUMN column_name to new_name;
--ALTER_COLUMN column_name TYPE datatype;
--DROP COLUMN column_name
ALTER TABLE job_applied
ADD contact VARCHAR(50);
--UPDATE
--Notes
--UPDATE - used to modify existing data in a table.
--SET - specifies the column to be updated and the new value for that column.
--WHERE -filters which rows to update based on a condition
--UPDATE table_name
--SET column_name = 'new_value'
--WHERE condition;
UPDATE job_applied
SET contact = 'Erlich Bachman'
WHERE job_id = 1;
UPDATE job_applied
SET contact = 'Dinesh Chugtai'
WHERE job_id = 2;
UPDATE job_applied
SET contact = 'Bertram Gilfoyle'
WHERE job_id = 3;
UPDATE job_applied
SET contact = 'Jian Yang'
WHERE job_id = 4;
UPDATE job_applied
SET contact = 'Big Head'
WHERE job_id = 5;
--RENAME COLUMN
--Notes
--RENAME COLUMN - rename a column in an existing table
--Need :
--Old column name
--New column name
--ALTER TABLE table_name
--RENAME COLUMN column_name TO new_name;
ALTER TABLE job_applied
    RENAME COLUMN contact TO contact_name;
--ALTER COLUMN 
--Notes
--ALTER COLUMN - used to modify the properties of an existing column in a table
--*Change Data Type: modify the column´s data type, subject to compatibility between the old and new types.
--ALTER TABLE table_name
--ALTER COLUMN column_name TYPE new_data-type;
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;
--Limitationes: Certain data types can´t be changed
--*set/change dafault value: Assign a default value to the column, which will be used fow new rows if no value is specified.
--ALTER TABLE table_name
--ALTER COLUMN column_name SET_DEFAULT default_value;
--*Drop Dafault Value: Remove the default value from the column if one exits
--ALTER TABLE table_name
--ALTER COLUMN column_name DROP DEFAULT;
--DROP COLUMN
--Notes
--DROP COLUMN - delete a column
--ALTER TABLE table_name
--DROP COLUMN column_name;
ALTER TABLE job_applied DROP COLUMN contact_name;
SELECT *
FROM job_applied