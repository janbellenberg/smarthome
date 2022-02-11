package de.janbellenberg.smarthome;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import de.janbellenberg.smarthome.base.helper.Tupel;

public class TupelTest {

  @Test
  public void testTupel() {
    Tupel<Integer, String> tupel1 = new Tupel<>(1, "A");
    Assertions.assertEquals(1, tupel1.getValue1());
    Assertions.assertEquals("A", tupel1.getValue2());

    tupel1.setValue1(2);
    tupel1.setValue2("B");

    Assertions.assertEquals(2, tupel1.getValue1());
    Assertions.assertEquals("B", tupel1.getValue2());

    Tupel<Integer, String> tupel2 = new Tupel<>(2, "B");
    Assertions.assertEquals(tupel1, tupel2);
    Assertions.assertTrue(tupel1.equals(tupel2));
    Assertions.assertTrue(tupel1.hashCode() == tupel2.hashCode());

    tupel2 = new Tupel<>(3, "C");
    Assertions.assertNotEquals(tupel1, tupel2);
    Assertions.assertFalse(tupel1.equals(tupel2));
    Assertions.assertFalse(tupel1.hashCode() == tupel2.hashCode());
  }

}
