import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sadqapak/screens/view_cart_screen.dart';

import '../models/product.dart';
import '../providers/cart.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class Indivi extends StatefulWidget {
  final int person;
  final Map<String, CartItem> items;

  Indivi({Key? key, required this.person, required this.items})
      : super(key: key);

  @override
  State<Indivi> createState() => _Indivi(person, items);
}

class _Indivi extends State<Indivi> {
  final int sa;
  late Map<String, CartItem> ca;
  var navigationService = locator<NavigationService>();
  Color themeColor = const Color.fromRGBO(36, 124, 38, 1);
  late Future<Product> products;
  Map<String, CartItem> items;
  late Map<String, CartItem> items1;
  // var cart = new Cart();
  // var cart = FlutterCart();
  Future<Product> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/products/' +
            this.sa.toString() +
            '?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('CHECK YOUR INTERNET CONNECTION');
    }
  }

  @override
  void initState() {
    products = fetchData();
  }

  _Indivi(this.sa, this.items);
  var formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {
    print(this.sa);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int? product_id, quantity, unit_price;
    String? product_name;
    Future.delayed(Duration.zero, () {
      setState(() {
        items = ca;
      });
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        appBar: AppBar(
            // toolbarHeight: 0,
            // systemOverlayStyle: const SystemUiOverlayStyle(
            //   // Status bar color
            //   statusBarColor: Colors.transparent,

            //   // Status bar brightness (optional)
            //   statusBarIconBrightness:
            //       Brightness.dark, // For Android (dark icons)
            //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
            // ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            bottomOpacity: 0,
            title: Text(
              "Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w700),
            ),
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
        body: Padding(
          padding: EdgeInsets.only(
              left: width * 0.05, right: width * 0.05, top: height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * 0.02)),
                    color: Colors.white),
                width: width,
                child: FutureBuilder<Product>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      product_id = int.parse(snapshot.data!.id.toString());
                      unit_price = int.parse(snapshot.data!.price.toString());
                      product_name = snapshot.data!.name.toString();

                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.1),
                              child: Image.network(
                                snapshot.data!.image[0]['src'].toString(),
                                fit: BoxFit.cover,
                                height: height * 0.18,
                                // width: width * 0.2,
                              ),
                            ),
                            Text(
                              snapshot.data!.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.007, bottom: height * 0.01),
                              child: Text(
                                "Rs. "+formatter
                                    .format(int.parse(snapshot.data!.price)),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Center(
                              child: Html(
                                data: snapshot.data!.description,
                                style: {
                                  "p": Style(
                                    color: Colors.blueGrey,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.fromLTRB(27, 0, 0, 1),
                                    fontSize: FontSize(width * 0.027),
                                  ),

                                },
                              ),
                            ),
                            /*Text(
                        "Fees around 110 families",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "Great value for money",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),*/
                            SizedBox(
                              height: height * 0.05,
                            ),
                          ]);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator(color: Colors.green,),);
                  },
                ),
                /*Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.1),
                        child: Image.asset(
                          "assets/images/buffalo.png",
                          fit: BoxFit.cover,
                          height: height * 0.18,
                          // width: width * 0.2,
                        ),
                      ),
                      Text(
                        "Medium Katta",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.007, bottom: height * 0.01),
                        child: Text(
                          "Rs. 58,500",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "70-85 kg meat",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "Fees around 110 families",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "Great value for money",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                    ]),*/
              ),
              SizedBox(
                height: height * 0.05,
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
                    if (items.containsKey(product_id.toString())) {
                      items.update(
                          product_id.toString(),
                          (existing) => CartItem(
                                id: existing.id,
                                price: existing.price,
                                quantity: existing.quantity + 1,
                                title: existing.title,
                              ));

                      print("$product_name is added to cart multiple");
                    }
                    else {
                      items.putIfAbsent(
                          product_id.toString(),
                          () => CartItem(
                                id: DateTime.now().toString(),
                                price: double.parse(unit_price.toString()),
                                quantity: 1,
                                title: product_name.toString(),
                              ));
                      print("$product_name is added to cart");
                    }
                    // items.addItem(product_id.toString(), double.parse(unit_price.toString()), product_name.toString());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewCartScreen(items: items)));
                    _navigateAndDisplaySelection2(context, items);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.022,
                        bottom: MediaQuery.of(context).size.height * 0.022),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                  ))

              // ButtonWidget(
              //   onTap: () {
              //     navigationService.navigateTo(viewCartScreenRoute);
              //   },
              //   borderColor: const Color.fromRGBO(247, 185, 20, 1),
              //   text: "Add to Cart",
              //   textColor: Colors.white,
              //   buttonColor: const Color.fromRGBO(247, 185, 20, 1),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, CartItem>> _navigateAndDisplaySelection2(
      BuildContext context, Map<String, CartItem> cart1) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    print(cart1);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewCartScreen(items: cart1)),
    );
    ca = result;
    print(result);
    return ca;
  }
}
