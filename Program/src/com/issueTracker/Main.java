package com.issueTracker;

import com.issueTracker.Logger.*;
import com.issueTracker.Register.*;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws java.lang.ClassNotFoundException, java.sql.SQLException {
        System.out.print("Login or register (L\\R)");
        Scanner in = new Scanner(System.in);

        char ans = in.next().charAt(0);
        if(ans == 'R') {
            Register.Registration();
        }

        Login person = new Login();
        person.getID();
    }
}
