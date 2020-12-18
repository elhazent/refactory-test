import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refactory_mobile/base/base-function.dart';
import 'package:refactory_mobile/constants.dart';
import 'package:refactory_mobile/model/login-story-model.dart';
import 'package:refactory_mobile/tools/helper/dbhelper.dart';

import 'login-page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String pathImage;

  Position _currentPosition;
  bool progressPosition = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(_currentPosition == null){
      setState(() {
        progressPosition = true;
      });
    } else {
      setState(() {
        progressPosition = false;
      });
    }
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

  registerUser() async {
    var db = DbHelper();
    var counter = 0;
    var userData = LoginStoryModel(emailController.text, passwordController.text, pathImage);
    await db.saveUserData(userData).then((value) async {
      counter += 1;
      db.setCounter(counter, emailController.text);
      BaseFunction.showFlushbar("Anda telah login menggunakan email : ${emailController.text} sebanyak ${counter - 1} kali",Colors.orange,context);
    }).then((value) {
      BaseFunction.showFlushbar("Akun Anda berhasil terdaftar",Colors.red,context);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginPage()
      ));
    });
  }

  checkUser() async {
    var db = DbHelper();
    var checkCounterEmail = await db.getLoginCounter(emailController.text).then((value) {
      if(value[0][DefaultKey.TotalLoginColumn] > 0 && value[0][DefaultKey.TotalLoginColumn] != null){
        BaseFunction.showFlushbar("Email yang anda masukkan sudah terdaftar",Colors.red,context);
        return value[0][DefaultKey.TotalLoginColumn];
      }else {
        print("Nope");
      }
    }).catchError((error) => print("$error"));
    if(checkCounterEmail == null){
      registerUser();
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white))
          ],
        ),
      ),
    );
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
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


  Widget _title() {
    return Image.asset(DefaultImageLocation.RefactoryLogo);
  }

  Widget _imageEmailPasswordWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _imageProfile(),
        SizedBox(
          height: 10,
        ),
        _entryField("Email"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  Widget _imageProfile(){
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),
            context: context,
            builder: (BuildContext bc){
              return Container(
                decoration: BoxDecoration(
                ),
                child: new Wrap(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3)
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Pick Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Divider()
                          )
                        ],
                      ),
                    ),
                    new ListTile(
                        leading: Icon(
                          Icons.camera
                        ),
                        title: new Text('Camera'),
                        onTap: ()async{
                          await ImagePicker.pickImage(source: ImageSource.camera).then((pickedImage) {
                            setState(() {
                              if(pickedImage != null){
                                setState(() {
                                  final bytes = File(pickedImage.path).readAsBytesSync();
                                  pathImage = base64Encode(bytes);
                                  print("Image Dialog : $pathImage");
                                  Navigator.pop(context);
                                });
                              } else {
                                print("No Image");
                                Navigator.pop(context);
                              }
                            });
                          });
                        }
                    ),
                    new ListTile(
                        leading: Icon(
                            Icons.photo_library
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Text('Photo Gallery'),
                          ],
                        ),
                        onTap: ()async{
                          await ImagePicker.pickImage(source: ImageSource.gallery).then((pickedImage) {
                            setState(() {
                              if(pickedImage != null){
                                setState(() {
                                  final bytes = File(pickedImage.path).readAsBytesSync();
                                  pathImage = base64Encode(bytes);
                                  print("Image Dialog : $pathImage");
                                  Navigator.pop(context);
                                });
                              } else {
                                print("No Image");
                                Navigator.pop(context);
                              }
                            });
                          });
                        }
                    ),
                  ],
                ),
              );
            }
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)
        ),
        child: pathImage == null?Icon(
          Icons.add
        ):CircleAvatar(
          backgroundImage: MemoryImage(base64Decode(pathImage)),
        ),
      ),
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
                        SizedBox(
                          height: 50,
                        ),
                        _imageEmailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(onTap: (){
                          if(emailController.text.isEmpty && passwordController.text.isEmpty && pathImage == null){
                            BaseFunction.showFlushbar("Field tidak boleh kosong",Colors.red,context);
                          } else if (!EmailValidator.validate(emailController.text)){
                            BaseFunction.showFlushbar("Email tidak valid",Colors.red,context);
                          }else if(pathImage == null){
                            BaseFunction.showFlushbar("No Image Selected",Colors.red,context);
                          } else {
                            checkUser();
                          }
                        }),
                        SizedBox(height: height * .14),
                        currentPosition(),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
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
      ),
    );
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
