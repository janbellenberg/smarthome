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
	private Building buildingBean;

	// bi-directional many-to-one association to Device
	@ManyToOne
	@JoinColumn(name = "device")
	private Device deviceBean;

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

	public Building getBuildingBean() {
		return this.buildingBean;
	}

	public void setBuildingBean(Building buildingBean) {
		this.buildingBean = buildingBean;
	}

	public Device getDeviceBean() {
		return this.deviceBean;
	}

	public void setDeviceBean(Device deviceBean) {
		this.deviceBean = deviceBean;
	}

}