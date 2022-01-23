package de.janbellenberg.smarthome.base.helper;

public class Tupel<T, R> {
  private T value1;
  private R value2;

  public Tupel(T value1, R value2) {
    this.value1 = value1;
    this.value2 = value2;
  }

  public T getValue1() {
    return value1;
  }

  public void setValue1(T value1) {
    this.value1 = value1;
  }

  public R getValue2() {
    return value2;
  }

  public void setValue2(R value2) {
    this.value2 = value2;
  }

  @Override
  public int hashCode() {
    return (this.value1.toString() + this.value2.toString()).hashCode();
  }

  @Override
  @SuppressWarnings("unchecked")
  public boolean equals(Object obj) {

    if (!(obj instanceof Tupel)) {
      return false;
    }

    Tupel<T, R> t = Tupel.class.cast(obj);
    return t.getValue1() == this.getValue1() && t.getValue2().equals(this.getValue2());
  }

}
