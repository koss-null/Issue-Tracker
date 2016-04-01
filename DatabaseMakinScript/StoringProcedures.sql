USE IssueTrackingSystem;
GO

--without any parameters

IF OBJECT_ID ( 'GetSelfImplementingProjects', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetSelfImplementingProjects;
GO
CREATE PROCEDURE GetSelfImplementingProjects	--projects sorted by AdminID and having Admin as an Employee
AS
BEGIN
	SELECT Project.ID, Project.Name, Employee.ID as 'AdminID' FROM Project
		INNER JOIN Employee ON Project.AdminID = Employee.ID
	ORDER BY Employee.ID
END

GO

--getting parameters

IF OBJECT_ID ( 'GetEmployeeProjects', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetEmployeeProjects;
GO
CREATE PROCEDURE GetEmployeeProjects
	@EmployeeID uniqueidentifier
AS
BEGIN
	SELECT Project.ID as 'ProjectID', Project.Name as 'ProjectName' FROM Project
		INNER JOIN ProjectIssueMap ON ProjectIssueMap.ProjectID = Project.ID
			INNER JOIN Issue ON ProjectIssueMap.IssueID = Issue.ID
				INNER JOIN Employee ON Issue.EmployeeID = Employee.ID AND Employee.ID = EmployeeID
END

GO

IF OBJECT_ID ( 'GetEmployeeIssuesByProject', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetEmployeeIssuesByProject;
GO
CREATE PROCEDURE GetEmployeeIssuesByProject				--only Issues, connected with project
	@EmployeeID uniqueidentifier,
	@ProjectID uniqueidentifier
AS
BEGIN
	SELECT Employee.ID, Employee.Name as 'EmployeeName', Issue.Name as 'IssueName' FROM Project
		INNER JOIN ProjectIssueMap ON ProjectIssueMap.ProjectID = Project.ID
			INNER JOIN Issue ON ProjectIssueMap.IssueID = Issue.ID
				INNER JOIN Employee ON Issue.EmployeeID = Employee.ID AND Employee.ID = @EmployeeID
	WHERE ProjectID = Project.ID
END

GO

IF OBJECT_ID ( 'GetEmployeeIssues', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetEmployeeIssues;
GO
CREATE PROCEDURE GetEmployeeIssues
	@EmployeeID uniqueidentifier
AS
BEGIN
	SELECT Employee.ID, Employee.Name, Issue.Name as 'IssueName' FROM Issue
		INNER JOIN Employee ON Issue.EmployeeID = Employee.ID AND Employee.ID = EmployeeID
END

GO

--Getting and returning parameters



