import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sadqapak/models/cart_check.dart';
import 'package:sadqapak/screens/checkout_screen.dart';
import 'package:sadqapak/screens/jazakAllah_screen.dart';
import 'package:sadqapak/utils/routes.dart';
import 'package:sadqapak/utils/service_locator.dart';
import 'package:sadqapak/widgets/payment_method_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_detail_model.dart';
import '../providers/cart.dart';
import '../services/navigation_service.dart';
import 'PaypalPayment.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key, required this.sadka, required this.zakat, required this.video, required this.items, required this.sp_i}) : super(key: key);
  final String sadka,zakat,video,sp_i;
  final Map<String, CartItem> items;
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState(sadka,zakat,video,items,sp_i);
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  var navigationService = locator<NavigationService>();
  final String sadka,zakat,video,sp_i;
  final Map<String, CartItem> items;
  Color themeColor = const Color.fromRGBO(36, 124, 38, 1);
  late String jsonTags;
  late var b;
  List<Cart_Check> list = [];
  String json2 = "";
  String tagId = '';
  double total = 0.0;
  double shipping = 0.0;
  var cart = FlutterCart();
  var first_name = "Abdul Samad",id,last_name = "Abdul Qadir",address1 = "Plot L-532",address_2= "",postcode,city= "Karachi",state = "Sindh",country = "PK",email = "abdulsamadq67@gmail.com",phone = " ";
  var bank;

  _PaymentMethodScreenState(this.sadka, this.zakat, this.video, this.items, this.sp_i);
  void active(String val) {

    setState(() {
      tagId = val;
      if(tagId == "2")
        {
          bank = 'Zelle Bank';
          shipping = 3500.0;
        }
      else
        {
          bank = 'Habib Metro Bank';
          //print(bank);
          shipping = 0.0;
        }
    });
    //print("Samad1_____"+tagId);
  }

  @override
  void initState() {
    profile();
    items.forEach((key, cartItem) {
      // //print(i);
      if(list.contains(key))
      {

      }
      else
      {
        total = total + cartItem.price * cartItem.quantity;
        list.add(Cart_Check(int.parse(key),cartItem.quantity ));
      }

      // i++;
    });
  }

  Future<void> profile() async{

    //print('somi');
    var headers = {
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1657826996%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
    };
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString('id');
    email = pref.getString('email')!;
    first_name = pref.getString('username')!;
    var request = http.Request('GET', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/customers?email=${pref.getString('email')}&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
  //print('https://sadqapakistan.org/wp-json/wc/v3/customers/${pref.getString('id')}?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      final token =  json.decode(data);
      //print(token);
      //print(token[0]['username']);
      first_name = token[0]['billing']['first_name'];
      last_name = token[0]['billing']['last_name'];
      address1 = token[0]['billing']['address_1'];
      city = token[0]['billing']['city'];
      country= token[0]['billing']['country'];
      state= token[0]['billing']['state'];
      state= token[0]['billing']['state'];
      postcode= token[0]['billing']['postcode'];
      email = token[0]['email'];
      if(token[0]['phone'] == null)
        {
          phone = "000";
        }
      else
        {
          phone = token[0]['phone'];
        }

      //print(email+"......"+first_name);

    }
    else {
      //print(response.reasonPhrase);
    }

  }

  Future<void> order() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
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
    //print("Hamza");
    //print(b.toString());
    String samad = b.toString();
    // //print(json.encode(samad));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic Y2tfNjAxYzBmOWQ4ODA3MTMwZjYxNDgzODJkMDlkY2IzMDBiNWFmN2NhMzpjc180MGYyNWM1YjY3YmI1NWVmYmExYzY0YTFhOWY0NGVmYWM4NTljOGE1',
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1657738334%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
    };
    var request = http.Request('POST', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/orders'));
    request.body = json.encode({
      "payment_method": bank,
      "payment_method_title": bank,
      "set_paid": false,
      "customer_id":pref.getString('id'),
      "meta_data": [{
        "key": "zakat",
        "value": zakat
      },

        {
          "key": "recieve_pictures",
          "value": video
        },

        {
          "key": "sadka_period",
          "value": sadka
        },
        {
          "key": "sp_i",
          "value": sp_i
        },
        {
          "key": "reciept_number",
          "value": "null"
        },{
          "key": "payment_status",
          "value": "unpaid"
        },
      ],
      "billing": {
        "first_name": first_name,
        "last_name": last_name,
        "address_1": address1,
        "address_2": "",
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email,
        "phone": phone
      },
      "shipping": {
        "first_name": first_name,
        "last_name": last_name,
        "address_1": address1,
        "address_2": "",
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
      },
      "line_items": list.toSet().toList(),
      "shipping_lines": [
        {
          "method_id": "flat_rate",
          "method_title": "Flat Rate",
          "total": "${shipping}",
        }
      ]
    });
    //print(request.body.toString());
    request.headers.addAll(headers);
    String order_id = "";
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      // //print();
      final token =  json.decode(await response.stream.bytesToString());
      //print(token);
      //print(token['id']);
      order_id = token['id'].toString();
      Fluttertoast.showToast(
          msg: "Order Created Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 12.0
      );
      cart.deleteAllCart();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  JazakAllahScreen(id: order_id.toString(),text: tagId,)),
      );
    }
    else {
      print("Samad"+response.statusCode.toString());
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Order Not Created Please Try Again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 12.0
      );
      //print(response.statusCode);
    }



    // navigationService.navigateTo(jazakAllahScreenRoute);

  }

  List paymentMethod = [
    // {
    //   'title': 'Credit/Debit Card (Payfast)',
    //   'icon': 'assets/images/paypal.png',
    //   'id': '1'
    // },
    {
      'title': 'Zelle (Bank to Bank transfer to USA)',
      'icon': 'assets/images/zelle.png',
      'id': '2'
    },
    {
      'title': 'Bank Deposit (For Donors in Pakistan)',
      'icon': 'assets/images/habibmetro.png',
      'id': '3'
    },
    {
      'title': 'Paypal (For Donors outside Pakistan)',
      'icon': 'assets/images/paypal.png',
      'id': '4'
    },
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
     jsonTags = jsonEncode(items);


    //print('lenfth'+list.length.toString());
     b = json.decode(jsonTags);
     // //print(jsonEncode(list));
     // json2 = b.toString();
     // //print("Samad"+jsonTags);


    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          bottomOpacity: 0,
          title: Text(
            "Payment",
            style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700),
          ),
          /*actions: [
            IconButton(
                onPressed: () {
                },
                icon: Image.asset(
                  "assets/images/humburger.png",
                  height: height * 0.05,
                ))
          ],*/
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: width * 0.04,
              ))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              itemCount: paymentMethod.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return PaymentMethodWidget(
                  data: paymentMethod[index],
                  action: active,
                  tag: paymentMethod[index]['id'],
                  active: tagId == paymentMethod[index]['id'] ? true : false,
                );
              },
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    // width: 5.0,
                    color: Colors.white,
                  ),
                  minimumSize: Size.fromHeight(
                      MediaQuery.of(context).size.height * 0.052),
                  primary: const Color.fromRGBO(247, 185, 20, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.02),
                  ),
                ),
                onPressed: () {
                  //print("Samad "+tagId+" samad");
                  if(tagId == '')
                    {
                      Fluttertoast.showToast(msg: 'Please Select Payment Method',toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.green,textColor: Colors.white);
                    }
                  else{
                    if(tagId == '4'){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => PaypalPayment(
                            onFinish: (number) async {

                              // payment done
                              //print('order id: '+number);

                            },
                          ),
                        ),
                      );

                    }
                    else
                    {
                      order();
                    }
                  }

                  // //print("Smoi"+list.toSet().toList().length.toString());
                  // Set<Cart_Check> set = new Set<Cart_Check>.from(list);

                  // navigationService.navigateTo(jazakAllahScreenRoute);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.022,
                      bottom: MediaQuery.of(context).size.height * 0.022),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
