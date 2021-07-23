package de.janbellenberg.smarthome.core;

import java.util.logging.Logger;

import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.Startup;

@Singleton
@Startup
public class Initialization {
  /**
   * startup message and initial checks
   */
  @PostConstruct()
  public void init() {
    // Startup message

    Logger logger = Logger.getLogger("de.janbellenberg.smarthome");

    // TODO: ascii symbol image

    logger.info("======================== > SmartHome < ========================");
    logger.info(">> by Jan Bellenberg");

    if (Configuration.getCurrentConfiguration().isInDocker())
      logger.info("Docker environment detected");
  }
}
