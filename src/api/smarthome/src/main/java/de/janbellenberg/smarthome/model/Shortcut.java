package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the shortcuts database table.
 * 
 */
@Entity
@Table(name = "shortcuts")
@NamedQuery(name = "Shortcut.findAll", query = "SELECT s FROM Shortcut s")
public class Shortcut implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Lob
	private String command;

	private String description;

	// bi-directional many-to-one association to Building
	@ManyToOne
	@JoinColumn(name = "building")
	private Building building;

	// bi-directional many-to-one association to Device
	@ManyToOne
	@JoinColumn(name = "device")
	private Device device;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCommand() {
		return this.command;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Building getBuilding() {
		return this.building;
	}

	public void setBuilding(Building building) {
		this.building = building;
	}

	public Device getDevice() {
		return this.device;
	}

	public void setDevice(Device device) {
		this.device = device;
	}

}