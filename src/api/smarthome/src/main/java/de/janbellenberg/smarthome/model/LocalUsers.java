package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the users_local database table.
 * 
 */
@Entity
@Table(name = "users_local")
public class LocalUsers implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String password;

	private String salt;

	// bi-directional one-to-one association to UsersGeneral
	@OneToOne
	@JoinColumn(name = "id")
	private User user;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSalt() {
		return this.salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}