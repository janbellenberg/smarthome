package de.janbellenberg.smarthome.dao;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import de.janbellenberg.smarthome.model.LocalUser;
import de.janbellenberg.smarthome.model.User;

@Stateless
public class UsersDAO {

  @PersistenceContext(name = "mysql")
  private EntityManager em;

  public User getUserById(final int id) {
    return this.em.find(User.class, id, LockModeType.PESSIMISTIC_READ);
  }

  public User saveUser(final User user) {
    LocalUser lUser = user.getLocalUser();
    user.setLocalUser(null);
    User inserted = this.em.merge(user);

    if (lUser != null) {
      lUser.setId(inserted.getId());
      this.em.merge(lUser);
      inserted.setLocalUser(lUser);
      inserted = this.em.merge(inserted);
    }

    return getUserById(inserted.getId());
  }

  public void deleteUser(final int id) {
    User instance = this.em.find(User.class, id, LockModeType.PESSIMISTIC_WRITE);
    this.em.remove(instance);
  }

  @SuppressWarnings("unchecked")
  public List<String> getSalts() {
    Query q = em.createNamedQuery("User.findSalts");
    return (List<String>) q.getResultList();
  }

}
