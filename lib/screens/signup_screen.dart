import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sadqapak/screens/home_screen.dart';
import 'package:sadqapak/utils/routes.dart';
import '../controllers/login_controller.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import '../widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'login_screen.dart';
import 'main_drawer_scree.dart';
// import 'sadqapak/controllers/login_controller.dart' as LoginController;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}


class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool IsPassword = true;
  bool ShowPassword = true;
  bool _isObscure = true;
  bool value = false;




  Future<void> signup() async{

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text.toString());
    if(emailValid){
      showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // The loading indicator
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Loading...')
                  ],
                ),
              ),
            );
          });
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1660039215%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
      };
      var request = http.Request('POST', Uri.parse('https://sadqapakistan.org/wp-json/wp/v2/users/register'));
      request.body = json.encode({
        "username": usernamecontroller.text.toString(),
        "email": emailController.text.toString(),
        "password": passwordController.text.toString()
      });

      print(request);
      print(passwordController.text.toString());
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        String data = await response.stream.bytesToString();
        final token =  json.decode(data);


        // var jso = json.decode(response.stream.bytesToString().toString());

        print(token["message"]);
        Fluttertoast.showToast(msg: token["message"]);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  loginScreen()),
        );
        print(await response.stream.bytesToString());

      }
      else {
        Navigator.of(context).pop();
        String data = await response.stream.bytesToString();
        final token =  json.decode(data);


        // var jso = json.decode(response.stream.bytesToString().toString());

        print(token["message"]);
        Fluttertoast.showToast(msg: token["message"]);

      }
    }
    else
      {
        Fluttertoast.showToast(msg: 'Enter a valid Email');
      }



  }

  @override
  Widget build(BuildContext context) {
    var navigationService = locator<NavigationService>();
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context)=>LoginController(),
          builder: (context,child){
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    /*Text(
                      "“O believers give of what \n We have provided for \n you.” \n [Qur’an 2:254]",
                      style: TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(247, 185, 26, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      width: 200,
                      // height: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.normal,
                        height: 1.6,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: usernamecontroller,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 20.0,
                                    ),
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 20.0,
                                    ),
                                    hintText: 'Email Address',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  // keyboardType: TextInputType.emailAddress,
                                  controller: passwordController,
                                  autocorrect: true,
                                  obscureText: _isObscure,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 20.0,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      color: Colors.green,
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: this.value,
                          checkColor: Colors.white,
                          focusColor: Color.fromRGBO(36, 124, 38, 1),
                          activeColor: Color.fromRGBO(36, 124, 38, 1),
                          onChanged: (bool? value) {
                            setState(() {
                              this.value = value!;
                            });
                          },
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              // width: 5.0,
                              color: Colors.transparent ?? Colors.white,
                            ),
                            minimumSize:
                            Size.fromHeight(MediaQuery.of(context).size.height * 0.052),
                            primary:Color.fromRGBO(36, 124, 38, 1) ?? Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15 ??
                                  MediaQuery.of(context).size.width * 0.02),
                            ),
                          ),
                          onPressed: () {
                            if(usernamecontroller.text.isEmpty || passwordController.text.isEmpty || emailController.text.isEmpty){
                              Fluttertoast.showToast(msg: 'Please Enter All Details');
                            }
                            else
                              {
                                signup();
                              }

                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.022,
                                bottom: MediaQuery.of(context).size.height * 0.022),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white ?? Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          ))
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "or continue with",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // getSocialButton(
                        //   "assets/images/google.png",
                        // ),
                        GestureDetector(
                          onTap: () {
                            print("tapped on google button");
                            Provider.of<LoginController>(context, listen: false)
                                .googlelogin();
                          },
                          child: getSocialButton(
                            "assets/images/google.png",
                          ),
                        ),
                        getSocialButton(
                          "assets/images/facebook.png",
                        ),
                        /*getSocialButton(
                          "assets/images/iphone.png",
                        ),*/
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigationService.navigateTo(loginScreenRoute);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                              color: Color.fromRGBO(36, 124, 38, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          },

        )],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "“O believers give of what \n We have provided for \n you.” \n [Qur’an 2:254]",
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(247, 185, 26, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  // height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: usernamecontroller,
                              autocorrect: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                hintText: 'Username',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              autocorrect: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                hintText: 'Email Address',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              // keyboardType: TextInputType.emailAddress,
                              controller: passwordController,
                              autocorrect: true,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    ShowPassword = !ShowPassword;
                                  },
                                  child: IsPassword == "true"
                                      ? Icon(
                                    Icons.visibility_off,
                                    color: Color.fromRGBO(138, 158, 184, 1),
                                    size: 20,
                                  )
                                      : Icon(
                                    Icons.visibility,
                                    color: Color.fromRGBO(138, 158, 184, 1),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: this.value,
                      checkColor: Colors.white,
                      focusColor: Color.fromRGBO(36, 124, 38, 1),
                      activeColor: Color.fromRGBO(36, 124, 38, 1),
                      onChanged: (bool? value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: ButtonWidget(
                    onTap: () {
                      signup();
                    },
                    text: "Sign Up",
                    buttonColor: Color.fromRGBO(36, 124, 38, 1),
                    textColor: Colors.white,
                    borderColor: Colors.transparent,
                    buttonRadius: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "or continue with",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // getSocialButton(
                    //   "assets/images/google.png",
                    // ),
                    GestureDetector(
                      onTap: () {
                        print("tapped on google button");
                        Provider.of<LoginController>(context, listen: false)
                            .googlelogin();
                      },
                      child: getSocialButton(
                        "assets/images/google.png",
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Provider.of<LoginController>(context, listen: false)
                            .facebookLogin();
                      },
                      child: getSocialButton(
                        "assets/images/facebook.png",
                      ),
                    ),
                    // getSocialButton(
                    //   "assets/images/iphone.png",
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationService.navigateTo(loginScreenRoute);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                          color: Color.fromRGBO(36, 124, 38, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }



  Widget getSocialButton(String image,)
  {
    return Container(
      margin: EdgeInsets.all(8),
      child: Image(
        image: AssetImage(
          image,
        ),
        width: 45,
        height: 45,
      ),
    );
  }

/*  Widget loggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(
            model.userDetail!.photoUrl ?? '',
          ).image,
          radius: 50,
        ),
        Text(model.userDetail!.displayName ?? ''),
        Text(model.userDetail!.email ?? ''),
        ActionChip(
          avatar: Icon(Icons.logout),
          label: Text("Logout"),
          onPressed: () {
            print("tapped on logout");
            Provider.of<LoginController>(context, listen: false).logOut();
          },
        )
      ],
    );
  }

  Center loginControls(BuildContext context){
    var navigationService = locator<NavigationService>();
    return Center(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
        Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "“O believers give of what \n We have provided for \n you.” \n [Qur’an 2:254]",
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(247, 185, 26, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  // height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              // keyboardType: TextInputType.emailAddress,
                              // controller: controller.emailController,
                              autocorrect: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                hintText: 'Email Address',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              // keyboardType: TextInputType.emailAddress,
                              // controller: controller.passController,
                              autocorrect: true,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    ShowPassword = !ShowPassword;
                                  },
                                  child: IsPassword == "true"
                                      ? Icon(
                                    Icons.visibility_off,
                                    color: Color.fromRGBO(138, 158, 184, 1),
                                    size: 20,
                                  )
                                      : Icon(
                                    Icons.visibility,
                                    color: Color.fromRGBO(138, 158, 184, 1),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: this.value,
                      checkColor: Colors.white,
                      focusColor: Color.fromRGBO(36, 124, 38, 1),
                      activeColor: Color.fromRGBO(36, 124, 38, 1),
                      onChanged: (bool? value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: ButtonWidget(
                    onTap: () {},
                    text: "Sign Up",
                    buttonColor: Color.fromRGBO(36, 124, 38, 1),
                    textColor: Colors.white,
                    borderColor: Colors.transparent,
                    buttonRadius: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "or continue with",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // getSocialButton(
                    //   "assets/images/google.png",
                    // ),
                    GestureDetector(
                      onTap: () {
                        print("tapped on google button");
                        Provider.of<LoginController>(context, listen: false)
                            .googlelogin();
                      },
                      child: getSocialButton(
                        "assets/images/google.png",
                      ),
                    ),
                    getSocialButton(
                      "assets/images/facebook.png",
                    ),
                    getSocialButton(
                      "assets/images/iphone.png",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationService.navigateTo(loginScreenRoute);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                          color: Color.fromRGBO(36, 124, 38, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ],
    ),
    );

  }*/
}

