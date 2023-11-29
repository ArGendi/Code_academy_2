class User{
  int? key;
  String? email;
  String? pass;

  User({this.email, this.pass});
  User.fromMap(this.key, Map map){ // {email: a@gmail.com, password: 12345678}
    email = map['email'];
    pass = map['password'];
  }

  Map<String, dynamic> toMap(){
    return {
      'email' : email,
      'password': pass,
    };
  }
}