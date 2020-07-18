CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `email id` INT NOT NULL,
  `display name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `user name` VARCHAR(45) NOT NULL,
  `Uid` INT(20) NOT NULL,
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `display_name_UNIQUE` (`display name`),
  UNIQUE KEY `email_id_UNIQUE` (`email_id`)

);

CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `DepartmentID` INT(20) NOT NULL,
  `DepartmentName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DepartmentID`)
  );
  
  CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `StudentID` INT NOT NULL,
  `departmentID` int(20) NOT NULL,
   PRIMARY KEY (`StudentID`),
   FOREIGN KEY (`StudentID`) REFERENCES `mydb`.`User` (`Uid`),
   FOREIGN KEY (`DepartmentID`) REFERENCES `mydb`.`DEPARTMENT` (`DepartmentID`));
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `ProfessorID` VARCHAR(45) NOT NULL,
  `DepartmentID`VARCHAR(45) NOT NULL,
   PRIMARY KEY (`ProfessorID`),
   FOREIGN KEY (`ProfessorID`) REFERENCES `mydb`.`User` (`Uid`),
   CONSTRAINT  FOREIGN KEY (`DepartmentID`) REFERENCES `mydb`.`Department` (`DepartmentID`));
   
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `StaffID` INT(45) NOT NULL,
  `departmenttable_id` INT(45) NOT NULL,
   FOREIGN KEY (`StaffID`) REFERENCES `mydb`.`User` (`Uid`),
   FOREIGN KEY (`departmenttable_id`) REFERENCES `mydb`.`Department` (`DepartmentID`));

   
   CREATE TABLE IF NOT EXISTS `mydb`.`belongs_to` (
  `studenttable_id` VARCHAR(45) NOT NULL,
  `departmenttable_id`VARCHAR(45) NOT NULL,
   PRIMARY KEY (`studenttable_id`,`departmenttable_id`),
   FOREIGN KEY (`studenttable_id`) REFERENCES `mydb`.`Student` (`StudentID`),
   FOREIGN KEY (`departmenttable_id`) REFERENCES `mydb`.`Department` (`DepartmentID`));
   
   
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Programs` (
  `ProgramID` INT(45) NOT NULL,
  `departmenttable_id`INT(45) NOT NULL,
  `ProgramName` VARCHAR(45) NOT NULL,
   PRIMARY KEY(`ProgramID`),
	FOREIGN KEY (`departmenttable_id`) REFERENCES `mydb`.`Department` (`DepartmentID`)
);
   
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Exam` (
  `ExamID` INT(45) NOT NULL,
  `CourseID` INT(45) NOT NULL,
   PRIMARY KEY(`ExamID`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`Course` (`CourseID`)
   );
   
CREATE TABLE IF NOT EXISTS `mydb`.`Problems` (
  `ProblemID` INT(45) NOT NULL,
  `ProblemData` INT(45),
   PRIMARY KEY(`ProblemID`),
   FOREIGN KEY (`ExamID`) REFERENCES `mydb`.`Exam` (`ExamID`)
   );
   
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Course` (
  `CourseID` INT(45) NOT NULL,
  `CourseName` VARCHAR(45) NOT NULL,
  `dept_id` INT(45) NOT NULL,
   PRIMARY KEY(`CourseID`),
   FOREIGN KEY (`dept_id`) REFERENCES `mydb`.`Professor` (`DepartmentID`)
   
   );
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Instructor` (
  `InstructorID` INT(45) NOT NULL,
   PRIMARY KEY (`InstructorID`),
   FOREIGN KEY (`InstructorID`) REFERENCES `mydb`.`Professor` (`ProfessorID`));
   
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Teaches` (
  `InstructorID` INT(45) NOT NULL,
  `CourseID` INT(45) NOT NULL,
   PRIMARY KEY (`InstructorID`, `CourseID`),
   FOREIGN KEY (`InstructorID`) REFERENCES `mydb`.`Professor` (`ProfessorID`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`Course` (`CourseID`)
 );
 
 CREATE TABLE IF NOT EXISTS `mydb`.`TeachingAssistant` (
  `TA_ID` INT(45) NOT NULL,
   PRIMARY KEY (`TA_ID`),
   FOREIGN KEY (`TA_ID`) REFERENCES `mydb`.`Student` (`StudentID`));
   
   CREATE TABLE IF NOT EXISTS `mydb`.`Assists` (
  `TA_ID` INT(45) NOT NULL,
  `CourseID` INT(45) NOT NULL,
   PRIMARY KEY (`TA_ID`, `CourseID`),
   FOREIGN KEY (`TA_ID`) REFERENCES `mydb`.`TeachingAssistant` (`TA_ID`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`Course` (`CourseID`)
 );
 
   CREATE TABLE IF NOT EXISTS `mydb`.`Prerquisite` (
  `PA_ID` INT(45) NOT NULL,
  `CourseID` INT(45) NOT NULL,
   PRIMARY KEY (`PA_ID`, `CourseID`),
   FOREIGN KEY (`PA_ID`) REFERENCES `mydb`.`Course` (`CourseID`)
 );

CREATE TABLE IF NOT EXISTS `mydb`.`Feedback` (
  `TA_ID` INT(45) NOT NULL,
  `InstructorID` INT(45) NOT NULL,
  `StudentID` INT(45) NOT NULL,
  `InstructorFeedback` VARCHAR(145),
  `TAFeedback` VARCHAR(145),
   PRIMARY KEY (`TA_ID`, `CourseID`),
   FOREIGN KEY (`TA_ID`) REFERENCES `mydb`.`TeachingAssistant` (`TA_ID`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`Course` (`CourseID`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`Enroll_in` (`StudentID`)
 );
 
 CREATE TABLE IF NOT EXISTS `mydb`.`SemesterInformation` (
  `TA_ID` INT(45) NOT NULL,
  `Season` VARCHAR(25) NOT NULL,
  `Offeredbydept` VARCHAR(45) NOT NULL,
  `year` INT(5) NOT NULL,
  `Enrollmentmax` INT(3),
  `Instructor` VARCHAR(45),
  `CourseID` INT(45),
   PRIMARY KEY (`CourseID`, `year`,`Season`,`Instructor`),
   FOREIGN KEY (`TA_ID`) REFERENCES `mydb`.`TeachingAssistant` (`TA_ID`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`Course` (`CourseID`),
   FOREIGN KEY (`Offeredbydept`) REFERENCES `mydb`.`Course` (`dept_id`),
   FOREIGN KEY (`Instructor`) REFERENCES `mydb`.`Instructor` (`InstructorID`)

 );

   CREATE TABLE IF NOT EXISTS `mydb`.`Register` (
  `Season` VARCHAR(25) NOT NULL,
  `Offeredbydept` VARCHAR(45) NOT NULL,
  `year` INT(5) NOT NULL,
  `Instructor` VARCHAR(45),
  `StudentID` VARCHAR(45),
  `CourseID` INT(45),
   PRIMARY KEY (`CourseID`, `year`,`Season`,`Instructor`,`StudentID`),
   FOREIGN KEY (`Season`) REFERENCES `mydb`.`SemesterInformation` (`Season`),
   FOREIGN KEY (`Offeredbydept`) REFERENCES `mydb`.`SemesterInformation` (`Offeredbydept`),
   FOREIGN KEY (`StudentID`) REFERENCES `mydb`.`Student` (`StudentID`),
   FOREIGN KEY (`Instructor`) REFERENCES `mydb`.`SemesterInformation` (`Instructor`),
   FOREIGN KEY (`year`) REFERENCES `mydb`.`SemesterInformation` (`year`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`SemesterInformation` (`CourseID`));
   
    CREATE TABLE IF NOT EXISTS `mydb`.`enroll_in` (
	`StudentID` VARCHAR(45) NOT NULL,
    `Coursegrade` VARCHAR(5) NOT NULL,
    `Season` VARCHAR(25) NOT NULL,
   `Offeredbydept` VARCHAR(45) NOT NULL,
   `year` INT(5) NOT NULL,
   `Instructor` VARCHAR(45),
   `StudentID` VARCHAR(45),
    `CourseID` INT(45),
   FOREIGN KEY (`StudentID`) REFERENCES `mydb`.`Student` (`StudentID`),
   PRIMARY KEY (`CourseID`, `year`,`Season`,`Instructor`,`StudentID`),
   FOREIGN KEY (`Season`) REFERENCES `mydb`.`will` (`Season`),
   FOREIGN KEY (`Offeredbydept`) REFERENCES `mydb`.`will` (`Offeredbydept`),
   FOREIGN KEY (`Instructor`) REFERENCES `mydb`.`will` (`Instructor`),
   FOREIGN KEY (`year`) REFERENCES `mydb`.`will` (`year`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`will` (`CourseID`)
   );
  


   
   


CREATE TABLE IF NOT EXISTS `mydb`.`will` (
  `Season` VARCHAR(25) NOT NULL,
  `Offeredbydept` VARCHAR(45) NOT NULL,
  `year` INT(5) NOT NULL,
  `Instructor` VARCHAR(45),
  `StudentID` VARCHAR(45),
  `CourseID` INT(45),
   PRIMARY KEY (`CourseID`, `year`,`Season`,`Instructor`,`StudentID`),
   FOREIGN KEY (`Season`) REFERENCES `mydb`.`Register` (`Season`),
   FOREIGN KEY (`Offeredbydept`) REFERENCES `mydb`.`Register` (`Offeredbydept`),
   FOREIGN KEY (`Instructor`) REFERENCES `mydb`.`Register` (`Instructor`),
   FOREIGN KEY (`year`) REFERENCES `mydb`.`Register` (`year`),
   FOREIGN KEY (`CourseID`) REFERENCES `mydb`.`Register` (`CourseID`)
   );
   
  
  CREATE TABLE IF NOT EXISTS `mydb`.`can` (
  `ExamID` INT(25) NOT NULL,
  `StudentID` VARCHAR(45),
  `scores` INT(45),
  `Examlettergrade` VARCHAR(4),
   PRIMARY KEY (`StudentID`, `ExamID`),
   FOREIGN KEY (`StudentID`) REFERENCES `mydb`.`enroll_in` (`StudentID`),
   FOREIGN KEY (`ExamID`) REFERENCES `mydb`.`Exam` (`ExamID`)
   );
 
   
   

   
   
   
   
  
  
  

   
   
   
   
   
   
   
   
   
   
