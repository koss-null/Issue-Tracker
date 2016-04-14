package com.issueTracker.Logger;

/**
 * Created by Reddy on 14.04.2016.
 */

import com.issueTracker.Config.*;
import com.issueTracker.Hasher.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login {
    public static boolean CheckPass(String login, String pass) throws java.lang.ClassNotFoundException, java.sql.SQLException {
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
                if (rs.getString(1) == Coder.GetMD5Hash(pass)) {
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
