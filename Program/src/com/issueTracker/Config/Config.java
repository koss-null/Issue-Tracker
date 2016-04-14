package com.issueTracker.Config;

/**
 * Created by Reddy on 14.04.2016.
 */
public class Config {
    public static String Encoding = "UTF-8";
    public static String HashType = "MD5";
    public static String DriverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static  String connectionUrl =   "jdbc:sqlserver://127.0.0.1:11844;" +
                                            "databaseName=IssueTrackingSystem;" +
                                            "integratedSecurity=true;";    //it needs sqljdbc_auth.dll in System32
}
