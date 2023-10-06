import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:provider/provider.dart';
import 'package:sadqapak/screens/payment_method_screen.dart';

import '../providers/cart.dart';
import '../providers/group_sadqa_provider.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
import '../widgets/dropdown_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'billing_adress_screen.dart';
import 'main_drawer_scree.dart';

class CheckOutScreen extends StatefulWidget {
  final Map<String, CartItem> items;

  const CheckOutScreen({Key? key, required this.items}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState(items);
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var navigationService = locator<NavigationService>();
   Map<String, CartItem> items;
  _CheckOutScreenState(this.items);
  var first_name,id,last_name = "",address1 = "",address_2= "",city= "",state = "",country = "",email,phone;
  var bank;
  List data2 = [];
  late Map<String, CartItem> ca;

  @override
  void didPop() {
    print('HomePage: Called didPop');
    profile();

  }
  @override
  void didPopNext() {
    print('HomePage: Called didPopNext');
    profile();
  }
  TextEditingController sp_i = new TextEditingController();
  Future<void> profile() async{

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
      data2 = json.decode(data);
      print(token);

      setState((){
        if(data2.length>0)
          {
            print(token[0]['username']);
            first_name = token[0]['first_name'];
            phone = token[0]['shipping']['phone'];
            last_name = token[0]['billing']['last_name'];
            address1 = token[0]['billing']['address_1'];
            address_2 = token[0]['billing']['address_2'];
            city = token[0]['billing']['city'];
            country= token[0]['billing']['country'];
            state= token[0]['billing']['state'];
            // state= token[0]['billing']['state'];
            // email = token[0]['email'];
            id = token[0]['id'];
            pref.setString('id', id.toString());
            pref.setString('email', email.toString());
            print(email+"......"+first_name);
          }
        else
          {
            email = pref.getString('email');
          }

        // print(email+"......"+phone);
        // Navigator.pop(context);
      });

    }
    else {
      print(response.reasonPhrase);
    }

  }
  var permissionList = [
    'Yes',
    'No',
  ];
  var periodlist = [
    '7 Days',
    '15 Days',
    '30 Days',
    'No',
  ];
  String? mediaPermissionValue;
  String? zakatPermissionValue;
  String? sadkaPermissionValue;


  @override
  void initState() {
    profile();
  }

  @override
  Widget build(BuildContext context) {
    profile();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
   /* Future.delayed(Duration.zero,(){
      setState(() {
        items = ca;

      });
    });*/
    var total = 0.0;
    items.forEach((key, cartItem) {
      total = total + cartItem.price * cartItem.quantity;

    });
    // print(jsonEncode(items));
    if(email!= null)
      {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Color.fromRGBO(36, 124, 38, 1),
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  elevation: 0,
                  bottomOpacity: 0,
                  title: Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w700),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          _navigateAndDisplaySelection3(context, items);
                        },
                        icon: Image.asset(
                          "assets/images/humburger.png",
                          height: height * 0.05,
                        ))
                  ],
                  leading: Padding(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context,items);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: width * 0.035,
                        )),
                  )),
              body: Consumer<GroupSadkaProvider>(builder: (context, data, child) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigationService.navigateTo(contactInfoScreenRoute);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.09,
                              top: height * 0.005),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contact Information",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: height * 0.006,
                              bottom: height * 0.02),
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              bottom: height * 0.013,
                              top: height * 0.013),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(width * 0.02))),
                          width: width,
                          // height: height * 0.063,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                first_name.toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.035,
                                ),
                              ),
                              Text(
                                "${email.toString()}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.035,
                                ),
                              ),
                              Text(
                                "${phone.toString()}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.035,
                                ),
                              )
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.09,
                          left: width * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Billing Address",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  BillingAddressScreen()),
                                );
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: height * 0.006,
                              bottom: height * 0.012),
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              bottom: height * 0.013,
                              top: height * 0.013),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(width * 0.02))),
                          width: width,
                          // height: height * 0.063,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${address1.toString()},${address_2.toString()}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.035,
                                ),
                              ),

                              Text(
                                "${city.toString()}, ${state.toString()}, ${country.toString()}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.035,
                                ),
                              ),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(
                            right: width * 0.055,
                            left: width * 0.055,
                            top: height * 0.02,
                            bottom: height * 0.02),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(247, 185, 20, 1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.12),
                                topRight: Radius.circular(width * 0.12))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Summary",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: width * 0.035,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index) =>
                                  Container(
                                      margin: EdgeInsets.only(
                                        // left: width * 0.05,
                                        // right: width * 0.05,
                                          top: height * 0.006,
                                          bottom: height * 0.012),
                                      padding: EdgeInsets.only(
                                          left: width * 0.05,
                                          right: width * 0.03,
                                          bottom: height * 0.013,
                                          top: height * 0.013),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(width * 0.02))),
                                      width: width,
                                      // height: height * 0.063,
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  items.values.toList()[index].title.toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  "Rs.${items.values.toList()[index].price} x ${items.values.toList()[index].quantity}",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.035,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Rs. ${items.values.toList()[index].price * items.values.toList()[index].quantity}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(36, 124, 38, 1),
                                                  fontSize: width * 0.035,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ])),
                              /*ListTile(
                           leading: const Icon(Icons.done),
                           trailing: IconButton(
                             icon: const Icon(Icons.remove_circle_outline),
                             onPressed: () {
                               cartProvider.decrementItemFromCartProvider(index);
                             },
                           ),
                           title: Text(
                             cartProvider.flutterCart.cartItem[index].productName.toString(),
                             style: itemNameStyle,
                           ),
                         ),*/
                            ),

                            Container(
                                margin: EdgeInsets.only(
                                  // left: width * 0.05,
                                  // right: width * 0.05,
                                  // top: height * 0.006,
                                    bottom: height * 0.012),
                                padding: EdgeInsets.only(
                                    left: width * 0.05,
                                    right: width * 0.03,
                                    bottom: height * 0.02,
                                    top: height * 0.02),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(36, 124, 38, 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(width * 0.02))),
                                width: width,
                                // height: height * 0.063,
                                child: Column(
                                  children: [
                                    // Text(
                                    //   "*Applied Only if your payment method is zelle or paypal",
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: width * 0.035,
                                    //   ),
                                    // ),
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Transfer Fee",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.035,
                                            ),
                                          ),
                                          Text(
                                            "Rs. ${3500}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.035,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.035,
                                            ),
                                          ),
                                          Text(
                                            "Rs. ${total+3500}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.035,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ],
                                )),
                            DropDownWidget(
                              dropdownHeight: height * 0.2,
                              itemHeight: height * 0.05,
                              dropDownStyle: TextStyle(
                                color:Color.fromRGBO(36, 124, 38, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.03,
                                overflow: TextOverflow.ellipsis,
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: height * 0.035,
                              iconDisabledColor: Colors.grey,
                              iconEnabledColor: Colors.grey,
                              dropdownDecoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width * 0.02))),
                              buttonDecoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width * 0.02))),
                              buttonHeight: height * 0.07,
                              buttonPadding: EdgeInsets.only(
                                  top: height * 0.008,
                                  bottom: height * 0.008,
                                  left: height * 0.025,
                                  right: height * 0.005),
                              buttonWidth: width,
                              dropdownWidth: width * 0.9,
                              dropdownItems: permissionList,
                              value: mediaPermissionValue,
                              onChanged: (value) {
                                setState(() {
                                  mediaPermissionValue = value;
                                  // print(mediaPermissionValue);
                                });
                              },
                              hint: Text(
                                "Do you want to receive photos/vidoes \nof meet distribution ?",
                                style: TextStyle(
                                    height: width > 600 ? 1.1 : 1.5,
                                    color: Colors.black,
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.012,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropDownWidget(
                                  dropdownHeight: height * 0.2,
                                  itemHeight: height * 0.05,
                                  dropDownStyle: TextStyle(
                                    color:Color.fromRGBO(36, 124, 38, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.03,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: height * 0.035,
                                  iconDisabledColor: Colors.grey,
                                  iconEnabledColor: Colors.grey,
                                  dropdownDecoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width * 0.02))),
                                  buttonDecoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width * 0.02))),
                                  buttonHeight: height * 0.07,
                                  buttonPadding: EdgeInsets.only(
                                      top: height * 0.008,
                                      bottom: height * 0.008,
                                      left: height * 0.025,
                                      right: height * 0.005),
                                  buttonWidth: width * 0.435,
                                  dropdownWidth: width * 0.435,
                                  dropdownItems: permissionList,
                                  value: zakatPermissionValue,
                                  onChanged: (value) {
                                    setState(() {
                                      zakatPermissionValue = value;
                                      // print(zakatPermissionValue);
                                    });
                                  },
                                  hint: Text(
                                    "Is this ZAKAT ?",
                                    style: TextStyle(
                                        height: 1,
                                        color: Colors.black,
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DropDownWidget(
                                  dropdownHeight: height * 0.2,
                                  itemHeight: height * 0.05,
                                  dropDownStyle: TextStyle(
                                    color:Color.fromRGBO(36, 124, 38, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.03,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: height * 0.035,
                                  iconDisabledColor: Colors.grey,
                                  iconEnabledColor: Colors.grey,
                                  dropdownDecoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width * 0.02))),
                                  buttonDecoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width * 0.02))),
                                  buttonHeight: height * 0.08,
                                  buttonPadding: EdgeInsets.only(
                                      top: height * 0.008,
                                      bottom: height * 0.008,
                                      left: height * 0.025,
                                      right: height * 0.005),
                                  buttonWidth: width * 0.435,
                                  dropdownWidth: width * 0.435,
                                  dropdownItems: periodlist,
                                  value: sadkaPermissionValue,
                                  onChanged: (value) {
                                    setState(() {
                                      sadkaPermissionValue = value;
                                      print(sadkaPermissionValue);
                                    });
                                  },
                                  hint: Text(
                                    "Do you perform \nSadqa Regularly?",
                                    style: TextStyle(
                                        height:  1,
                                        color: Colors.black,
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.012,
                            ),
                            SizedBox(
                              width: width,
                              height: height * 0.063,
                              child: TextField(
                                keyboardType: TextInputType.name,
                                // textAlign: TextAlign.center,
                                controller: sp_i,
                                cursorColor: Color.fromRGBO(36, 124, 38, 1),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.035,
                                  height: 2,
                                  // fontWeight: FontWeight.bold
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: height * 0.04,
                                        horizontal: width * 0.05),
                                    // contentPadding: EdgeInsets.all(width * 0.04),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: width * 0.035,
                                    ),
                                    hintText: "Special Instructions (Optional)",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: width * 0.05,
                          top: height * 0.04,
                          bottom: height * 0.03,
                        ),
                        child: ElevatedButton(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  PaymentMethodScreen(sadka: sadkaPermissionValue.toString(),zakat: zakatPermissionValue.toString(),video: mediaPermissionValue.toString(), items: items,sp_i: sp_i.text.toString(),)),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.022,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.022),
                              child: Text(
                                "Proceed to Pay",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      }
    else
      {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Color.fromRGBO(36, 124, 38, 1),
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  elevation: 0,
                  bottomOpacity: 0,
                  title: Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w700),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/humburger.png",
                          height: height * 0.05,
                        ))
                  ],
                  leading: Padding(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context,items);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: width * 0.035,
                        )),
                  )),
              body: Center(child: CircularProgressIndicator())
            ),
          ),
        );
      }

  }

  Future<Map<String, CartItem>> _navigateAndDisplaySelection3(BuildContext context,Map<String, CartItem> cart1) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    // print(cart1);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  MainDrawerScreen(items: cart1)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.

    ca = result;
    // After the  Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // print(result);

    return ca;
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

}
