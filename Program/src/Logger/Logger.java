package Logger;

//Databases
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import MD5Hasher.MD5Hasher;

public class Logger {
    public /*boolean*/ void IdentifyUser(String login, String pass) {
        MD5Hasher hasher = new MD5Hasher();
        String passHash = hasher.GetHash(pass);
    }
}
