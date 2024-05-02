create database crimemanagement;
use crimemanagement;

-- create table crime

CREATE TABLE Crime ( 
    CrimeID INT PRIMARY KEY, 
    IncidentType VARCHAR(255), 
    IncidentDate DATE, 
    Location VARCHAR(255), 
    Description TEXT, 
    Status VARCHAR(20) 
); 
 
 -- create table victim
 
CREATE TABLE Victim ( 
    VictimID INT PRIMARY KEY, 
    CrimeID INT, 
    Name VARCHAR(255), 
    ContactInfo VARCHAR(255), 
    Injuries VARCHAR(255), 
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID) 
); 

-- create table suspect
 
CREATE TABLE Suspect ( 
    SuspectID INT PRIMARY KEY, 
    CrimeID INT, 
    Name VARCHAR(255), 
    Description TEXT, 
    CriminalHistory TEXT, 
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID) 
);

-- insert values crime

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES 
(1, 'Assault', '2023-04-15', 'Main Street', 'Physical altercation between two individuals.', 'Under Investigation'),
(2, 'Theft', '2023-03-20', 'Park Avenue', 'Stolen wallet from a parked car.', 'Closed'),
(3, 'Burglary', '2023-02-10', 'Oak Street', 'Break-in at a residential property.', 'Under Investigation'),
(4, 'Vandalism', '2023-09-01', 'Maple Avenue', 'Graffiti on public property.', 'Under Investigation'),
(5, 'Robbery', '2023-09-05', 'Elm Street', 'Armed robbery at a convenience store.', 'Closed'),
(6, 'Fraud', '2023-09-02', 'Cedar Street', 'Identity theft involving credit card fraud.', 'Under Investigation'),
(7, 'Kidnapping', '2023-03-18', 'Willow Avenue', 'Abduction of a minor.', 'Open'),
(8, 'Drug Possession', '2023-02-25', 'Pine Street', 'Possession of illegal substances.', 'Closed'),
(9, 'Homicide', '2023-09-30', 'Spruce Street', 'Murder case under investigation.', 'Open'),
(10, 'Cybercrime', '2023-04-20', 'Aspen Street', 'Hacking and data breach.', 'Closed');

-- insert into victim

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES 
(1, 1, 'John Doe', 'john.doe@example.com', 'Minor injuries'),
(2, 2, 'Jane Smith', 'jane.smith@example.com', 'None'),
(3, 3, 'Michael Johnson', 'michael.johnson@example.com', 'Deceased'),
(4, 4, 'Emily Brown', 'emily.brown@example.com', 'Deceased'),
(5, 5, 'Daniel Wilson', 'daniel.wilson@example.com', 'None'),
(6, 6, 'Olivia Davis', 'olivia.davis@example.com', 'Minor injuries'),
(7, 7, 'Sophia Martinez', 'sophia.martinez@example.com', 'None'),
(8, 8, 'William Anderson', 'william.anderson@example.com', 'Deceased'),
(9, 9, 'Emma Thomas', 'emma.thomas@example.com', 'Deceased'),
(10, 10, 'James White', 'james.white@example.com', 'None');

-- insert into suspect

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES 
(1, 1, 'Robber 1', 'Tall, dark hair, wearing a blue jacket.', 'Previous arrests for assault'),
(2, 3, 'Suspect 1', 'Blonde, medium build, seen near the crime scene.', 'No known criminal history'),
(3, 2, 'Robber 3', 'Medium height, tattoos on arms.', 'Convicted for theft in 2019'),
(4, 4, 'Unknown', 'Investigation ongoing', NULL),
(5, 5, 'Unknown', 'Investigation ongoing', NULL),
(6, 6, 'Suspect 2', 'Tech-savvy, involved in online scams.', 'No criminal record found'),
(7, 7, 'Robber 2', 'Known for involvement in illegal activities.', 'Multiple prior arrests'),
(8, 8, 'Suspect 3', 'Seen with illegal substances.', 'Drug-related offenses in the past'),
(9, 9, 'Unknown', 'Investigation ongoing', NULL),
(10, 10, 'Robber 4', 'Linked to hacking group.', 'Cybercrime activities documented');


-- Queries--

-- 1.Select all open incidents
SELECT * FROM Crime WHERE Status = 'Open';

-- 2.Find the total number of incidents:
SELECT COUNT(*) AS TotalIncidents FROM Crime;

-- 3.List all unique incident types:
SELECT DISTINCT IncidentType FROM Crime;

-- 4.Retrieve incidents that occurred between '2023-09-01' and '2023-09-10':
SELECT * FROM Crime WHERE IncidentDate BETWEEN '2023-09-01' AND '2023-09-10';

-- 5.List persons involved in incidents in descending order of age:
-- didn't have age field so we need to insert it --
-- Drop the existing Victim table--
DROP TABLE IF EXISTS Victim;

-- Recreate the Victim table with VictimID as an auto-increment primary key
CREATE TABLE Victim (
    VictimID INT AUTO_INCREMENT PRIMARY KEY,
    CrimeID INT,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255),
    Injuries VARCHAR(255),
    Age INT
);

-- Insert data into the Victim table, without specifying VictimID
INSERT INTO Victim (CrimeID, Name, ContactInfo, Injuries, Age)
VALUES 
(1, 'John Doe', 'john.doe@example.com', 'Minor injuries', 25),
(2, 'Jane Smith', 'jane.smith@example.com', 'None', 38),
(3, 'Michael Johnson', 'michael.johnson@example.com', 'Deceased', 45),
(4, 'Emily Brown', 'emily.brown@example.com', 'Deceased', 33),
(5, 'Daniel Wilson', 'daniel.wilson@example.com', 'None', 50),
(6, 'Olivia Davis', 'olivia.davis@example.com', 'Minor injuries', 35),
(7, 'Sophia Martinez', 'sophia.martinez@example.com', 'None', 28),
(8, 'William Anderson', 'william.anderson@example.com', 'Deceased', 41),
(9, 'Emma Thomas', 'emma.thomas@example.com', 'Deceased', 47),
(10, 'James White', 'james.white@example.com', 'None', 32);

-- 5.List persons involved in incidents in descending order of age:
SELECT Name FROM Victim ORDER BY Age DESC;

-- 6.Find the average age of persons involved in incidents:
SELECT AVG(Age) AS AverageAge FROM Victim;

-- 7.List incident types and their counts, only for open cases:
SELECT IncidentType, COUNT(*) AS OpenCaseCount FROM Crime WHERE Status = 'Open' GROUP BY IncidentType;

-- 8.Find persons with names containing 'Doe':
SELECT Name FROM Victim WHERE Name LIKE '%Doe%';

-- 9.Retrieve the names of persons involved in open cases and closed cases:
SELECT Name, CASE WHEN Status = 'Open' THEN 'Open Case' ELSE 'Closed Case' END AS CaseStatus FROM Victim 
JOIN Crime ON Victim.CrimeID = Crime.CrimeID;

-- 10.List incident types where there are persons aged 30 or 35 involved:
SELECT DISTINCT IncidentType FROM Crime JOIN Victim ON Crime.CrimeID = Victim.CrimeID WHERE Age IN (30, 35);

-- 11.Find persons involved in incidents of the same type as 'Robbery':
SELECT Name FROM Victim JOIN Crime ON Victim.CrimeID = Crime.CrimeID WHERE IncidentType = 'Robbery';

-- 12.List incident types with more than one open case:
SELECT IncidentType, COUNT(*) AS OpenCasesCount FROM Crime WHERE Status = 'Open' 
GROUP BY IncidentType HAVING COUNT(*) > 1;

-- 13.List all incidents with suspects whose names also appear as victims in other incidents:
SELECT * FROM Crime WHERE CrimeID IN (SELECT DISTINCT CrimeID FROM Suspect WHERE Name IN (SELECT Name 
FROM Victim));

-- 14.Retrieve all incidents along with victim and suspect details:
SELECT C.*, V.Name AS VictimName, S.Name AS SuspectName FROM Crime C 
LEFT JOIN Victim V ON C.CrimeID = V.CrimeID LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;

-- 15.Find incidents where the suspect is older than any victim:
-- age field is not there in suspects so we need to insert those
drop table if exists suspect;
CREATE TABLE Suspect ( 
    SuspectID INT PRIMARY KEY auto_increment, 
    CrimeID INT, 
    Name VARCHAR(255), 
    Description TEXT, 
    CriminalHistory TEXT, 
    age int,
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID) 
);
INSERT INTO Suspect (CrimeID, Name, Description, CriminalHistory,age)
VALUES 
(1, 'Robber 1', 'Tall, dark hair, wearing a blue jacket.', 'Previous arrests for assault',41),
(3, 'Suspect 1', 'Blonde, medium build, seen near the crime scene.', 'No known criminal history',34),
(2, 'Robber 3', 'Medium height, tattoos on arms.', 'Convicted for theft in 2019',35),
(4, 'Unknown', 'Investigation ongoing', NULL,NULL),
(5, 'Unknown', 'Investigation ongoing', NULL,NULL),
(6, 'Suspect 2', 'Tech-savvy, involved in online scams.', 'No criminal record found',47),
(7, 'Robber 2', 'Known for involvement in illegal activities.', 'Multiple prior arrests',17),
(8, 'Suspect 3', 'Seen with illegal substances.', 'Drug-related offenses in the past',18),
(9, 'Unknown', 'Investigation ongoing', NULL,NULL),
(10, 'Robber 4', 'Linked to hacking group.', 'Cybercrime activities documented',20);

SELECT C.* FROM Crime C JOIN Victim V ON C.CrimeID = V.CrimeID 
JOIN Suspect S ON C.CrimeID = S.CrimeID WHERE S.Age > ANY (SELECT Age FROM Victim);

-- 16.Find suspects involved in multiple incidents:
SELECT Name FROM Suspect GROUP BY Name HAVING COUNT(CrimeID) > 1;

-- 17.List incidents with no suspects involved:
SELECT C.CrimeID, C.IncidentType, C.IncidentDate, C.Location, S.Name AS SuspectName FROM Crime C
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID WHERE S.Name = 'Unknown';

-- 18.List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery':
SELECT * FROM Crime GROUP BY CrimeID HAVING CASE WHEN IncidentType = 'Homicide' THEN 1 ELSE 0 END >= 1 
or CASE WHEN IncidentType = 'Robbery' THEN 1 ELSE 0 END;

-- 19.Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 
-- 'No Suspect' if there are none:
SELECT C.CrimeID, C.IncidentType, C.IncidentDate, C.Location, CASE WHEN S.Name IS NULL THEN 'No Suspect' ELSE S.Name 
END AS SuspectName FROM Crime C LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;

-- 20.List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault':
SELECT DISTINCT S.Name FROM Suspect S JOIN Crime C ON S.CrimeID = C.CrimeID 
WHERE C.IncidentType IN ('Robbery', 'Assault');


























