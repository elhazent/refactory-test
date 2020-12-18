import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:refactory_mobile/base/base-function.dart';
import 'package:refactory_mobile/constants.dart';
import 'package:refactory_mobile/features/auth/register-page.dart';
import 'package:refactory_mobile/features/main/main-page.dart';
import 'package:refactory_mobile/model/login-story-model.dart';
import 'package:refactory_mobile/tools/helper/dbhelper.dart';
import 'package:sqflite/sqflite.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Position _currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position)async{
     setState(() {
       _currentPosition = position;
     });
      print("Location:" +
          _currentPosition.latitude.toString() +
          " " +
          _currentPosition.longitude.toString());
    }).catchError((e){
      print(e);
    });
  }

  checkUser() async {
    var db = DbHelper();
    var checkCounterEmail = await db.getLoginCounter(emailController.text).then((value) {
      if(value[0][DefaultKey.TotalLoginColumn] > 0 && value[0][DefaultKey.TotalLoginColumn] != null){
        return value[0][DefaultKey.TotalLoginColumn];
      }
    }).catchError((error) => print("Error login => $error"));
    if(checkCounterEmail == null){
      BaseFunction.showFlushbar("Akun anda belum terdaftar, Silahkan registrasi dahulu",Colors.red,context);
    }else if(checkCounterEmail > 0){
      var login = await db.loginUser(emailController.text, passwordController.text).then((value) {
        if(value != null){
          return value[0];
        }
      }).catchError((error) => print("$error"));
      if(login == null){
        BaseFunction.showFlushbar("Email atau password anda salah",Colors.red,context);
      }else {
        checkCounterEmail += 1;
        var counter = await db.setCounter(checkCounterEmail, login[DefaultKey.EmailColumn]).then((_) {
          var counterEmail = db.getLoginCounter(login[DefaultKey.EmailColumn]).then((value) {
            if(value[0][DefaultKey.TotalLoginColumn] > 0 && value[0][DefaultKey.TotalLoginColumn] != null){
              return value[0][DefaultKey.TotalLoginColumn];
            }
          }).catchError((error) => print("$error"));
          return counterEmail;
        });
        BaseFunction.showFlushbar("Anda telah login menggunakan email : ${login[DefaultKey.EmailColumn]} sebanyak ${counter - 1} kali",Colors.orange,context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => MainPage()
          ));
        });
      }
    }
  }


  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: !isPassword?emailController:passwordController,
              keyboardType: !isPassword?TextInputType.emailAddress:TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton({onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448),Color(0xffe46b10)]
            )),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
  Widget _registerButton({onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448),Color(0xffe46b10)]
            )),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return Image.asset(DefaultImageLocation.RefactoryLogo);
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                color: DefaultColor.primaryColor
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .2),
                          _title(),
                          SizedBox(height: 50),
                          _emailPasswordWidget(),
                          SizedBox(height: 20),
                          _submitButton(
                            onTap: (){
                              if(emailController.text.isEmpty && passwordController.text.isEmpty){
                                BaseFunction.showFlushbar("Field tidak boleh kosong",Colors.red,context);
                              } else if (!EmailValidator.validate(emailController.text)){
                                BaseFunction.showFlushbar("Email tidak valid",Colors.red,context);
                              } else{
                                checkUser();
                              }
                            }
                          ),
                          SizedBox(height: 20),
                          _registerButton(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => RegisterPage()));
                            }
                          ),
                          SizedBox(height: height * .055),
                          currentPosition()
                        ],
                      ),
                    ),
                  ),
                  // Positioned(top: 40, left: 0, child: _backButton()),
                ],
              ),
            ),
            _currentPosition == null?Opacity(
              opacity: 0.7,
              child: Container(
                decoration: BoxDecoration(
                    color: DefaultColor.primaryColor
                ),
                child: new Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                    valueColor: AlwaysStoppedAnimation(DefaultColor.primaryColor),
                  ),
                ),
              ),
            ):SizedBox(),
          ],
        ));
  }

  Widget currentPosition(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
              "Position :",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Text(
          "Lat : ${_currentPosition == null?"-":_currentPosition.latitude.toString()}",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(
          "Long : ${_currentPosition == null?"-":_currentPosition.longitude.toString()}",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }


}