class User{
  var name;
  User(this.name);

  void setName(String name) {
    this.name = name;
  }

  String get getName => this.name;

  // 命名构造函数
  User.empty();
}