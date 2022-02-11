package de.janbellenberg.smarthome;

import java.util.ArrayList;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;

import de.janbellenberg.smarthome.base.helper.security.PasswordHelper;

public class PasswordTest {

	@Test
	public void testHash() {
		String password = "test";
		String hash = "1d8ea7a0842ffa5cd6d574fe26feb433539a2ddc634fd277c34f51bdb90e84e019db72b8050208a30c86f5447ba80b695f337b47c694c1b969adadc490118a40";
		String salt = "TjFG0BtI2NEtpyzN7EIU";

		Assertions.assertEquals(hash, PasswordHelper.generateHash(password, salt, "7"));
	}

	@Test
	public void testMatchPassword() {
		String hash = "1d8ea7a0842ffa5cd6d574fe26feb433539a2ddc634fd277c34f51bdb90e84e019db72b8050208a30c86f5447ba80b695f337b47c694c1b969adadc490118a40";
		String salt = "TjFG0BtI2NEtpyzN7EIU";

		Assertions.assertTrue(PasswordHelper.matchPassword("test", hash, salt));
		Assertions.assertFalse(PasswordHelper.matchPassword("smarthome", hash, salt));
	}

	@Test
	public void testSaltGen() {
		Assertions.assertEquals(20, PasswordHelper.generateSalt(new ArrayList<String>()).length());
	}
}
