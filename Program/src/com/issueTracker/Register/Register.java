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
    public static void Registration() throws java.lang.ClassNotFoundException, java.sql.SQLException {
        Scanner in = new Scanner(System.in);

        String name = "", login = "", pass = "", about = "";

        //driver register
        Class.forName(Config.DriverName);

        boolean success = true;
        do {
            if(!success) { System.out.println("Please try again"); success = true; };

            System.out.println("Choose Name");
            name = in.nextLine();

            System.out.println("Choose Login");
            login = in.nextLine();
            if(!tryLogin(login)) {
                success = false;
                System.out.println("This login is already used, or invalid symbols are detected");
            }

            if(success) {
                System.out.println("Choose Pass");
                pass = in.nextLine();
                if(!tryPass(pass)) {
                    success = false;
                    System.out.println("In password invalid symbols are detected");
                }
            }

            if(success) {
                System.out.println("Type some info about you (\\q when you over)");
                String s = "";
                while(!(s.equals("\\q"))) {
                    s = in.nextLine();
                    if(!(s.equals("\\q"))) about += s + "\n";
                }
            }
        } while(!success);

        addToDB(name, login, pass, about);
        System.out.println("You have been successfully registered");
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
        Querier.MakeQuery(pstmt);
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
