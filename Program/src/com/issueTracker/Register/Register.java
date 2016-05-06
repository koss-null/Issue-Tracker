package com.issueTracker.Register;

import com.issueTracker.Config.Config;
import com.issueTracker.DBConnector.DBConnector;
import com.issueTracker.DBQuerier.Querier;
import com.issueTracker.Hasher.Coder;

import java.sql.*;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Reddy on 17.04.2016.
 */
public class Register {
    public static void Registration(String name, String login, String pass, String about) throws java.lang.ClassNotFoundException, java.sql.SQLException {
        boolean success = true;

        if(!tryLogin(login)) {
            success = false;
        }

        if(success) {
            if(!tryPass(pass)) {
                success = false;
            }
        }

        if(success) addToDB(name, login, pass, about);
    }

    private static void addToDB(String name, String login, String pass, String about) throws java.sql.SQLException {
        pass = Coder.GetMD5Hash(pass);

        String query = "EXEC AddUser @Name = ?, @About = ?, @Login = ?, @Pass = ?";

        PreparedStatement pstmt = null;
        try {
            pstmt = DBConnector.GetConnection().prepareStatement(query); // create a statement
        } catch(Exception e) {
            e.printStackTrace();
        }

        pstmt.setString(1, name); // set input parameter
        pstmt.setString(2, about); // set input parameter
        pstmt.setString(3, login); // set input parameter
        pstmt.setString(4, pass); // set input parameter
        Querier.MakeUpdateQuery(pstmt);
    }

    private static boolean tryLogin(String login) throws java.sql.SQLException {
        String query = "SELECT LoginName FROM Login WHERE LoginName = N'"+ login + "'";

        ResultSet rs = Querier.MakeQuery(query);

        // extract data from the ResultSet
        if (rs.next()) {
            return false;
        }

        Pattern p = Pattern.compile("^[a-zA-Z0-9-_]{3,60}$");
        Matcher m = p.matcher(login);
        return m.matches();
    }

    private static boolean tryPass(String pass) {
        Pattern p = Pattern.compile("^[a-zA-Z0-9-_]{6,60}$");
        Matcher m = p.matcher(pass);
        return m.matches();
    }
}
