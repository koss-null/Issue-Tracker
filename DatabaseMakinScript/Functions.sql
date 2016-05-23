USE IssueTrackingSystem;
GO

--Returning Table
IF OBJECT_ID ( N'GetGroopAccessView', N'IF' ) IS NOT NULL 
    DROP FUNCTION GetGroopAccessView;
GO
CREATE FUNCTION GetGroopAccessView (@GroopID uniqueidentifier)
RETURNS TABLE
AS
	RETURN (SELECT AccessLevel.[View] FROM AccessLevel
			WHERE AccessLevel.ID IN (SELECT Groop.ID FROM Groop) )
GO

IF OBJECT_ID ( N'GetGroopAccessComment', N'IF' ) IS NOT NULL 
    DROP FUNCTION GetGroopAccessComment;
GO
CREATE FUNCTION GetGroopAccessComment (@GroopID uniqueidentifier)
RETURNS TABLE
AS
	RETURN (SELECT AccessLevel.Comment FROM AccessLevel
			WHERE AccessLevel.ID IN (SELECT Groop.ID FROM Groop) )
GO

IF OBJECT_ID ( N'GetGroopAccessMakeIssue', N'IF' ) IS NOT NULL 
    DROP FUNCTION GetGroopAccessMakeIssue;
GO
CREATE FUNCTION GetGroopAccessMakeIssue (@GroopID uniqueidentifier)
RETURNS TABLE
AS
	RETURN (SELECT AccessLevel.MakeIssue FROM AccessLevel
			WHERE AccessLevel.ID IN (SELECT Groop.ID FROM Groop) )
GO

--With parameters

IF OBJECT_ID ( 'GetProjectEmployeeAccessView', 'FN' ) IS NOT NULL 
    DROP FUNCTION GetProjectEmployeeAccessView;
GO
CREATE FUNCTION GetProjectEmployeeAccessView (@EmployeeID uniqueidentifier, @ProjectID uniqueidentifier)
RETURNS BIT
AS
BEGIN
	DECLARE @ret BIT;
	SELECT @ret = AccessLevel.[View] FROM AccessLevel
		INNER JOIN ProjectGroopMap ON ProjectGroopMap.AccessID = AccessLevel.ID
			INNER JOIN Groop ON ProjectGroopMap.ProjectID = @ProjectID AND Groop.ID = ProjectGroopMap.GroopID
				INNER JOIN GroopEmployeeMap ON Groop.ID = GroopEmployeeMap.GroopID AND GroopEmployeeMap.EmployeeID = @EmployeeID;
	RETURN @ret;
END
GO

IF OBJECT_ID ( 'GetProjectEmployeeAccessComment', 'FN' ) IS NOT NULL 
    DROP FUNCTION GetProjectEmployeeAccessComment;
GO
CREATE FUNCTION GetProjectEmployeeAccessComment (@EmployeeID uniqueidentifier, @ProjectID uniqueidentifier)
RETURNS BIT
AS
BEGIN
	DECLARE @ret BIT;
	SELECT @ret = AccessLevel.Comment FROM AccessLevel
		INNER JOIN ProjectGroopMap ON ProjectGroopMap.AccessID = AccessLevel.ID
			INNER JOIN Groop ON ProjectGroopMap.ProjectID = @ProjectID AND Groop.ID = ProjectGroopMap.GroopID
				INNER JOIN GroopEmployeeMap ON Groop.ID = GroopEmployeeMap.GroopID AND GroopEmployeeMap.EmployeeID = @EmployeeID;
	RETURN @ret;
END
GO

IF OBJECT_ID ( 'GetProjectEmployeeAccessMakeIssue', 'FN' ) IS NOT NULL 
    DROP FUNCTION GetProjectEmployeeAccessMakeIssue;
GO
CREATE FUNCTION GetProjectEmployeeAccessMakeIssue (@EmployeeID uniqueidentifier, @ProjectID uniqueidentifier)
RETURNS BIT
AS
BEGIN
	DECLARE @ret BIT;
	SELECT @ret = AccessLevel.MakeIssue FROM AccessLevel
		INNER JOIN ProjectGroopMap ON ProjectGroopMap.AccessID = AccessLevel.ID
			INNER JOIN Groop ON ProjectGroopMap.ProjectID = @ProjectID AND Groop.ID = ProjectGroopMap.GroopID
				INNER JOIN GroopEmployeeMap ON Groop.ID = GroopEmployeeMap.GroopID AND GroopEmployeeMap.EmployeeID = @EmployeeID;
	RETURN @ret;
END
GO

--Without parameters

IF OBJECT_ID ( 'CountUsers', 'FN') IS NOT NULL
	DROP FUNCTION CountUsers;
GO
CREATE FUNCTION CountUsers()
RETURNS int
AS
BEGIN
	DECLARE @Cnt int;
	SELECT @Cnt=COUNT(ID) FROM [Login];
	RETURN @Cnt;
END

GO