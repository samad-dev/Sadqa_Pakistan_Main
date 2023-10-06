import 'package:flutter/material.dart';
import 'package:sadqapak/models/customer_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/customer_order.dart';
import '../screens/my_order_detail_screen.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  var navigationService = locator<NavigationService>();

  late Future<List<Order>> orders;

  Future<List<Order>> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/orders/?customer=${pref.getString('id')}&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(response.statusCode);
      print(response.body);
      return jsonResponse.map((data) => new Order.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(orders.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.2,
          bottomOpacity: 0,
          title: Text(
            "My Orders",
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
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.05, right: width * 0.05, top: height * 0.01),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FutureBuilder<List<Order>>(
            future: orders,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Order>? data = snapshot.data;

                return Container(
                  width: width,
                  height: height-110,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("Hamza Order");
                        print(data![index].id.toString());
                        DateTime parseDate =
                        new DateFormat("yyyy-MM-dd'T'HH:mm").parse(data[index].date.toString());
                        return GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width * 0.02))),
                              width: width * 0.42,
                              height: height * 0.32,
                              child: Column(children: [
                                Row(
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
                                          " "+data[index].id.toString(),
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
                                      " "+parseDate.toString() ,
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
                                      // " Rs "+data[index].amount.toString()+" for 1 item",
                                      " Rs "+data[index].amount.toString()+"",
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
                                      " "+data[index].payment_method.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: height * 0.01,
                                // ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Payment Status:",
                                //       style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: width * 0.035,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //     Text(
                                //       " "+data[index].order_status.toString(),
                                //       style: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: width * 0.035,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                /*Row(
                                  children: [
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
                                          " "+data[index].meta_data[5]['value'].toString(),
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

                                  ],
                                ),*/
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
                                      " "+data[index].order_status.toString(),
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
                                Container(
                                  height: height * 0.05,
                                  // color: Color.fromRGBO(36, 124, 38, 1),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(36, 124, 38, 1),
                                      border: Border.all(
                                        color: Color.fromRGBO(36, 124, 38, 1),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextButton(
                                      onPressed: () {
                                        // navigationService.navigateTo(
                                        //     myOrderDetailScreenRoute);

                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) =>
                                                  MyOrderDetailScreen(person: data[index].id,)),
                                        );


                                      },
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              ]),
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return Center(child: Center(child: CircularProgressIndicator()));
            },
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

  @override
  void initState() {
    orders = fetchData();
  }
}
