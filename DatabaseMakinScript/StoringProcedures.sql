USE IssueTrackingSystem;
GO

--without any parameters

IF OBJECT_ID ( 'GetSelfImplementingProjects', 'P' ) IS NOT NULL		--MyProjects
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

IF OBJECT_ID ( 'GetEmployeeProjects', 'P' ) IS NOT NULL		--UserProjects
    DROP PROCEDURE GetEmployeeProjects;
GO
CREATE PROCEDURE GetEmployeeProjects
	@EmployeeID uniqueidentifier
AS
BEGIN
	SELECT Project.ID as 'ProjectID', Project.Name as 'ProjectName' FROM Project
		INNER JOIN ProjectIssueMap ON ProjectIssueMap.ProjectID = Project.ID
			INNER JOIN Issue ON ProjectIssueMap.IssueID = Issue.ID
				INNER JOIN Employee ON Issue.EmployeeID = Employee.ID AND Employee.ID = @EmployeeID
END

GO

IF OBJECT_ID ( 'GetEmployeeIssuesByProject', 'P' ) IS NOT NULL		--watch project issues (by employee)
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
	WHERE @ProjectID = Project.ID
END

GO

IF OBJECT_ID ( 'GetEmployeeIssues', 'P' ) IS NOT NULL		--watch all employee's issues
    DROP PROCEDURE GetEmployeeIssues;
GO
CREATE PROCEDURE GetEmployeeIssues
	@EmployeeID uniqueidentifier
AS
BEGIN
	SELECT Issue.ID, Issue.Name as 'IssueName' FROM Issue
	WHERE Issue.EmployeeID IN 
		(SELECT Employee.ID FROM Employee
		 WHERE Employee.ID = @EmployeeID
		)
END

GO

--Getting and returning parameters

IF OBJECT_ID ( 'GetGroopAccessView', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetGroopAccessView;
GO
CREATE PROCEDURE GetGroopAccessView
	@GroopID uniqueidentifier
AS
BEGIN
	RETURN (SELECT AccessLevel.[View] FROM AccessLevel
			WHERE AccessLevel.ID IN (SELECT Groop.ID FROM Groop) )
END

GO

IF OBJECT_ID ( 'GetGroopAccessComment', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetGroopAccessComment;
GO
CREATE PROCEDURE GetGroopAccessComment
	@GroopID uniqueidentifier
AS
BEGIN
	RETURN (SELECT AccessLevel.Comment FROM AccessLevel
			WHERE AccessLevel.ID IN (SELECT Groop.ID FROM Groop) )
END

GO

IF OBJECT_ID ( 'GetGroopAccessMakeIssue', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetGroopAccessMakeIssue;
GO
CREATE PROCEDURE GetGroopAccessMakeIssue
	@GroopID uniqueidentifier
AS
BEGIN
	RETURN (SELECT AccessLevel.MakeIssue FROM AccessLevel
			WHERE AccessLevel.ID IN (SELECT Groop.ID FROM Groop) )
END

GO

IF OBJECT_ID ( 'GetProjectEmployeeAccessView', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetProjectEmployeeAccessView;
GO
CREATE PROCEDURE GetProjectEmployeeAccessView
	@EmployeeID uniqueidentifier,
	@ProjectID uniqueidentifier
AS
BEGIN
	RETURN (SELECT AccessLevel.[View] FROM AccessLevel
		INNER JOIN ProjectGroopMap ON ProjectGroopMap.AccessID = AccessLevel.ID
			INNER JOIN Groop ON ProjectGroopMap.ProjectID = @ProjectID AND Groop.ID = ProjectGroopMap.GroopID
				INNER JOIN GroopEmployeeMap ON Groop.ID = GroopEmployeeMap.GroopID AND GroopEmployeeMap.EmployeeID = @EmployeeID )
END

GO

IF OBJECT_ID ( 'GetProjectEmployeeAccessComment', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetProjectEmployeeAccessComment;
GO
CREATE PROCEDURE GetProjectEmployeeAccessComment
	@EmployeeID uniqueidentifier,
	@ProjectID uniqueidentifier 
AS
BEGIN
	RETURN (SELECT AccessLevel.Comment FROM AccessLevel
		INNER JOIN ProjectGroopMap ON ProjectGroopMap.AccessID = AccessLevel.ID
			INNER JOIN Groop ON ProjectGroopMap.ProjectID = @ProjectID AND Groop.ID = ProjectGroopMap.GroopID
				INNER JOIN GroopEmployeeMap ON Groop.ID = GroopEmployeeMap.GroopID AND GroopEmployeeMap.EmployeeID = @EmployeeID )
END

GO

IF OBJECT_ID ( 'GetProjectEmployeeAccessMakeIssue', 'P' ) IS NOT NULL 
    DROP PROCEDURE GetProjectEmployeeAccessMakeIssue;
GO
CREATE PROCEDURE GetProjectEmployeeAccessMakeIssue
	@EmployeeID uniqueidentifier,
	@ProjectID uniqueidentifier 
AS
BEGIN
	RETURN (SELECT AccessLevel.MakeIssue FROM AccessLevel
		INNER JOIN ProjectGroopMap ON ProjectGroopMap.AccessID = AccessLevel.ID
			INNER JOIN Groop ON ProjectGroopMap.ProjectID = @ProjectID AND Groop.ID = ProjectGroopMap.GroopID
				INNER JOIN GroopEmployeeMap ON Groop.ID = GroopEmployeeMap.GroopID AND GroopEmployeeMap.EmployeeID = @EmployeeID )
END

GO

--IF OBJECT_ID ( 'GetIDbyLogin', 'P') IS NOT NULL
--	DROP PROCEDURE GetIDbyLogin;
--GO

IF OBJECT_ID ( 'CountUsers', 'P') IS NOT NULL
	DROP PROCEDURE CountUsers;
GO
CREATE PROCEDURE CountUsers
	@Cnt INT OUTPUT
AS
BEGIN
	SET @Cnt = (SELECT COUNT(ID) FROM [Login]);
END

GO

IF OBJECT_ID ( 'AddUser', 'P') IS NOT NULL
	DROP PROCEDURE AddUser;
GO
CREATE PROCEDURE AddUser
	@Name VARCHAR(100),
	@About VARCHAR(1000),
	@Login VARCHAR(100),
	@Pass VARCHAR(256)
AS
BEGIN
	INSERT INTO Employee (Name, Info)
	VALUES (@Name, @About);
	
	INSERT INTO [Login] (LoginName, PassHash)
	VALUES (@Login, @Pass);

	INSERT INTO LoginEmployeeMap (LoginID, EmployeeID)
	VALUES ((SELECT ID FROM [Login] WHERE LoginName = @Login), (SELECT ID FROM Employee WHERE ID NOT IN (SELECT EmployeeID FROM LoginEmployeeMap) ));
END

GO