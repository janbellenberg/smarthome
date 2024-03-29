package de.janbellenberg.smarthome.core;

public class Constants {
  private Constants() {
  }

  public static final String SIGN_UP_MAIL = "<!DOCTYPE html>"
      + "<html lang='de'>"
      + "<head>"
      + "  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />"
      + "  <title>SmartHome</title>"
      + "  <meta name='viewport' content='width=device-width, initial-scale=1.0' />"
      + "  <style>"
      + "    body {"
      + "      font-family: sans-serif;"
      + "    }"
      + "    h1 {"
      + "      color: #528e75;"
      + "    }"
      + "    h2 {"
      + "      color: black;"
      + "    }"
      + "    div#wrapper {"
      + "      margin: 2em 1em;"
      + "      padding: 2em;"
      + "      max-width: 400px;"
      + "      background: #ececec;"
      + "      border-radius: 10px;"
      + "      box-shadow: 0px 0px 10px #00000029;"
      + "      text-align: center;"
      + "    }"
      + "    div#code {"
      + "      font-family: monospace;"
      + "      font-size: 1.5em;"
      + "      font-weight: bold;"
      + "      color: white;"
      + "      background: #528e75;"
      + "      padding: 1em 3em;"
      + "      display: inline-block;"
      + "      border-radius: 10px;"
      + "    }"
      + "  </style>"
      + "</head>"
      + "<body>"
      + "  <div id='wrapper'>"
      + "    <h1>internally</h1>"
      + "    <h2>Ihre Kundennummer lautet: </h2>"
      + "    <div id='code'>"
      + "      {uid}"
      + "    </div>"
      + "    <p />"
      + "  </div>"
      + "</body>"
      + "</html>";
}
