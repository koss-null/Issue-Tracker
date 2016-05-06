package com.issueTracker.DBQuerier;

import com.issueTracker.Config.Config;
import com.issueTracker.DBConnector.DBConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by Reddy on 24.04.2016.
 */
public class Querier {
    private static int queryCnt = 0;

    public static ResultSet MakeQuery(String query) {  //do not forget to close ResultSet!!!
                                                //from specification "all Statement objects will be closed when the connection that created them is closed"
        Connection conn = null;

        try {
            conn = DBConnector.GetConnection();
        } catch(Exception e) {
            e.printStackTrace();
        }

        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(query); // create a statement
            rs = pstmt.executeQuery();
            queryCnt++;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static ResultSet MakeQuery(PreparedStatement pstmt) {
        if(queryCnt > Config.MaxConnectionNumber) {
            try {
                DBConnector.CloseConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Connection conn = null;

        try {
            conn = DBConnector.GetConnection();
        } catch(Exception e) {
            e.printStackTrace();
        }

        ResultSet rs = null;
        try {
            rs = pstmt.executeQuery();
            queryCnt++;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static void MakeUpdateQuery(String query) {  //do not forget to close ResultSet!!!
        //from specification "all Statement objects will be closed when the connection that created them is closed"
        Connection conn = null;

        try {
            conn = DBConnector.GetConnection();
        } catch(Exception e) {
            e.printStackTrace();
        }

        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(query); // create a statement
            pstmt.executeUpdate();
            queryCnt++;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void MakeUpdateQuery(PreparedStatement pstmt) {
        if(queryCnt > Config.MaxConnectionNumber) {
            try {
                DBConnector.CloseConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Connection conn = null;

        try {
            conn = DBConnector.GetConnection();
        } catch(Exception e) {
            e.printStackTrace();
        }

        try {
            pstmt.executeUpdate();
            queryCnt++;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
