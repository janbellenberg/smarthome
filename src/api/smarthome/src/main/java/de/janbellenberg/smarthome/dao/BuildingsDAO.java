package de.janbellenberg.smarthome.dao;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import de.janbellenberg.smarthome.core.PersistenceHelper;
import de.janbellenberg.smarthome.model.Building;

@Stateless
public class BuildingsDAO {

  @PersistenceContext(name = "mysql")
  private EntityManager em;

  public List<Building> getAllBuildingsOfUser(/* final User user */) {
    Query q = this.em.createNamedQuery("Building.findAllForUser");
    q.setParameter("uid", /* user.getId() */ 1);

    return PersistenceHelper.castList(Building.class, q.getResultList());
  }

  public Building getBuildingById(final int id) {
    return this.em.find(Building.class, id, LockModeType.PESSIMISTIC_READ);
  }

  public Building saveBuilding(final Building building) {
    Building instance = this.em.find(Building.class, building.getId(), LockModeType.PESSIMISTIC_WRITE);

    if (instance == null) {
      instance = new Building();
    }

    instance.setName(building.getName());
    instance.setStreet(building.getStreet());
    instance.setPostcode(building.getPostcode());
    instance.setCity(building.getCity());
    instance.setCountry(building.getCountry());

    return this.em.merge(instance);
  }

  public void deleteBuilding(final int id) {
    Building instance = this.em.find(Building.class, id, LockModeType.PESSIMISTIC_WRITE);
    this.em.remove(instance);
  }

}
