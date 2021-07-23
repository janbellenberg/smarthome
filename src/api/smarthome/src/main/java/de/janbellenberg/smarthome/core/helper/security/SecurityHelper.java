package de.janbellenberg.smarthome.core.helper.security;

import java.math.BigInteger;
import java.security.SecureRandom;

public class SecurityHelper {
  private SecurityHelper() {
  }

  /**
   * generates a random secure string with the specified length
   * 
   * @param length required length of the string
   * @return generated string
   */
  public static String generateSecureRandomString(int length) {
    SecureRandom random = new SecureRandom();
    StringBuilder result = new StringBuilder();

    for (int i = 0; i < length; i++)
      result.append(PasswordHelper.CHARSET[Math.abs(random.nextInt()) % PasswordHelper.CHARSET.length]);

    return result.toString();
  }

  /**
   * convert a byte array into a hex string
   * 
   * @param array input data
   * @return conversion result
   */
  public static String toHex(byte[] array) {
    BigInteger bi = new BigInteger(1, array);
    String hex = bi.toString(16);
    int paddingLength = (array.length * 2) - hex.length();
    if (paddingLength > 0) {
      return String.format("%0" + paddingLength + "d", 0) + hex;
    } else {
      return hex;
    }
  }
}
