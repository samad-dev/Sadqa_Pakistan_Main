import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../widgets/button_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailcontroller = TextEditingController();
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
    var request = http.Request('GET', Uri.parse('https://sadqapakistan.org/api/forgetpassword.php?login='+emailcontroller.text.toString()+''));

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 250, 1),
        elevation: 0,
        leading: IconButton(

          color: Colors.black,
           icon: Icon(
          Icons.arrow_back_ios_new,
             size: 20,
        ), onPressed: () {
            Navigator.pop(context);
        },
        ),
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width / 1.3,
                child: RichText(
                  text: TextSpan(
                    text: 'Lost your password? ',
                    style: TextStyle(
                        color: Color.fromRGBO(36, 124, 38, 1),
                        fontSize: 16,
                        letterSpacing: 0.45,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Please enter your email address. You will receive a link to create a new password via email',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: Text(
                  "Email",
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
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: emailcontroller,
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
                    hintText: "Email Address",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        // width: 5.0,
                        color: Theme.of(context).primaryColor ?? Colors.white,
                      ),
                      minimumSize:
                      Size.fromHeight(MediaQuery.of(context).size.height * 0.052),
                      primary:Theme.of(context).primaryColor ?? Colors.white,
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
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Password has been sent",
                      style: TextStyle(
                        color: Color.fromRGBO(36, 124, 38, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
