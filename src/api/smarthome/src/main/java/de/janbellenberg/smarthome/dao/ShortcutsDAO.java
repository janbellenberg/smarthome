package de.janbellenberg.smarthome.dao;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import de.janbellenberg.smarthome.base.PersistenceHelper;
import de.janbellenberg.smarthome.model.Building;
import de.janbellenberg.smarthome.model.Device;
import de.janbellenberg.smarthome.model.Shortcut;

@Stateless
public class ShortcutsDAO {

  @PersistenceContext(name = "mysql")
  private EntityManager em;

  public List<Shortcut> getAllShortcutsOfBuilding(final int building) {
    Query q = this.em.createNamedQuery("Shortcut.findAllInBuilding");
    q.setParameter("building", building);

    return PersistenceHelper.castList(Shortcut.class, q.getResultList());
  }

  public Shortcut saveShortcut(final Shortcut shortcut) {
    Shortcut instance = this.em.find(Shortcut.class, shortcut.getId(), LockModeType.PESSIMISTIC_WRITE);

    if (instance == null) {
      instance = new Shortcut();
    }

    int buildingID = shortcut.getBuilding() == null ? instance.getBuilding().getId() : shortcut.getBuilding().getId();
    Building building = this.em.find(Building.class, buildingID, LockModeType.PESSIMISTIC_READ);

    int deviceID = shortcut.getDevice() == null ? instance.getDevice().getId() : shortcut.getDevice().getId();
    Device device = this.em.find(Device.class, deviceID, LockModeType.PESSIMISTIC_READ);

    instance.setBuilding(building);
    instance.setDevice(device);
    instance.setDescription(shortcut.getDescription());
    instance.setCommand(shortcut.getCommand());

    return this.em.merge(instance);
  }

  public void deleteShortcut(final int id) {
    Shortcut instance = this.em.find(Shortcut.class, id, LockModeType.PESSIMISTIC_WRITE);
    this.em.remove(instance);
  }
}
