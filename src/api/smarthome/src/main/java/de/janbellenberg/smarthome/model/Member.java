package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the members database table.
 * 
 */
@Entity
@Table(name = "members")
@NamedQuery(name = "Member.findAll", query = "SELECT m FROM Member m")
public class Member implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	// bi-directional many-to-one association to Building
	@ManyToOne
	@JoinColumn(name = "building")
	private Building buildingBean;

	// bi-directional many-to-one association to UsersGeneral
	@ManyToOne
	@JoinColumn(name = "user")
	private User usersGeneral;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Building getBuildingBean() {
		return this.buildingBean;
	}

	public void setBuildingBean(Building buildingBean) {
		this.buildingBean = buildingBean;
	}

	public User getUsersGeneral() {
		return this.usersGeneral;
	}

	public void setUsersGeneral(User usersGeneral) {
		this.usersGeneral = usersGeneral;
	}

}