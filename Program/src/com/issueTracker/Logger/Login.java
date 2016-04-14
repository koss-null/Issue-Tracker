package com.issueTracker.Logger;

/**
 * Created by Reddy on 14.04.2016.
 */

import com.issueTracker.Config.*;
import com.issueTracker.Hasher.*;
import com.sun.org.apache.bcel.internal.classfile.Code;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login {
    public static boolean CheckPass(String login, String pass) throws java.lang.ClassNotFoundException, java.sql.SQLException {
        System.out.println("Trying to login " + login + " " + pass + " " + Coder.GetMD5Hash(pass));

        //driver register
        Class.forName(Config.DriverName);

        //getting connection
        Connection conn = DriverManager.getConnection(Config.connectionUrl);

        //making a query
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        boolean verified = false;
        try {
            String query = "select PassHash from Login where Login = ?";

            pstmt = conn.prepareStatement(query); // create a statement
            pstmt.setString(1, login); // set input parameter
            rs = pstmt.executeQuery();
            // extract data from the ResultSet

            while (rs.next()) {
                if (rs.getString(1).equals(Coder.GetMD5Hash(pass))) {
                    verified = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return verified;
    }
}
