package com.issueTracker.Logger;

/**
 * Created by Reddy on 14.04.2016.
 */

import com.issueTracker.Config.*;
import com.issueTracker.DBConnector.DBConnector;
import com.issueTracker.DBQuerier.Querier;
import com.issueTracker.Hasher.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Login {
    private String userID = null;

    public Login(String login, String pass) throws java.lang.ClassNotFoundException, java.sql.SQLException {
        if(CheckPass(login, pass)) {

            PreparedStatement pstmt = DBConnector.GetConnection().prepareStatement(Config.GetIDbyLoginQuery);
            pstmt.setString(1, login); // set input parameter

            ResultSet rs = Querier.MakeQuery(pstmt);

            if (rs.next()) {
                userID = rs.getString(1);
            }
        }
    }

    private static boolean CheckPass(String login, String pass) throws java.lang.ClassNotFoundException, java.sql.SQLException {
        String query = "select PassHash from [Login] where LoginName = N'" + login + "'";
        ResultSet rs = Querier.MakeQuery(query);

        // extract data from the ResultSet
         if(rs.next()) {
            if(rs.getString(1).equals(Coder.GetMD5Hash(pass))) {
                return true;
            }
        }

        return false;
    }

    public String getID() {
        return userID;
    }

}
