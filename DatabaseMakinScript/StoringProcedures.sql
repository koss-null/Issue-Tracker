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

IF OBJECT_ID ( 'AddIssue', 'P') IS NOT NULL
	DROP PROCEDURE AddIssue;
GO
CREATE PROCEDURE AddIssue 
						   @Name  VARCHAR(60), @Discr VARCHAR(5000), @DeadlineDate date, 
						   @AdminID UNIQUEIDENTIFIER, @ClassID UNIQUEIDENTIFIER,
						   @EmployeeID UNIQUEIDENTIFIER, @PriorID UNIQUEIDENTIFIER,
						   @ProjectID UNIQUEIDENTIFIER, @ParentIssueID UNIQUEIDENTIFIER
AS
BEGIN
    INSERT INTO Issue (Name, [Description], DeadlineDate, AdminID, ClassID, EmployeeID, PriorID)
	VALUES (@Name, @Discr, @DeadlineDate, @AdminID, @ClassID, @EmployeeID, @PriorID);

	IF (@ParentIssueID IS not NULL) 
         INSERT INTO IssueRelationMap (ParentID, ChildID)
		 VALUES (@ParentIssueID, (SELECT ID FROM Issue WHERE Issue.Name = @Name))

	INSERT INTO ProjectIssueMap (ProjectID, IssueID)
		 VALUES (@ProjectID, (SELECT ID FROM Issue WHERE Issue.Name = @Name))
END

GO

--Getting and returning parameters
IF OBJECT_ID ( 'AddProject', 'P') IS NOT NULL
	DROP PROCEDURE AddProject;
GO
CREATE PROCEDURE AddProject 
	@Name  VARCHAR(100), @Discr VARCHAR(5000), @Admin UNIQUEIDENTIFIER
--RETURNS int	-- 1-OK, 0-Error
AS
BEGIN
	DECLARE @PrjCnt int;
	SELECT @PrjCnt = COUNT(Project.Name)
	FROM Project WHERE @Name = Project.Name;
	IF (@PrjCnt IS NULL) 
        RETURN 0;

    INSERT INTO Project (Name, Description, AdminID)
	VALUES (@Name, @Discr, @Admin);

	RETURN 1;
END

GO



