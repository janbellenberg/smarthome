package de.janbellenberg.smarthome.core.helper.security;

import static java.nio.charset.StandardCharsets.UTF_8;

import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.Signature;
import java.security.SignatureException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

/**
 * helper class for rsa sign and verify
 * 
 * @author janbellenberg
 *
 */
public class RsaHelper {

  /**
   * private key of the server
   */
  private static final byte[] privateKey = Base64.getDecoder()
      .decode("MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDbQXxVPOh7wx0R"
          + "vv/4sStuKmgPIowC4GR1GbMlGvFKaQZfjgadpxffy+Em9wkmnuwVg1kAuh9EzEhx"
          + "ftT59dmgNzXEkpoiAYGplGx78pXiSWVUMp1eNR3Yrw7Y5WERmmLhoe5B+pFibKVb"
          + "HCYROpAvDOuDTxp7VcSVdOABEv/YBb0+0ectBhrJkzwHreJSv+mt1fF3nue8SeR0"
          + "IfDHbOq08arbxvvEW8P41Ki7Ki4lZaYJWM+MKY81JaD8eK82Wj+bvImztIScN8Qx"
          + "QEJrhXS8w9NO8/ElqvITy4z2Tl2Uxj2Z4Pp6zXieDv6Hlvy+LKqxAdQyF4/N6jMe"
          + "Srxk2rWDAgMBAAECggEANrWbcaV2GVOxUDlJo+OJg76/Im+rYhhd2L5l7i9P4BJe"
          + "zb8htXr5QRWdg9yGgwWKwT96GO1YWhFjTjaorAqFmC3Ok9NE9JFNqmPnwfHhJorL"
          + "5vuOOvCkFupvmP17gCn23HhMfFgqqNWVWSun8Aqd6a+eoLA/WmEnYWe9cWctQdiO"
          + "UgwlfYBitM3kh9SpVktfPsAw+Uj5hAE9J4kUiDqLSjZXTSqeEmuthIXbXouBidsW"
          + "fr74XBUCyNebndulbNtbzOo912TT5IysOLriWmmC/15GjevTEAZFLr8jbZtXOPoF"
          + "WaSzrW/KdGVXffkiBZtoiycQCwWDgi5MA/s9eDE3MQKBgQD7qyACuVb75v8lUS8k"
          + "ExecL0kmYufKDU8b95zW1GNy4OWu4sCIl9yA55eqLHIEJVvIXCcNV68KuGgJzFYA"
          + "rqjQguSmKAhxun4DVPBiPfb+0oEvYZC5Eg6FUysl7QF0IKon1y+9jRWDgZbLcKrQ"
          + "MUVkj00VB2v0W8HKYj2mn41P+QKBgQDfB4wkA+F2cDpN4lM0fRs7ARpIt6pAP83q"
          + "HbY9ewMGojFP/7IBUTIJ6L/iY3e2cp7ccULeEcQ4uKEHhK6VKWSfQxQtuQ9h1nYI"
          + "+aGndOWOdqGKNCP5geiEyDLJPeNO/ATxPljs3mKoOnuNKUqSSzm9eUS8INyhEhqp"
          + "SjTrQvuIWwKBgQDNubyIHYPalaD6m1vCzIyfUxQj+fPqemixvv8JqkLFVMzM4nVq"
          + "82EAStDy/jQR6YwWxCX0RTpEtCvv3oZrNluvX2CT5uPIPB/oj1WVqXuwINoTpljM"
          + "wNL37920ugJXMKCHwuM2uw7cGmHvWeF4IN7N7kqfpxp7fUp0K0ykWYcF2QKBgFW8"
          + "5wjpXQFU/3T1bpsdBRzXvaz6vj5YyOYZafeUlIM2UtK4L0wGVMAuc6WqK1k+EwgX"
          + "mmcYWWCcyXrEbQD2mrIG7XjuTZWFBndIz/Y6IA12WX9xr+q5IBP7ilqGqh2xEI1V"
          + "NIZKr46QfPK1Tu+Sb64BMoVH9MkO1qUB2/odE+lFAoGBAPWtpYFs8KxbpilyKv52"
          + "W1E6Af793MQ2pIxWEagvoMdfLlDxihNNEhQJ/JtGBe45Eq35i68hMjrGnN7APtlb"
          + "pFSxMhNZG6AnVi0+GJZhvtHufxMuzDptKBYGvo/rIzcKZlrocQEta9Fdij2oUzrXymSRzsF4gxNmYmThw8zgjXVe");

  private RsaHelper() {
  }

  /**
   * signs data with the private key of the server
   * 
   * @param raw input data
   * @return signed input data
   */
  public static String sign(String raw) {
    try {
      // initialize the rsa algorithm
      KeyFactory kf = KeyFactory.getInstance("RSA");
      PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKey);
      RSAPrivateKey key = (RSAPrivateKey) kf.generatePrivate(keySpec);

      // sign the data
      Signature signature = Signature.getInstance("SHA512withRSA");
      signature.initSign(key);
      signature.update(raw.getBytes(UTF_8));

      byte[] signed = signature.sign();
      return Base64.getEncoder().encodeToString(signed);

    } catch (NoSuchAlgorithmException | InvalidKeySpecException | InvalidKeyException | SignatureException exception) {
      exception.printStackTrace();
      return null;
    }
  }

  /**
   * verifies the signature of data
   * 
   * @param raw       actual data
   * @param signature signed data
   * @param pem       the public key that belongs to the used private key
   * @return if the signature is valid
   */
  public static boolean verify(String raw, String signature, String pem) {
    try {
      // prepare and load public key
      pem = pem.replaceAll("\n", "");
      pem = pem.replaceAll("\r", "");
      pem = pem.replace("-----BEGIN PUBLIC KEY-----", "");
      pem = pem.replace("-----END PUBLIC KEY-----", "");

      byte[] publicKeyBytes = Base64.getDecoder().decode(pem);

      byte[] rawBytes = raw.getBytes(UTF_8);
      byte[] signatureBytes = Base64.getDecoder().decode(signature);

      // initialize the rsa algorithm
      KeyFactory keyFactory = KeyFactory.getInstance("RSA");
      X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
      RSAPublicKey publicKey = (RSAPublicKey) keyFactory.generatePublic(keySpec);

      // verify the signature
      Signature publicSignature = Signature.getInstance("SHA512withRSA");
      publicSignature.initVerify(publicKey);
      publicSignature.update(rawBytes);

      return publicSignature.verify(signatureBytes);

    } catch (NoSuchAlgorithmException | InvalidKeySpecException | InvalidKeyException | SignatureException exception) {
      exception.printStackTrace();
      return false;
    }
  }

}
