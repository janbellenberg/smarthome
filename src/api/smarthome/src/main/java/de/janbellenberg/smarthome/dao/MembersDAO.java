package de.janbellenberg.smarthome.dao;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import de.janbellenberg.smarthome.base.PersistenceHelper;
import de.janbellenberg.smarthome.model.Building;
import de.janbellenberg.smarthome.model.Member;
import de.janbellenberg.smarthome.model.User;

@Stateless
public class MembersDAO {

  @PersistenceContext(name = "mysql")
  private EntityManager em;

  public List<Member> getMembersOfBuilding(final int building) {
    Query q = this.em.createNamedQuery("Member.findAllOfBuilding");
    q.setParameter("building", building);

    return PersistenceHelper.castList(Member.class, q.getResultList());
  }

  public void createMembership(final int userID, final int buildingID) {
    Member member = new Member();

    Building building = this.em.find(Building.class, buildingID, LockModeType.PESSIMISTIC_WRITE);
    member.setBuilding(building);

    User user = this.em.find(User.class, userID, LockModeType.PESSIMISTIC_WRITE);
    member.setUser(user);

    this.em.merge(member);
  }

  public void removeMembership(final int userID, final int buildingID) {
    Query q = this.em.createNamedQuery("Member.findMember");
    q.setParameter("building", buildingID);
    q.setParameter("user", userID);

    Member member = (Member) q.getSingleResult();
    this.em.remove(member);
  }
}
