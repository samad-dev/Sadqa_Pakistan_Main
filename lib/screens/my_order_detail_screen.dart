import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/customer_order.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';


import 'dart:convert';

class MyOrderDetailScreen extends StatefulWidget {
  // const MyOrderDetailScreen({Key? key}) : super(key: key);
  final person;
  const MyOrderDetailScreen({Key? key, required this.person}) : super(key: key);
  @override
  State<MyOrderDetailScreen> createState() => _MyOrderDetailScreenState(person);
}

class _MyOrderDetailScreenState extends State<MyOrderDetailScreen> {
  //  int order_id=82;
  final int sa;
  String nn ="null";
  var navigationService = locator<NavigationService>();
  TextEditingController tx = new TextEditingController();
  late Future<Order> products;
  late File _imageFile;
   PlatformFile? pickedfile;
  late String downloadlink;
  late String orderId;
  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future selectfile() async{
    final result  = await FilePicker.platform.pickFiles();
    if(result == null)  return;
    setState(() {

    });

  }

  Future pickImage() async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final _firebaseStorage = FirebaseStorage.instance;
    setState(() {
      _imageFile = File(pickedFile!.path);
      print("Somi___"+_imageFile.path);

    });
    var snapshot = await _firebaseStorage.ref()
        .child('images/imageName')
        .putFile(_imageFile);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    downloadlink= downloadUrl;
    update_order2(this.sa.toString());

  }


  Future<Order> fetchData() async {

    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/orders/' +
            this.sa.toString() +
            '?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return Order.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('CHECK YOUR INTERNET CONNECTION');
    }
  }

  update_order2(String id) async {

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic Y2tfNjAxYzBmOWQ4ODA3MTMwZjYxNDgzODJkMDlkY2IzMDBiNWFmN2NhMzpjc180MGYyNWM1YjY3YmI1NWVmYmExYzY0YTFhOWY0NGVmYWM4NTljOGE1',
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1664636113%7D'
    };
    var request = http.Request('PUT', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/orders/${id}'));
    request.body = json.encode({
      "meta_data": [
        {
          "key": "reciept_image",
          "value": downloadlink.toString()
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Reciept Image Added Successfully');
    }
    else {
      print(response.reasonPhrase);
    }

  }
  update_order(String id,BuildContext context) async {

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic Y2tfNjAxYzBmOWQ4ODA3MTMwZjYxNDgzODJkMDlkY2IzMDBiNWFmN2NhMzpjc180MGYyNWM1YjY3YmI1NWVmYmExYzY0YTFhOWY0NGVmYWM4NTljOGE1',
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1664636113%7D'
    };
    var request = http.Request('PUT', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/orders/${id}'));
    request.body = json.encode({
      "meta_data": [
        {
          "key": "reciept_number",
          "value": tx.text.toString()
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Reciept Number Added Successfully');
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future<void> openOnBrowser(String url) async {
    if (!await launch(url)) {
      // Log to error monitor (crashlytics and sentry) generic error saying 'Link has not launched for url($url)'
    }
  }

  @override
  void initState() {
    products = fetchData();
  }

  _MyOrderDetailScreenState(this.sa);

  @override
  Widget build(BuildContext context) {
    print(this.sa);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.2,
          bottomOpacity: 0,
          title: Text(
            "Order Details",
            style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: width * 0.035,
                )),
          )),
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.05, right: width * 0.05, top: height * 0.01),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FutureBuilder<Order>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data!.meta_data.toString());
                print("Samad "+snapshot.data!.meta_data[4]['value']);

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order ID:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " " + snapshot.data!.id.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Order Date:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " " + snapshot.data!.date.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Order Amount:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data!.amount,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment Method:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " " + snapshot.data!.payment_method.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment Status:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " " + snapshot.data!.meta_data[5]['value'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Order Status:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " " + snapshot.data!.order_status.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      if(snapshot.data!.meta_data[1]['value'].toString() != 'No' )...[
                        if(snapshot.data!.meta_data[1]['value'].toString() != 'null')...[
                          RichText(
                            text: TextSpan(
                              text:
                              "Do you want to receive photos of meat distribution: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [

                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var url =
                              snapshot.data!.meta_data[1]['value'].toString();
                              await launchUrl(Uri.parse(url));
                            },
                            child: Text(
                              "Click here to view photos",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],

                      ],

                      SizedBox(
                        height: height * 0.01,
                      ),
                      Wrap(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Do you want to do Sadqa regularly: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: snapshot.data!.meta_data[2]['value']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      if(snapshot.data!.meta_data[0]['value'].toString() == 'Yes')...[
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Wrap(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Is this Zakat: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: snapshot.data!.meta_data[0]['value']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      ],
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Wrap(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Special Instructions: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: snapshot.data!.meta_data[3]['value']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Wrap(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Receipt Number: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: snapshot.data!.meta_data[4]['value'].toString() !="null"? snapshot.data!.meta_data[4]['value'].toString():"Reciept Not Found",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.3,
                      ),

                      Container(
                        height: height * 0.05,
                        // color: Color.fromRGBO(36, 124, 38, 1),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(36, 124, 38, 1),
                            border: Border.all(
                              color: Color.fromRGBO(36, 124, 38, 1),
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "   Total",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rs. " +
                                  snapshot.data!.amount.toString() +
                                  "    ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                        ElevatedButton(
                          child: Text('Add/Edit Reciept Number',style: TextStyle(color: Colors.white,fontSize: 16),),
                          onPressed: () {
                            showGeneralDialog(
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionBuilder: (context, a1, a2, widget) {
                                  return Transform.scale(
                                    scale: a1.value,
                                    child: Opacity(
                                        opacity: a1.value,
                                        child: AlertDialog(
                                          title: TextField(
                                            controller: tx,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Enter Receipt Number',
                                              hintText: 'Enter Receipt Number',
                                            ),
                                          ),
                                          actionsAlignment:
                                          MainAxisAlignment.spaceAround,
                                          actions: <Widget>[
                                            TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty
                                                        .all(
                                                        Colors.grey)),
                                                onPressed: () {

                                                  update_order(snapshot.data!.id.toString(),context);
                                                },
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Nunito',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.03,
                                                  ),
                                                )),
                                          ],
                                        )),
                                  );
                                },
                                transitionDuration:
                                const Duration(milliseconds: 200),
                                barrierDismissible: false,
                                barrierLabel: '',
                                context: context,
                                pageBuilder:
                                    (context, animation1, animation2) {
                                  return const Text('PAGE BUILDER');
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: pickImage,
                      ),

                    ]);
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return Center(child: Center(child: CircularProgressIndicator()));
            },
          ),

          SizedBox(
            height: height * 0.01,
          ),

          // SizedBox(
          //   width: width * 0.2,
          //   height: height * 0.08,
          //   child: ButtonWidget(
          //     onTap: () {},
          //     text: "Save",
          //     textColor: Colors.white,
          //     buttonColor: Color.fromRGBO(36, 124, 38, 1),
          //     borderColor: Color.fromRGBO(36, 124, 38, 1),
          //   ),
          // )
        ]),
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.white],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: ElevatedButton(
              onPressed: () => {

              },
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}