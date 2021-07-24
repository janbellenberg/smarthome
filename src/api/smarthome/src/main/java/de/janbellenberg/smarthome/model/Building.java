package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

/**
 * The persistent class for the buildings database table.
 * 
 */
@Entity
@Table(name = "buildings")
@NamedQuery(name = "Building.findAll", query = "SELECT b FROM Building b")
public class Building implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String city;

	private String country;

	private String name;

	private String postcode;

	private String street;

	// bi-directional many-to-one association to Member
	@OneToMany(mappedBy = "buildingBean")
	private List<Member> members;

	// bi-directional many-to-one association to Room
	@OneToMany(mappedBy = "buildingBean")
	private List<Room> rooms;

	// bi-directional many-to-one association to Shortcut
	@OneToMany(mappedBy = "buildingBean")
	private List<Shortcut> shortcuts;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostcode() {
		return this.postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getStreet() {
		return this.street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public List<Member> getMembers() {
		return this.members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}

	public Member addMember(Member member) {
		getMembers().add(member);
		member.setBuildingBean(this);

		return member;
	}

	public Member removeMember(Member member) {
		getMembers().remove(member);
		member.setBuildingBean(null);

		return member;
	}

	public List<Room> getRooms() {
		return this.rooms;
	}

	public void setRooms(List<Room> rooms) {
		this.rooms = rooms;
	}

	public Room addRoom(Room room) {
		getRooms().add(room);
		room.setBuildingBean(this);

		return room;
	}

	public Room removeRoom(Room room) {
		getRooms().remove(room);
		room.setBuildingBean(null);

		return room;
	}

	public List<Shortcut> getShortcuts() {
		return this.shortcuts;
	}

	public void setShortcuts(List<Shortcut> shortcuts) {
		this.shortcuts = shortcuts;
	}

	public Shortcut addShortcut(Shortcut shortcut) {
		getShortcuts().add(shortcut);
		shortcut.setBuildingBean(this);

		return shortcut;
	}

	public Shortcut removeShortcut(Shortcut shortcut) {
		getShortcuts().remove(shortcut);
		shortcut.setBuildingBean(null);

		return shortcut;
	}

}