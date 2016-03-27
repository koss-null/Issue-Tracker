USE master;
GO
CREATE DATABASE IssueTrackingSystem
ON
(	Name = IssueTracker_dat,
	FileName = 'd:\IssueTracker\DatabaseMakinScript\IssueTrackingSystem.mdf',
	Size = 10,
	FileGrowth = 50% )
LOG ON
(	Name = IssueTracker_log,
	FileName = 'd:\IssueTracker\DatabaseMakinScript\IssueTrackingLogs.ldf',
	Size = 25,
	FileGrowth = 25% )
GO
