USE IssueTrackingSystem;
GO

--clustered

--a lot of clustered INDEXES are amde using CONSTRAINT
--FOREIGN KEY and PRIMARY KEY TYPES OF INDEXES

--non clastered

CREATE UNIQUE NONCLUSTERED INDEX Issue_Name ON Issue(Name);
CREATE UNIQUE NONCLUSTERED INDEX Project_NotSameNames ON Project(Name, AdminID);