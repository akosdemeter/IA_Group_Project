package intalk;
import java.security.MessageDigest;
import jakarta.xml.bind.DatatypeConverter;

public class PW_encrypt {   
    private String pwhash = "Teszt";
    
    public PW_encrypt(){}
    
    public void setPassword(String password) {     
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] inputBytes = password.getBytes();
            byte[] hashBytes =  digest.digest(inputBytes);;
            pwhash = DatatypeConverter.printHexBinary(hashBytes).toLowerCase() ;
        } catch (Exception ex) {

        }
    }
    public String getPassword(){
        return pwhash;
    }
}

