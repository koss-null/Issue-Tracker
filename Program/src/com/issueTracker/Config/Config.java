package com.issueTracker.Config;

/**
 * Created by Reddy on 14.04.2016.
 */
public class Config {
    public static String Encoding = "UTF-8";
    public static String HashType = "MD5";
    public static String DriverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String connectionUrl =   "jdbc:sqlserver://127.0.0.1:11844;" +
                                            "databaseName=IssueTrackingSystem;" +
                                            "integratedSecurity=true;";    //it needs sqljdbc_auth.dll in System32
    public static String GetIDbyLoginQuery = "SELECT CONVERT(NVARCHAR(36), Employee.ID) FROM Employee\n" +
            "\tWHERE  Employee.ID  IN \n" +
            "\t\t\t(SELECT EmployeeID FROM LoginEmployeeMap\n" +
            "\t\t\tWHERE LoginID IN \n" +
            "\t\t\t\t(SELECT [Login].ID FROM [Login]\n" +
            "\t\t\t\t WHERE ? = [Login].LoginName\n" +
            "\t\t\t\t) )";
    public static int MaxConnectionNumber = 32 * 1000;
}
