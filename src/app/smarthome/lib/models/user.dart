class User {
  int? ID;
  String firstname;
  String lastname;

  User(this.firstname, this.lastname);
  User.fromDB(this.ID, this.firstname, this.lastname);
}
