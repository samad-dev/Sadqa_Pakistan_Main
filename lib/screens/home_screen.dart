import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_converter/Currency.dart';
import 'package:money_converter/money_converter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sadqapak/screens/Inividual_Product.dart';
import 'package:sadqapak/screens/main_drawer_scree.dart';
import 'package:sadqapak/screens/sadka_detail_screen.dart';
import 'package:sadqapak/screens/view_cart_screen.dart';
import 'package:sadqapak/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import '../providers/cart.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'group_sadka_detail_screen.dart';

class HomeScreen extends StatefulWidget {

  Map<String, CartItem> items;
  HomeScreen(this.items);
  @override
  State<HomeScreen> createState() => _HomeScreenState(items);
}

class _HomeScreenState extends State<HomeScreen> {
  var formatter = NumberFormat('#,##,000');
  Map<String, CartItem> items;
  var navigationService = locator<NavigationService>();
  late Future<List<Product>> products;
  late Future<List<Product>> products3;
  late Future<List<Product>> products2;
  late Future<List<Product>> products4;
  late Map<String, CartItem> ca;
  _HomeScreenState(this.items);
  String? usdToPKR;

  // var cart = FlutterCart();
  var first_name="",id="",last_name = "",address1 = "",address_2= "",city= "",state = "",country = "",email,phone;
  var bank;
  var price = 0;
  var ac_price = 0;
  String p_name = "";
  var balance = 0;
  var remaining = 0;
  var collected = 0;
  var p_id = 0;
  var size;
  double percent = 0.0;
  var user_country;
  var p = 1.0;
  var si = 'Rs. ';


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
      print(token);
      setState((){
        // print(token[0]['username']);
        first_name = token[0]['first_name'];
        phone = token[0]['shipping']['phone'];
        last_name = token[0]['billing']['last_name'];
        address1 = token[0]['billing']['address_1'];
        city = token[0]['billing']['city'];
        country= token[0]['billing']['country'];
        state= token[0]['billing']['state'];
        state= token[0]['billing']['state'];
        email = token[0]['email'];
        id = token[0]['id'];
        pref.setString('id', id.toString());
        pref.setString('email', email.toString());
        print(email+"......"+first_name);
        // print(email+"......"+phone);
        // Navigator.pop(context);
      });

    }
    else {
      print(response.reasonPhrase);
    }

  }


  static int closestInteger(int a, int b) {
    int c1 = a - (a % b);
    int c2 = (a + b) - (a % b);
    if (a - c1 > c2 - a) {
      return c2;
    } else {
      return c1;
    }
  }

  Future<List<Product>> fetchData() async {
    try {
      http.get(Uri.parse('http://ip-api.com/json')).then((value) async {
        user_country = json.decode(value.body)['country'].toString();
        print(json.decode(value.body)['country'].toString());
        if(user_country != 'Pakistan')
          {

            final response = await http.get(Uri.parse('https://free.currconv.com/api/v7/convert?q=PKR_USD&compact=ultra&apiKey=ac0bd9b4cde458c1e98e'));


            // final response = await request.send();

            if (response.statusCode == 200) {
              print(response.body);
              var jsonResponse = json.decode(response.body);
              print(jsonResponse['PKR_USD']);
              p = double.parse(jsonResponse['PKR_USD'].toString());
              si = '\$ ';
              // print(jsonResponse[0]);c
        }
        else {
        print(response.reasonPhrase);
        }

      }
      });
    } catch (err) {
      //handleError
    }
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/products?category=16&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print(response.statusCode);
      // print(response.body);
      return jsonResponse.map((data) => new Product.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Product>> QurbaniData() async {
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/products?category=24&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Product.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  Future<List<Product>> EcoData() async {
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/products?category=25&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Product.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  Future<List<Product>> GroupData() async {
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/products?category=22&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5&per_page=1'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print(jsonResponse[0]['price']);
      p_id = jsonResponse[0]['id'];
      balance = int.parse(jsonResponse[0]['price']);
      p_name = jsonResponse[0]['name'];
      price = 4 * int.parse(jsonResponse[0]['price']);
      ac_price =  int.parse(jsonResponse[0]['price']);
      size = int.parse(jsonResponse[0]['total_sales'].toString());
      var size_1 = 0;
      var num;
      // var size_1= closestNumber(size, 4);
      // // print(price.toString());
      // print(size_1);
      if(size%4 ==0)
      {
        size_1 = 0;
      }
      else
      {

        num = size/4;
        print(num);
        if(num.toString().contains('.25')){
          size_1 = 1;
          percent = 0.25;
        }

        if(num.toString().contains('.5')){
          size_1 = 2;
          percent = 0.50;
        }
        if(num.toString().contains('.75')){
          size_1 = 3;
          percent = 0.75;
        }



      }
      print(size_1);
      var collected1= size_1 * balance;
      collected = collected1;
      remaining = price - collected.toInt();
      // print(size);
      // countsa();
      return jsonResponse.map((data) => new Product.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  Future<int> countsa() async {
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/orders?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5&product=105'));
    print('https://sadqapakistan.org/wp-json/wc/v3/orders?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5&product=105');
    if (response.statusCode == 200) {

      List jsonResponse = json.decode(response.body);
      // print(jsonResponse[0]['price']);
      // print(jsonResponse[0]['line_items']);
      // Iterable l = json.decode(jsonResponse[0]['line_items'].toString());
      /*List te = jsonResponse[0]['line_items'];
      // List line_item = json.decode(jsonResponse[0]['line_items'].toString());
      print("Lenth"+te.length.toString());
      for(int i=0;i<te.length;i++){
        if(te[i]['product_id']=='105'){
          size = size+1;
          print(size)
        }
      }*/
      size = jsonResponse.length;
      var size_1 = 0;
      var num;
      // var size_1= closestNumber(size, 4);
      // // print(price.toString());
      // print(size_1);
      if(size%4 ==0)
        {
          size_1 = 0;
        }
      else
        {

          num = size/4;
          print(num);
          if(num.toString().contains('.25')){
            size_1 = 1;
            percent = 0.25;
          }

          if(num.toString().contains('.5')){
            size_1 = 2;
            percent = 0.50;
          }
          if(num.toString().contains('.75')){
            size_1 = 3;
            percent = 0.75;
          }



        }
      print(size_1);
      var collected1= size_1 * balance;
      collected = collected1;
      remaining = price - collected.toInt();

      // print(size);
      return size;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }


  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context,listen: false);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => new Cart(),
      child: Consumer<Cart>(
        builder: (context,cart,child) {
    Future.delayed(Duration.zero,(){
          setState(() { cart.items = ca;
          });
          });
          return SafeArea(
            child: Scaffold(
                backgroundColor: Color.fromRGBO(247, 185, 20, 1),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.08),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    bottomOpacity: 0,
                    automaticallyImplyLeading: false,

                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          height: height * 0.065,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),

                    actions: [
                      IconButton(
                        onPressed: () {
                          // print(cart.items);

                           _navigateAndDisplaySelection(context,cart);

                          // navigationService.navigateTo(viewCartScreenRoute);
                        },
                        icon: new Stack(
                          children: <Widget>[
                            new Image.asset(
                              "assets/images/cart.png",
                              height: height * 0.03,
                            ),
                            new Positioned(
                              right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: new Text(
                                  cart.itemCount.toString(),
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      /*IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/notification.png",
                            height: height * 0.03,
                          )),*/
                      IconButton(
                          onPressed: () {
                            _navigateAndDisplaySelection3(context, cart);
                          },
                          icon: Image.asset(
                            "assets/images/humburger.png",
                            height: height * 0.05,
                          ))
                    ],
                    // leading: IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.arrow_back_ios,
                    //       color: Colors.black,
                    //       size: width * 0.04,
                    //     ))
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.05,
                            right: width * 0.05,
                            top: height * 0.02,
                            bottom: height * 0.02),
                        child: Image.asset(
                          "assets/images/main_banner.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(36, 124, 38, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 0.12),
                              topRight: Radius.circular(width * 0.12),
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: height * 0.02,
                              bottom: height * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sadqa Options',
                                  style: TextStyle(
                                      fontSize: width * 0.042,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              FutureBuilder<List<Product>>(
                                future: products,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Product>? data = snapshot.data;

                                    return Container(
                                      width: width,
                                      height: height * 0.32,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: data?.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            // print(data![index].image[0]['src'].toString());
                                            //    var price =  getAmounts(data![index].price);
                                            return GestureDetector(
                                              onTap: () {
                                                print('samad');
                                                _navigateAndDisplaySelection2(context,cart,data![index].id);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.fromLTRB(
                                                    0, 0, 20, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(
                                                              width * 0.02))),
                                                  width: width * 0.42,
                                                  height: height * 0.32,
                                                  child: Column(children: [
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Image.network(
                                                      data![index]
                                                          .image[0]['src']
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      height: height * 0.1,
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Text(
                                                      data[index].name,
                                                      style: TextStyle(
                                                          fontSize: width * 0.035,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.green),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Text(
                                                      si + formatter.format(int.parse(data[index].price)*p),
                                                      style: TextStyle(
                                                          fontSize: width * 0.03,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.red),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.001,
                                                    ),
                                                    Html(
                                                      data: data![index].short_description,
                                                      style: {
                                                        "p": Style(
                                                          color: Colors.blueGrey,
                                                          alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(27, 0, 0, 5),
                                                          fontSize: FontSize(width * 0.027),
                                                        ),

                                                      },
                                                    ),
                                                    /*Text(
                                                      data![index].short_description,
                                                      style: TextStyle(
                                                        fontSize: width * 0.027,
                                                        color: Colors.green,
                                                      ),
                                                    ),*/
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 10),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            side: BorderSide(
                                                              // width: 5.0,
                                                              color: Color.fromRGBO(36, 124, 38, 1),
                                                            ),
                                                            primary: Color.fromRGBO(36, 124, 38, 1),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      MediaQuery.of(
                                                                                  context)
                                                                              .size
                                                                              .width *
                                                                          0.025),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            cart.addItem(data[index].id.toString(), double.parse(data[index].price), data[index].name);

                                                            // print(cart.cartItem.length);
                                                            Fluttertoast.showToast(
                                                                msg: "Product Added to Cart",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.BOTTOM,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.green,
                                                                textColor: Colors.white,
                                                                fontSize: 12.0
                                                            );
                                                          },
                                                          child: Text(
                                                            'Add to Cart',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                            ),
                                                          ),
                                                        ))
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
                                  return Center(
                                      child:
                                          Center(child: CircularProgressIndicator()));
                                },
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text('Group Sadqa Options',
                                  style: TextStyle(
                                      fontSize: width * 0.042,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(p_id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  OptionsDetailScreen(items:items, person: p_id,)),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(width * 0.01),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width * 0.02))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(36, 124, 38, 1),
                                                    fontSize: width * 0.04,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.07,
                                                ),
                                                Text(
                                                  'Collected',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(36, 124, 38, 1),
                                                    fontSize: width * 0.04,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  si +formatter.format(int.parse(
                                                      price.toString())*p),
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(36, 124, 38, 1),
                                                    fontSize: width * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.065,
                                                ),
                                                Text(
                                                  si +formatter.format(int.parse(collected.toString())*p),
                                                  style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(36, 124, 38, 1)),
                                                )
                                              ],
                                            ),
                                            // Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.spaceBetween,
                                            //     children: [
                                            //       Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment.spaceBetween,
                                            //         children: [
                                            //           Column(
                                            //             children: [
                                            //               Text(
                                            //                 'Total',
                                            //                 style: TextStyle(
                                            //                   fontSize: width * 0.04,
                                            //                   fontWeight:
                                            //                       FontWeight.bold,
                                            //                 ),
                                            //               ),
                                            //               Text(
                                            //                 'Rs. 58,500',
                                            //                 style: TextStyle(
                                            //                   fontSize: width * 0.035,
                                            //                   fontWeight:
                                            //                       FontWeight.bold,
                                            //                 ),
                                            //               )
                                            //             ],
                                            //           )
                                            //         ],
                                            //       ),
                                            //       Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment.spaceBetween,
                                            //         children: [
                                            //           Column(
                                            //             children: [
                                            //               Text(
                                            //                 'Collected',
                                            //                 style: TextStyle(
                                            //                   fontSize: width * 0.04,
                                            //                   fontWeight:
                                            //                       FontWeight.bold,
                                            //                 ),
                                            //               ),
                                            //               Text(
                                            //                 'Rs. 40,500',
                                            //                 style: TextStyle(
                                            //                     fontSize: width * 0.035,
                                            //                     fontWeight:
                                            //                         FontWeight.bold,
                                            //                     color: Theme.of(context)
                                            //                         .primaryColor),
                                            //               )
                                            //             ],
                                            //           )
                                            //         ],
                                            //       )
                                            //     ]),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            Text(
                                              'Balance',
                                              style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            Text(
                                              si+formatter.format(int.parse(remaining.toString())*p),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: width * 0.035,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: height * 0.003,
                                            ),
                                            // Text(
                                            //   'Each part is Rs 20,000',
                                            //   style: TextStyle(
                                            //       color: Colors.green,
                                            //       fontSize: width * 0.030,
                                            //       fontWeight: FontWeight.w600),
                                            // ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10, top: 10),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                      // width: 5.0,
                                                      color: Color.fromRGBO(36, 124, 38, 1),
                                                    ),
                                                    primary: Color.fromRGBO(36, 124, 38, 1),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.025),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    cart.addItem(p_id.toString(), ac_price.toDouble(), p_name);
                                                    Fluttertoast.showToast(
                                                        msg: "Product Added to Cart",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 12.0
                                                    );
                                                  },
                                                  child: Text(
                                                    'Add to Cart',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(width * 0.04),
                                          child: CircularPercentIndicator(
                                            radius: width * 0.17,
                                            lineWidth: width * 0.045,
                                            animation: true,
                                            percent: percent,
                                            startAngle: 0,
                                            center: Text(
                                              "Group\nOrder",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            // backgroundColor:
                                            // const Color.fromRGBO(255, 255, 255, 20),
                                            progressColor:
                                            Color.fromRGBO(36, 124, 38, 1),
                                            backgroundColor: Colors.grey.shade200,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Image.asset(
                                "assets/images/banner.png",
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text('Flood Relief Options',
                                  style: TextStyle(
                                      fontSize: width * 0.042,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigationService
                                      .navigateTo(sadkaDetailScreenRoute);
                                },
                                child: FutureBuilder<List<Product>>(
                                  future: products2,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Product>? data = snapshot.data;

                                      return Container(
                                        width: width,
                                        height: height * 0.32,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data?.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              // print(data![index].image[0]['src'].toString());
                                              return GestureDetector(
                                                onTap: () {
                                                  print('samad');
                                                  _navigateAndDisplaySelection2(context,cart,data![index].id);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    width * 0.02))),
                                                    width: width * 0.42,
                                                    height: height * 0.32,
                                                    child: Column(children: [
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Center(
                                                        child: Image.network(
                                                          data![index]
                                                              .image[0]['src']
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          height: height * 0.1,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Text(
                                                        data[index].name,
                                                        style: TextStyle(
                                                            fontSize: width * 0.035,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.green),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Text(
                                                          si + formatter.format(int.parse(
                                                                data[index].price)*p),
                                                        style: TextStyle(
                                                            fontSize: width * 0.03,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Html(
                                                        data: data![index].short_description,
                                                        style: {
                                                          "p": Style(
                                                            color: Colors.blueGrey,
                                                            alignment: Alignment.center,
                                                            padding: EdgeInsets.fromLTRB(27, 0, 0, 1),
                                                            fontSize: FontSize(width * 0.027),
                                                          ),

                                                        },
                                                      ),
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                              top: 10),
                                                          child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              side: BorderSide(
                                                                // width: 5.0,
                                                                color:
                                                                Color.fromRGBO(36, 124, 38, 1),
                                                              ),
                                                              primary:
                                                              Color.fromRGBO(36, 124, 38, 1),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        MediaQuery.of(
                                                                                    context)
                                                                                .size
                                                                                .width *
                                                                            0.025),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              cart.addItem(data[index].id.toString(), double.parse(data[index].price), data[index].name);
                                                              Fluttertoast.showToast(
                                                                  msg: "Product Added to Cart",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIosWeb: 1,
                                                                  backgroundColor: Colors.green,
                                                                  textColor: Colors.white,
                                                                  fontSize: 12.0
                                                              );
                                                            },
                                                            child: Text(
                                                              'Add to Cart',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.03,
                                                              ),
                                                            ),
                                                          ))
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
                                    return Center(child: CircularProgressIndicator());
                                  },
                                ),

                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text('Eco-Friendly Houses',
                                  style: TextStyle(
                                      fontSize: width * 0.042,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigationService
                                      .navigateTo(sadkaDetailScreenRoute);
                                },
                                child: FutureBuilder<List<Product>>(
                                  future: products4,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Product>? data = snapshot.data;

                                      return Container(
                                        width: width,
                                        height: height * 0.32,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data?.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              // print(data![index].image[0]['src'].toString());
                                              return GestureDetector(
                                                onTap: () {
                                                  print('samad');
                                                  _navigateAndDisplaySelection2(context,cart,data![index].id);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                width * 0.02))),
                                                    width: width * 0.42,
                                                    height: height * 0.32,
                                                    child: Column(children: [
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Image.network(
                                                        data![index]
                                                            .image[0]['src']
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                        height: height * 0.1,
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Text(
                                                        data[index].name,
                                                        style: TextStyle(
                                                            fontSize: width * 0.035,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: Colors.green),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Text(
                                                        si + formatter.format(int.parse(
                                                            data[index].price)*p),
                                                        style: TextStyle(
                                                            fontSize: width * 0.03,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Html(
                                                        data: data![index].short_description,
                                                        style: {
                                                          "p": Style(
                                                            color: Colors.blueGrey,
                                                            alignment: Alignment.center,
                                                            padding: EdgeInsets.fromLTRB(27, 0, 0, 1),
                                                            fontSize: FontSize(width * 0.027),
                                                          ),

                                                        },
                                                      ),
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                              top: 10),
                                                          child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              side: BorderSide(
                                                                // width: 5.0,
                                                                color:
                                                                Color.fromRGBO(36, 124, 38, 1),
                                                              ),
                                                              primary:
                                                              Color.fromRGBO(36, 124, 38, 1),
                                                              shape:
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .width *
                                                                        0.025),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              cart.addItem(data[index].id.toString(), double.parse(data[index].price), data[index].name);
                                                              Fluttertoast.showToast(
                                                                  msg: "Product Added to Cart",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIosWeb: 1,
                                                                  backgroundColor: Colors.green,
                                                                  textColor: Colors.white,
                                                                  fontSize: 12.0
                                                              );
                                                            },
                                                            child: Text(
                                                              'Add to Cart',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                fontSize: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.03,
                                                              ),
                                                            ),
                                                          ))
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
                                    return Center(child: CircularProgressIndicator());
                                  },
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        }
      ),
    );
  }
  Future<Map<String, CartItem>> _navigateAndDisplaySelection(BuildContext context,Cart cart1) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    print(cart1.items);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ViewCartScreen(items: cart1.items)),
    );
    ca = result;
    print(result);
  return ca;
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

  Future<Map<String, CartItem>> _navigateAndDisplaySelection2(BuildContext context,Cart cart1,int ss) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    print(cart1.items);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  Indivi(items: cart1.items,person: ss,)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.

    ca = result;
    // After the  Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    print(result);
    return ca;
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

  Future<Map<String, CartItem>> _navigateAndDisplaySelection3(BuildContext context,Cart cart1) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    print(cart1.items);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  MainDrawerScreen(items: cart1.items)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.

    ca = result;
    // After the  Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    print(result);
    return ca;
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }


  Future<Map<String, CartItem>> _navigateAndDisplaySelection4(BuildContext context,Cart cart1,int ss) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    print(cart1.items);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  OptionsDetailScreen(items: cart1.items,person: ss,)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.

    ca = result;
    // After the  Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    print(result);
    return ca;
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

  @override
  void initState() {
    products = fetchData();
    products2 = QurbaniData();
    products4 = EcoData();
    products3 = GroupData();
    // size = countsa();
    ca = items;
    profile();
  }
}
