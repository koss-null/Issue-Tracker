package MD5Hasher;

import java.io.UnsupportedEncodingException;
import CommonVars.CommonStrings;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Hasher {
    public String GetHash(String pass) {
       try {
           byte[] bytesOfMessage = pass.getBytes(CommonStrings.commonStringFormat);

           MessageDigest md = MessageDigest.getInstance(CommonStrings.commonEncodeFormat);
           md.update(bytesOfMessage);
           byte[] hashBytes = md.digest();

           BigInteger bigInt = new BigInteger(1,hashBytes);
           String hashText = bigInt.toString(16);
           //It actually works

           return hashText;
       } catch (UnsupportedEncodingException us) {
           System.out.print(us.getMessage());
       } catch (NoSuchAlgorithmException na) {
           System.out.println(na.getMessage());
       }
        return "Error";
    }
}
