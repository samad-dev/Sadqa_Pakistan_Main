import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool IsconfirmPassword = true;
  bool IsnewPassword = true;
  bool IsPassword = true;
  bool isdisabled = true;


  Future<void> update1() async{
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
    // print('https://sadqapakistan.org/wp-json/wc/v3/customers/${id}');
    /*var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic Y2tfNjAxYzBmOWQ4ODA3MTMwZjYxNDgzODJkMDlkY2IzMDBiNWFmN2NhMzpjc180MGYyNWM1YjY3YmI1NWVmYmExYzY0YTFhOWY0NGVmYWM4NTljOGE1',
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1658747282%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
    };*/
    var headers = {
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1660753113%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
    };
    var request = http.Request('GET', Uri.parse('https://sadqapakistan.org/api/forgetpassword.php?login='+currentPassword.text.toString()+''));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      String data = await response.stream.bytesToString();
      final token =  json.decode(data);
      Fluttertoast.showToast(msg: token['msg']);

    }
    else {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
      print(response.reasonPhrase);
    }



    /*var request = http.Request('PUT', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/customers/${id}'));
    request.body = json.encode({
      "first_name": nameController.text.toString(),
      "email":emailController.text.toString(),
      "shipping": {
        "phone": phoneController.text.toString()
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'User Updated Successfully');
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }*/

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          bottomOpacity: 0,
          title: Text(
            "Change Password",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 24,
              ))),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Text(
                  "Email Address",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: currentPassword,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Enter Your Email Address",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    suffixIcon: GestureDetector(
                        child: IsPassword == true
                            ? Icon(
                                Icons.visibility_off,
                                color: Color.fromRGBO(138, 158, 184, 1),
                                size: 20,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Color.fromRGBO(138, 158, 184, 1),
                                size: 20,
                              )),
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 10,
                ),
                child: Text(
                  "New Password",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextFormField(
                  obscureText: IsnewPassword,
                  controller: newPassword,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Enter Your New Password",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    suffixIcon: GestureDetector(
                        child: IsnewPassword == true
                            ? Icon(
                                Icons.visibility_off,
                                color: Color.fromRGBO(138, 158, 184, 1),
                                size: 20,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Color.fromRGBO(138, 158, 184, 1),
                                size: 20,
                              )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                child: Text(
                  "Confirm New Password",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  obscureText: IsconfirmPassword,
                  controller: confirmPassword,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Enter Your Confirm Password",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    suffixIcon: GestureDetector(
                        child: IsconfirmPassword == true
                            ? Icon(
                                Icons.visibility_off,
                                color: Color.fromRGBO(138, 158, 184, 1),
                                size: 20,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Color.fromRGBO(138, 158, 184, 1),
                                size: 20,
                              )),
                  ),
                ),
              ),*/
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        // width: 5.0,
                        color: Color.fromRGBO(36, 124, 38, 1) ?? Colors.white,
                      ),
                      minimumSize:
                      Size.fromHeight(MediaQuery.of(context).size.height * 0.052),
                      primary:Color.fromRGBO(36, 124, 38, 1) ?? Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10 ??
                            MediaQuery.of(context).size.width * 0.02),
                      ),
                    ),
                    onPressed: () {
                      update1();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.022,
                          bottom: MediaQuery.of(context).size.height * 0.022),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
