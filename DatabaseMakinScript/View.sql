USE IssueTrackingSystem;
GO

--single table

CREATE VIEW IssueDeadlineView
AS
SELECT ID, Name, Description, EmployeeID FROM Issue
WHERE DeadlineDate = getdate()
GO
--double table

CREATE VIEW PjANDIss
AS
SELECT ID, Name FROM Project
UNION ALL
SELECT ID, Name FROM Issue
GO

--aggregation

CREATE VIEW NextDeadlineIssues
AS
SELECT ID, Name, MIN(DeadlineDate) AS 'NextDL' FROM Issue WHERE DeadlineDate IN (SELECT MIN(DeadlineDate) FROM Issue) GROUP BY ID, Name
GO

--getting data from the View

--data modification in View