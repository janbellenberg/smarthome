package de.janbellenberg.smarthome.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

/**
 * The persistent class for the rooms database table.
 * 
 */
@Entity
@Table(name = "rooms")
@NamedQuery(name = "Room.findAll", query = "SELECT r FROM Room r")
public class Room implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	// bi-directional many-to-one association to Device
	@OneToMany(mappedBy = "roomBean")
	private List<Device> devices;

	// bi-directional many-to-one association to Building
	@ManyToOne
	@JoinColumn(name = "building")
	private Building buildingBean;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Device> getDevices() {
		return this.devices;
	}

	public void setDevices(List<Device> devices) {
		this.devices = devices;
	}

	public Device addDevice(Device device) {
		getDevices().add(device);
		device.setRoomBean(this);

		return device;
	}

	public Device removeDevice(Device device) {
		getDevices().remove(device);
		device.setRoomBean(null);

		return device;
	}

	public Building getBuildingBean() {
		return this.buildingBean;
	}

	public void setBuildingBean(Building buildingBean) {
		this.buildingBean = buildingBean;
	}

}