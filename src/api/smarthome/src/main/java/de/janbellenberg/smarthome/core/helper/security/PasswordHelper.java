package de.janbellenberg.smarthome.core.helper.security;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

/**
 * class for generating and validation of password hashes
 * 
 * @author janbellenberg
 * @see SecurePassword
 */
public class PasswordHelper {
  private PasswordHelper() {
  }

  public static char[] CHARSET = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
      'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
      'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
  private static final byte SALT_LENGTH = 20;

  /**
   * generates a new salt value
   * 
   * @param existing list of existing salts to keep the salt values unique
   * @return new, unique salt value
   */
  public static String generateSalt(List<String> existing) {
    String salt = "";
    do {
      salt = SecurityHelper.generateSecureRandomString(SALT_LENGTH);
    } while (existing.contains(salt));

    return salt;
  }

  /**
   * generates a pepper value
   * 
   * @return random letter
   */
  public static String generatePepper() {
    return SecurityHelper.generateSecureRandomString(1);
  }

  /**
   * verifies password hash
   * 
   * @param plain  un-hashed password, given by the user
   * @param hashed hashed version of the password
   * @param salt   used salt value
   * @return if the hash belongs the password
   */
  public static boolean matchPassword(String plain, String hashed, String salt) {
    for (int i = 0; i < CHARSET.length; i++) {
      if (hashed.equals(generateHash(plain, salt, String.valueOf(CHARSET[i]))))
        return true;
    }

    return false;
  }

  /**
   * generates a hash for the password
   * 
   * @param plain  not encrypted password
   * @param salt   salt value that should be appended
   * @param pepper pepper value that should be appended
   * @return hash value for the given parameters
   */
  public static String generateHash(String plain, String salt, String pepper) {
    String combined;
    byte[] saltEnc;
    byte[] pHash;
    byte[] ivHashShort;
    byte[] encrypted;

    // generate informations for the actual encryption
    try {
      combined = plain + salt + pepper;
      saltEnc = (salt + pepper).getBytes("UTF-8");

      // Generate SHA-256 Hashes
      MessageDigest digest = MessageDigest.getInstance("SHA-256");
      pHash = digest.digest(plain.getBytes("UTF-8"));
      byte[] ivHash = digest.digest(combined.getBytes("UTF-8"));
      ivHashShort = Arrays.copyOf(ivHash, 16);

      // Reverse IV
      List<Byte> tmp = new ArrayList<>();
      for (int i = 0; i < 16; i++)
        tmp.add(ivHashShort[i]);
      Collections.reverse(tmp);
      for (int i = 0; i < 16; i++) {
        ivHashShort[i] = tmp.get(i);
      }

    } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
      ex.printStackTrace();
      return "";
    }

    // AES-Encryption
    try {
      SecretKeySpec key = new SecretKeySpec(pHash, "AES");
      IvParameterSpec iv = new IvParameterSpec(ivHashShort);
      Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
      cipher.init(Cipher.ENCRYPT_MODE, key, iv);
      encrypted = cipher.doFinal(pHash);
    } catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException
        | InvalidAlgorithmParameterException | BadPaddingException | IllegalBlockSizeException ex) {
      ex.printStackTrace();
      return "";
    }

    // PBKDF2-Hash
    try {
      char[] password = new String(encrypted, "UTF-8").toCharArray();
      PBEKeySpec specs = new PBEKeySpec(password, saltEnc, 10000, 512);
      SecretKeyFactory pbkdf2 = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
      byte[] hash = pbkdf2.generateSecret(specs).getEncoded();
      return SecurityHelper.toHex(hash);

    } catch (NoSuchAlgorithmException | InvalidKeySpecException | UnsupportedEncodingException ex) {
      ex.printStackTrace();
      return "";
    }
  }
}
