USE IssueTrackingSystem;
GO

IF OBJECT_ID ( N'CountIssueChildren', N'FN' ) IS NOT NULL
    DROP FUNCTION CountIssueChildren;
GO
CREATE FUNCTION CountIssueChildren(@IssueId uniqueidentifier)
RETURNS int
AS
BEGIN
	DECLARE IssueCursor CURSOR FOR  --INSENSITIVE - static, SCROLL - dynamic
	SELECT ChildID
	FROM IssueRelationMap
	WHERE ParentID = @IssueId

	DECLARE @cnt int;
	SET @cnt = 0;

	OPEN IssueCursor

	DECLARE @ChildIssueID uniqueidentifier;
	
	FETCH NEXT FROM IssueCursor 
	INTO @ChildIssueID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @cnt = @cnt + 1;
		FETCH NEXT FROM IssueCursor 
		INTO @ChildIssueID
	END

	CLOSE IssueCursor

	RETURN @cnt;
END
GO


IF OBJECT_ID ( N'FastCountIssueChildren', N'FN' ) IS NOT NULL
    DROP FUNCTION FastCountIssueChildren;
GO
CREATE FUNCTION FastCountIssueChildren(@IssueId uniqueidentifier)
RETURNS int
AS
BEGIN
	DECLARE IssueCursor CURSOR FORWARD_ONLY READ_ONLY FOR  --changing
	SELECT ChildID
	FROM IssueRelationMap
	WHERE ParentID = @IssueId

	DECLARE @cnt int;
	SET @cnt = 0;

	OPEN IssueCursor

	DECLARE @ChildIssueID uniqueidentifier;
	
	FETCH NEXT FROM IssueCursor 
	INTO @ChildIssueID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @cnt = @cnt + 1;
		FETCH NEXT FROM IssueCursor 
		INTO @ChildIssueID
	END

	CLOSE IssueCursor

	RETURN @cnt;
END

GO