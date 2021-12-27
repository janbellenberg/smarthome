package de.janbellenberg.smarthome.base.helper;

import com.fasterxml.jackson.databind.JsonNode;

import de.janbellenberg.smarthome.core.Configuration;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * helper class for sending mails
 * 
 * @author janbellenberg
 *
 */
public class MailHelper {

  private MailHelper() {
  }

  /**
   * send a mail
   * 
   * @param receiver receiver email-address
   * @param subject  subject of the email
   * @param data     content of the email
   */
  public static void sendMail(String receiver, String subject, String data) {
    // create new thread
    new Thread(() -> {
      try {
        JsonNode smtpConfig = Configuration.getCurrentConfiguration().getMailConfig();

        String username = smtpConfig.get("username").textValue();
        String password = smtpConfig.get("password").textValue();
        String senderAddress = smtpConfig.get("sender").textValue();

        Session session = javax.mail.Session.getInstance(System.getProperties(), new javax.mail.Authenticator() {
          @Override
          protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
          }
        });

        // build message
        MimeMessage m = new MimeMessage(session);
        Address from = new InternetAddress(senderAddress);
        Address[] to = new InternetAddress[] { new InternetAddress(receiver) };
        m.setFrom(from);
        m.setRecipients(Message.RecipientType.TO, to);
        m.setSubject(subject);
        m.setSentDate(new java.util.Date());
        m.setContent(data, "text/html; charset=UTF-8");
        Transport.send(m);
      } catch (MessagingException exception) {
        exception.printStackTrace();
      }
    }).start();
  }
}
