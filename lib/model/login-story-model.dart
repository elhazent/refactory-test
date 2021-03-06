class LoginStoryModel {
  int _id;
  String _email;
  String _password;
  String _pathImage;
  int _totalLogin;

  LoginStoryModel(this._email,this._password,this._pathImage);

  LoginStoryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _email = json['email'];
    _totalLogin = json['totalLogin'];
    _pathImage = json['pathImage'];
    _password = json['password'];
  }

  String get email => _email;
  int get totalLogin => _totalLogin;
  String get password => _password;
  String get pathImage => _pathImage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['email'] = this._email;
    data['password'] = this._password;
    data['totalLogin'] = this._totalLogin;
    data['pathImage'] = this._pathImage;
    return data;
  }

  void setUserData(int id){
    this._id = id;
  }
}