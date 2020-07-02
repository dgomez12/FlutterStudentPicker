class Student {
  String name;
  bool hidden;
  Student(this.name, this.hidden);

  Student.empty() {
    name = "";
    hidden = false;
  }
}