package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

/**
 * The persistent class for the users_general database table.
 * 
 */
@Entity
@Table(name = "users_general")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String firstname;

	private String lastname;

	// bi-directional many-to-one association to Member
	@OneToMany(mappedBy = "user")
	private List<Member> members;

	// bi-directional one-to-one association to LocalUsers
	@OneToOne(mappedBy = "user")
	private LocalUsers localUser;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstname() {
		return this.firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return this.lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public List<Member> getMembers() {
		return this.members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}

	public Member addMember(Member member) {
		getMembers().add(member);
		member.setUser(this);

		return member;
	}

	public Member removeMember(Member member) {
		getMembers().remove(member);
		member.setUser(null);

		return member;
	}

	public LocalUsers getLocalUser() {
		return this.localUser;
	}

	public void setLocalUser(LocalUsers localUser) {
		this.localUser = localUser;
	}

}