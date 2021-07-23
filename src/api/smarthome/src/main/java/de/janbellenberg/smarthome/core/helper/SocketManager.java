package de.janbellenberg.smarthome.core.helper;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.ejb.Lock;
import javax.ejb.LockType;
import javax.ejb.Singleton;
import javax.websocket.Session;

@Singleton
public class SocketManager {
  private final Set<Session> sessions = new HashSet<>();

  @Lock(LockType.READ)
  public Set<Session> getAllPerformanceSessions() {
    return Collections.unmodifiableSet(this.sessions);
  }

  @Lock(LockType.WRITE)
  public void addPerformanceSession(Session s) {
    this.sessions.add(s);
  }

  @Lock(LockType.WRITE)
  public void removePerformanceSession(Session s) {
    this.sessions.remove(s);
  }
}
