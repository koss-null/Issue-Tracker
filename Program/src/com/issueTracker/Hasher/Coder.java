package com.issueTracker.Hasher;

import com.issueTracker.Config.*;

import java.math.BigInteger;
import java.security.MessageDigest;

/**
 * Created by Reddy on 14.04.2016.
 */
public class Coder {
    public static String GetMD5Hash(String s) {
        try {
            byte[] messageBytes = s.getBytes(Config.Encoding);

            try {
                MessageDigest md = MessageDigest.getInstance(Config.HashType);

                byte[] encodedBytes = md.digest(messageBytes);

                BigInteger bi = new BigInteger(1, encodedBytes);
                return bi.toString(16);
            } catch (java.security.NoSuchAlgorithmException e) {
                System.out.println("Error: No " + Config.HashType + " encoding algorithm");
            }
        } catch(java.io.UnsupportedEncodingException e) {
            System.out.println("Error: Do not know " + Config.Encoding + " code");
        }
        return "No Hash";
    }
}
