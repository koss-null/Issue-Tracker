USE IssueTrackingSystem;
GO

CREATE TRIGGER ClearIssuesAfterUserDeath
ON Employee
AFTER DELETE
AS BEGIN
DELETE FROM Issue 
   WHERE Issue.AdminID IN (SELECT ID FROM deleted)
END
GO

CREATE TRIGGER ClearIssuesAfterIssueDeath
ON Issue
AFTER DELETE
AS BEGIN
DELETE FROM Issue
   WHERE Issue.ID IN (SELECT ChildID FROM IssueRelationMap
					  WHERE ParentID IN (SELECT ID FROM deleted))
END
GO

CREATE TRIGGER Useless
ON [Login]
AFTER DELETE, UPDATE
AS BEGIN
	PRINT 'Oops... Something certenly went wrong! OR you just deleted someone'
END
GO

CREATE TRIGGER UslessInstead
ON AccessLevel
INSTEAD OF INSERT
AS BEGIN
	INSERT INTO AccessLevel
	 SELECT newid(), [View], Comment, MakeIssue
       FROM inserted
END
GO
