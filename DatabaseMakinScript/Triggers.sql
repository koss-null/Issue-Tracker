USE IssueTrackingSystem;
GO

--DROP TRIGGER ClearIssuesAfterUserDeath;
--DROP TRIGGER ClearIssuesAfterIssueDeath;
--DROP TRIGGER Useless;
--DROP TRIGGER UslessInstead;
--GO

CREATE TRIGGER ClearIssuesAfterUserDeath
ON Employee
INSTEAD OF DELETE
AS BEGIN
DELETE FROM Issue 
   WHERE Issue.AdminID IN (SELECT ID FROM deleted)
DELETE FROM Employee
	WHERE Employee.ID IN (SELECT ID FROM deleted)
END
GO

CREATE TRIGGER ClearIssuesAfterIssueDeath
ON Issue
INSTEAD OF DELETE
AS BEGIN
DELETE FROM Issue
   WHERE Issue.ID IN (SELECT ChildID FROM IssueRelationMap
					  WHERE ParentID IN (SELECT ID FROM deleted))
DELETE FROM Issue
	WHERE Issue.ID IN (SELECT ID FROM deleted)
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
AFTER DELETE
AS BEGIN
	 SELECT newid(), [View], Comment, MakeIssue
       FROM inserted
END
GO
