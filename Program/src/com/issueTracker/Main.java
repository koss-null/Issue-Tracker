package com.issueTracker;

import com.issueTracker.Logger.*;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws java.lang.ClassNotFoundException, java.sql.SQLException {
        Scanner in = new Scanner(System.in);

        String login, pass;
        System.out.print("Login: ");
        login = in.nextLine();

        System.out.print("Pass: ");
        pass = in.nextLine();

        if(Login.CheckPass(login, pass)) {
            System.out.println("Successfully logged in");
        } else {
            System.out.println("Oops... Something goes wrong. Try again");
        }

    }
}
