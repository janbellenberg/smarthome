package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

/**
 * The persistent class for the devices database table.
 * 
 */
@Entity
@Table(name = "devices")
@NamedQuery(name = "Device.findAll", query = "SELECT d FROM Device d")
public class Device implements Serializable {

	public Device() {
	}

	@JsonCreator
	public Device(int id) {
		this.id = id;
	}

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String description;

	private String local;

	private String mac;

	private String name;

	private String type;

	private String vendor;

	// bi-directional many-to-one association to Room
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "room")
	private Room room;

	// bi-directional many-to-one association to Shortcut
	@JsonIgnore
	@OneToMany(mappedBy = "device")
	private List<Shortcut> shortcuts;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocal() {
		return this.local;
	}

	public void setLocal(String local) {
		this.local = local;
	}

	public String getMac() {
		return this.mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getVendor() {
		return this.vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public Room getRoom() {
		return this.room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public List<Shortcut> getShortcuts() {
		return this.shortcuts;
	}

	public void setShortcuts(List<Shortcut> shortcuts) {
		this.shortcuts = shortcuts;
	}

	public Shortcut addShortcut(Shortcut shortcut) {
		this.getShortcuts().add(shortcut);
		shortcut.setDevice(this);

		return shortcut;
	}

	public Shortcut removeShortcut(Shortcut shortcut) {
		this.getShortcuts().remove(shortcut);
		shortcut.setDevice(null);

		return shortcut;
	}

}