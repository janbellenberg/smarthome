package de.janbellenberg.smarthome.dao;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import de.janbellenberg.smarthome.core.PersistenceHelper;
import de.janbellenberg.smarthome.model.Building;
import de.janbellenberg.smarthome.model.Room;

@Stateless
public class RoomsDAO {

  @PersistenceContext(name = "mysql")
  private EntityManager em;

  public List<Room> getAllRoomsOfUser(final int building) {
    Query q = this.em.createNamedQuery("Room.findAllInBuilding");
    q.setParameter("building", building);

    return PersistenceHelper.castList(Room.class, q.getResultList());
  }

  public Room saveRoom(final Room room) {
    Room instance = this.em.find(Room.class, room.getId(), LockModeType.PESSIMISTIC_WRITE);

    if (instance == null) {
      instance = new Room();
    }

    int buildingID = room.getBuilding() == null ? instance.getBuilding().getId() : room.getBuilding().getId();
    Building building = this.em.find(Building.class, buildingID, LockModeType.PESSIMISTIC_READ);

    instance.setName(room.getName());
    instance.setBuilding(building);

    return this.em.merge(instance);
  }

  public void deleteRoom(final int id) {
    Room instance = this.em.find(Room.class, id, LockModeType.PESSIMISTIC_WRITE);
    this.em.remove(instance);
  }
}
