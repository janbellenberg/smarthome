package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the members database table.
 * 
 */
@Entity
@Table(name = "members")
@NamedQueries({
		@NamedQuery(name = "Member.findAllOfBuilding", query = "SELECT m FROM Member m WHERE m.building.id = :building"),
		@NamedQuery(name = "Member.findMember", query = "SELECT m FROM Member m WHERE m.building.id = :building AND m.user.id = :user") })
public class Member implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	// bi-directional many-to-one association to Building
	@ManyToOne
	@JoinColumn(name = "building")
	private Building building;

	// bi-directional many-to-one association to UsersGeneral
	@ManyToOne
	@JoinColumn(name = "user")
	private User user;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Building getBuilding() {
		return this.building;
	}

	public void setBuilding(Building building) {
		this.building = building;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}