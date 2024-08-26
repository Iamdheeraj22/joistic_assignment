class Keys {
  //Create Singleton class instance
  static final Keys _keys = Keys._internal();

  //Private constructor
  Keys._internal();

  //Factory constructor
  factory Keys() {
    return _keys;
  }

  static const isLogin = 'isLogin';
  static const userCredential = 'userCredential';
  static const email = 'email';
  static const name = 'name';
  static const photoUrl = 'photoUrl';
}
