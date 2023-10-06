import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import 'dart:convert';

class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactScrreenState();
}

class _ContactScrreenState extends State<ContactUS> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var navigationService = locator<NavigationService>();
  var first_name = "Abdul Samad",id,last_name = "Abdul Qadir",address1 = "Plot L-532",address_2= "",city= "Karachi",state = "Sindh",country = "PK",email = "abdulsamadq67@gmail.com",phone = "03323490754";
  var bank;
  bool isLoading = true;
  String username = 'abdulsamadq67@gmail.com';
  String password = 'zhdltozuirxknvji';


  Future<void> profile() async{
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('abdulsamadq67@gmail.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    print('somi');
    var headers = {
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1657826996%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
    };
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString('id');
    email = pref.getString('email')!;
    first_name = pref.getString('username')!;
    var request = http.Request('GET', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/customers?email=${pref.getString('email')}&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    print('https://sadqapakistan.org/wp-json/wc/v3/customers/${pref.getString('id')}?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      final token =  json.decode(data);
      print(token);
      setState((){
        isLoading = false;
        print(token[0]['username']);
        first_name = token[0]['first_name'];
        last_name = token[0]['billing']['last_name'];
        address1 = token[0]['billing']['address_1'];
        city = token[0]['billing']['city'];
        phone = token[0]['shipping']['phone'];
        country= token[0]['billing']['country'];
        state= token[0]['billing']['state'];
        state= token[0]['billing']['state'];
        email = token[0]['email'];
        id = token[0]['id'];
        pref.setString('id', id.toString());
        pref.setString('email', email.toString());
        print(email+"......"+first_name);
        nameController.text = first_name;
        emailController.text = email;
        phoneController.text = phone;
        // Navigator.pop(context);
      });

    }
    else {
      print(response.reasonPhrase);
    }

  }

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
    print('https://sadqapakistan.org/wp-json/wc/v3/customers/${id}');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic Y2tfNjAxYzBmOWQ4ODA3MTMwZjYxNDgzODJkMDlkY2IzMDBiNWFmN2NhMzpjc180MGYyNWM1YjY3YmI1NWVmYmExYzY0YTFhOWY0NGVmYWM4NTljOGE1',
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1658747282%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
    };
    var request = http.Request('PUT', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/customers/${id}'));
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
      Navigator.of(context).pop();
      print(response.reasonPhrase);
    }

  }

  @override
  void initState() {
    profile();

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.1,
          bottomOpacity: 0,
          title: Text(
            "Contact Us",
            style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: width * 0.035,
                )),
          )),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: EdgeInsets.only(
            left: width * 0.05, right: width * 0.05, top: height * 0.01),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Full Name",
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.035,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width,
            height: height * 0.063,
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              // textAlign: TextAlign.center,
              cursorColor: Color.fromRGBO(36, 124, 38, 1),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.035,
                  height: 2,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.035),
                  // contentPadding: EdgeInsets.all(width * 0.04),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: width * 0.035,
                  ),
                  hintText: "Full Name...",
                  fillColor: Colors.grey.shade100),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            "Email",
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.035,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width,
            height: height * 0.063,
            child: TextField(
              enabled: false,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              // textAlign: TextAlign.center,
              cursorColor: Color.fromRGBO(36, 124, 38, 1),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.035,
                  height: 2,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                // isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.035),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: width * 0.035,
                  ),
                  hintText: "Email...",
                  fillColor: Colors.grey.shade100),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            "Phone Number",
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.035,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            width: width,
            height: height * 0.063,
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              // textAlign: TextAlign.center,
              cursorColor: Color.fromRGBO(36, 124, 38, 1),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.035,
                  height: 2,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.035),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(width * 0.025),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: width * 0.035,
                  ),
                  hintText: "Phone Number...",
                  fillColor: Colors.grey.shade100),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          ElevatedButton(
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

              },
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.022,
                    bottom: MediaQuery.of(context).size.height * 0.022),
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
