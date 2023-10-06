import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sadqapak/screens/view_cart_screen.dart';


import '../models/product.dart';
import '../providers/cart.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import '../widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

class OptionsDetailScreen extends StatefulWidget {
  final Map<String, CartItem> items;
  final int person;
  const OptionsDetailScreen({Key? key, required this.items, required this.person}) : super(key: key);

  @override
  State<OptionsDetailScreen> createState() => _OptionsDetailScreenState(items,person);
}

class _OptionsDetailScreenState extends State<OptionsDetailScreen> {
  var navigationService = locator<NavigationService>();
  Color themeColor = const Color.fromRGBO(36, 124, 38, 1);
  late Future<List<Product>> products3;
  Map<String, CartItem> items;

  late Map<String, CartItem> ca;
  var formatter = NumberFormat('#,##,000');
  final int person;
  var price = 0;
  var ac_price = 0;
  String p_name = "";
  var balance = 0;
  var remaining = 0;
  var collected = 0.0;
  var p_id = 0;
  var size;
  late Future<Product> products;
  double percent = 0.0;

  _OptionsDetailScreenState(this.items, this.person);

  Future<Product> fetchData() async {
    print('https://sadqapakistan.org/wp-json/wc/v3/products/${this.person.toString()}?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5');
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/products/${this.person.toString()}?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final token = jsonDecode(response.body);
      print(token);
      // size = token['total_sales'];
      balance = int.parse(token['price']);
      p_name = token['name'];
      price = 4 * int.parse(token['price']);
      ac_price =  int.parse(token['price']);
      size = int.parse(token['total_sales'].toString());
      print(size);
      var size_1 = 0;
      var num;
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
      collected = collected1.toDouble();
      remaining = price - collected.toInt();
      print(jsonDecode(response.body));
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('CHECK YOUR INTERNET CONNECTION');
    }
  }



//here goes the function
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }  Future<int> countsa() async {
    final response = await http.get(Uri.parse(
        'https://sadqapakistan.org/wp-json/wc/v3/products/${person}?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));
    print('https://sadqapakistan.org/wp-json/wc/v3/products/${person}?consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5');
    if (response.statusCode == 200) {

      final jsonResponse = json.decode(response.body);
      // print(jsonResponse[0]['price']);
      p_name = jsonResponse['name'].toString();
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
      collected = collected1.toDouble();
      remaining = price - collected.toInt();

      // print(size);
      return size;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }


  @override
  void initState() {
// countsa();
products = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
        body: FutureBuilder<Product>(
          future: products,
    builder: (context, snapshot){
    if (snapshot.hasData) {
    return Padding(
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
                  child: Column(
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
                       /* Center(
                          child: Html(
                            data: snapshot.data!.short_description,
                            style: {
                              "div": Style(
                                color: Colors.blueGrey,
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(27, 0, 10, 10),
                                fontSize: FontSize(17),
                              ),
                              "#divProductDesc": Style(
                                  color: Colors.black,
                                  alignment: Alignment.center,
                                  fontSize: FontSize(20),
                                  padding: EdgeInsets.fromLTRB(
                                      width * 0.29, 0, 10, 10),
                                  fontStyle: FontStyle.normal),
                            },
                          ),
                        ),*/
                        Text(
                          _parseHtmlString(snapshot.data!.description),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.032,
                            // fontWeight: FontWeight.w700
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * 0.03),
                          child: CircularPercentIndicator(
                            radius: width * 0.15,
                            lineWidth: width * 0.045,
                            animation: true,
                            percent: percent,
                            startAngle: 0,
                            center: Text(
                              "Group\nOrder",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.033,
                                  fontWeight: FontWeight.w700),
                            ),
                            // backgroundColor:
                            // const Color.fromRGBO(255, 255, 255, 20),
                            progressColor: themeColor,
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Collected",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: height * 0.004,
                                ),
                                Text(
                                  "Rs. ${formatter.format(collected)}",
                                  style: TextStyle(
                                      color: themeColor,
                                      fontSize: width * 0.028,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width * 0.06,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Balance",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: height * 0.004,
                                ),
                                Text(
                                  "Rs. ${formatter.format(remaining)}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: width * 0.028,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.006,
                        ),
                      ]),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
                  child: Text(
                    "Your Contribution",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ButtonWidget(
                  onTap: () {},
                  borderColor: Colors.white,
                  text: "Rs. "+formatter
                      .format(int.parse(snapshot.data!.price)),
                  textColor: themeColor,
                ),
                SizedBox(
                  height: height * 0.005,
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
                      if (items.containsKey(snapshot.data!.id.toString())) {
                        items.update(
                            snapshot.data!.id.toString(),
                                (existing) => CartItem(
                              id: existing.id,
                              price: existing.price,
                              quantity: existing.quantity + 1,
                              title: existing.title,
                            ));

                        print("${snapshot.data!.name} is added to cart multiple");
                      }
                      else {
                        items.putIfAbsent(
                            snapshot.data!.id.toString(),
                                () => CartItem(
                              id: DateTime.now().toString(),
                              price: double.parse(snapshot.data!.price.toString()),
                              quantity: 1,
                              title: snapshot.data!.name.toString(),
                            ));
                        print("${snapshot.data!.name} is added to cart");
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
                    )),
              ],
            ),
          );
  }
    else
      {
        return Center(child:  CircularProgressIndicator());
      }
  },
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
