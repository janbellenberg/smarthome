package de.janbellenberg.smarthome.base;

import java.util.Collection;
import java.util.List;
import java.util.ArrayList;

public class PersistenceHelper {
  private PersistenceHelper() {
  }

  public static <T> List<T> castList(Class<? extends T> itemType, Collection<?> list) {
    List<T> result = new ArrayList<>(list.size());

    for (Object obj : list) {
      result.add(itemType.cast(obj));
    }

    return result;
  }

}
