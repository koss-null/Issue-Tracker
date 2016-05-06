package com.issueTracker.DBConnector;

import com.issueTracker.Config.Config;

import java.sql.*;

/**
 * Created by Reddy on 24.04.2016.
 */
public class DBConnector {
    private static boolean Connected = false;
    private static Connection con = null;

    public static Connection GetConnection() throws java.lang.ClassNotFoundException, java.sql.SQLException {
        if(Connected) {
            return con;
        }

        //driver register
        Class.forName(Config.DriverName);

        //getting connection
        con = DriverManager.getConnection(Config.connectionUrl);

        Connected = true;
        return con;
    }

    public static void CloseConnection(PreparedStatement pstmt) throws java.sql.SQLException {
        if(!Connected) return;
        pstmt.close();
        con.close();
        Connected = false;
    }

    public static void CloseConnection() throws java.sql.SQLException {
        if(!Connected) return;
        con.close();
        Connected = false;
    }
}
