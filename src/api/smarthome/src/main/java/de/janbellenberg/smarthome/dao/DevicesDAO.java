package de.janbellenberg.smarthome.dao;

import javax.ejb.Stateless;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import de.janbellenberg.smarthome.base.PersistenceHelper;
import de.janbellenberg.smarthome.model.Device;

@Stateless
public class DevicesDAO {

  @PersistenceContext(name = "mysql")
  private EntityManager em;

  public List<Device> getAllDevicesInRoom(final int room) {
    Query q = this.em.createNamedQuery("Device.findAllForRoom");
    q.setParameter("room", room);

    return PersistenceHelper.castList(Device.class, q.getResultList());
  }

  public Device getDeviceByID(final int id) {
    return this.em.find(Device.class, id, LockModeType.PESSIMISTIC_READ);
  }

  public Device saveDevice(Device device) {
    return this.em.merge(device);
  }

  public void deleteDevice(final int id) {
    Device instance = this.em.find(Device.class, id, LockModeType.PESSIMISTIC_WRITE);
    this.em.remove(instance);
  }

}
