import "package:flutter/material.dart";
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart' as intl;

import '../models/cart_check.dart';
import '../providers/cart.dart';
import '../providers/group_sadqa_provider.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import 'checkout_screen.dart';
import 'home_screen.dart';
import 'main_drawer_scree.dart';

class ViewCartScreen extends StatefulWidget {
  final Map<String, CartItem> items;

  const ViewCartScreen({Key? key, required this.items}) : super(key: key);
  @override
  State<ViewCartScreen> createState() => _ViewCartScreenState(items);
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  final Map<String, CartItem> items;
  late Map<String, CartItem> ca;
  var navigationService = locator<NavigationService>();
  // var cart = FlutterCart();
  bool isFirstClick = false;
  bool isSecondClick = false;
  List<TextEditingController>? _controllers = [];
  var total = 0.0;
  _ViewCartScreenState(this.items);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<Cart_Check> list = [];
    setState(() {
      getTotal();
    });
    return ChangeNotifierProvider(
      create: (_) => new Cart(),
      child: Consumer<Cart>(builder: (context, cart, child) {
        print(items.length);
        Future.delayed(Duration.zero, () {
          setState(() {
            cart.items = ca;
          });
        });
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(36, 124, 38, 1),
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              bottomOpacity: 0,
              title: Text(
                "View Cart",
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
              /* leading: IconButton(
                onPressed: () {
                  Navigator.pop(context,items);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: width * 0.04,
                ))*/
            ),
            body: Consumer<GroupSadkaProvider>(builder: (context, data, child) {
              return WillPopScope(
                onWillPop: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeScreen(items)));
                  return false;
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.05,
                        right: width * 0.05,
                        top: height * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        items.length == 0
                            ? Column(children: [
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Icon(
                                  Icons.shopping_cart_checkout_sharp,
                                  size: height * 0.3,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Your cart is empty",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w700),
                                ),
                              ])
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: width * 0.35,
                                    child: Text(
                                      "Items",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(
                                    "Quantity",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: width * 0.25,
                                    child: Text(
                                      "Total          ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/more-vertical.png",
                                    color: Color.fromRGBO(36, 124, 38, 1),
                                    fit: BoxFit.cover,
                                    height: height * 0.03,
                                  ),
                                ],
                              ),
                        items.length > 0
                            ? Container()
                            : SizedBox(
                                height: height * 0.008,
                              ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              _controllers!.add(new TextEditingController());
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0.0, 0, 0, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(width * 0.025)),
                                          color: Colors.white),
                                      width: width * 0.35,
                                      height: height * 0.063,
                                      child: Text(
                                        items.values
                                            .toList()[index]
                                            .title
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width * 0.035,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.19,
                                      height: height * 0.063,
                                      child:NumberInputPrefabbed.leafyButtons(
                                        textAlign: TextAlign.center,
                                        initialValue:  items.values
                                            .toList()[index]
                                            .quantity,
                                        controller: _controllers![index],
                                        incIcon: Icons.add,
                                        decIcon: Icons.remove,
                                        numberFieldDecoration: InputDecoration(

                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  width * 0.025),
                                            ),
                                            ),
                                        onIncrement: (val){
                                          items.update(
                                              items.keys.toList()[index],
                                                  (existing) => CartItem(
                                                id: items.values
                                                    .toList()[index]
                                                    .id,
                                                price: existing.price,
                                                quantity: int.parse(val.toString()),
                                                title: existing.title,
                                              ));
                                          setState(() {
                                            getTotal();
                                          });
                                        },
                                        onChanged: (val){
                                          items.update(
                                              items.keys.toList()[index],
                                                  (existing) => CartItem(
                                                id: items.values
                                                    .toList()[index]
                                                    .id,
                                                price: existing.price,
                                                quantity: int.parse(val.toString()),
                                                title: existing.title,
                                              ));
                                          setState(() {
                                            getTotal();
                                          });
                                        },
                                        onDecrement: (val){

                                            items.update(
                                                items.keys.toList()[index],
                                                    (existing) => CartItem(
                                                  id: items.values
                                                      .toList()[index]
                                                      .id,
                                                  price: existing.price,
                                                  quantity: int.parse(val.toString()),
                                                  title: existing.title,
                                                ));
                                            setState(() {
                                              getTotal();
                                            });
                                        },
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(width * 0.025)),
                                          color: Colors.white),
                                      width: width * 0.25,
                                      height: height * 0.063,
                                      child: Text(
                                        "Rs. ${items.values.toList()[index].price * items.values.toList()[index].quantity}",
                                        style: TextStyle(
                                          color: Color.fromRGBO(36, 124, 38, 1),
                                          fontSize: width * 0.035,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showGeneralDialog(
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            transitionBuilder:
                                                (context, a1, a2, widget) {
                                              return Transform.scale(
                                                scale: a1.value,
                                                child: Opacity(
                                                    opacity: a1.value,
                                                    child: AlertDialog(
                                                      title: Text(
                                                        "Please Confirm",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              width * 0.04,
                                                        ),
                                                      ),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      content: Text(
                                                        "Are you sure you want to delete?",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .red)),
                                                            onPressed: () {
                                                              setState(() {
                                                                items.remove(items
                                                                        .keys
                                                                        .toList()[
                                                                    index]);
                                                                setState(() {
                                                                  getTotal();
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              });
                                                              print('samad');
                                                            },
                                                            child: Text(
                                                              "Yes",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.03,
                                                              ),
                                                            )),
                                                        TextButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .grey)),
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child: Text(
                                                              "No",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.03,
                                                              ),
                                                            )),
                                                      ],
                                                    )),
                                              );
                                            },
                                            transitionDuration: const Duration(
                                                milliseconds: 200),
                                            barrierDismissible: false,
                                            barrierLabel: '',
                                            context: context,
                                            pageBuilder: (context, animation1,
                                                animation2) {
                                              return const Text('PAGE BUILDER');
                                            });
                                        // showCupertinoDialog(
                                        //     context: context,
                                        //     builder: (BuildContext ctx) {
                                        //       return CupertinoAlertDialog(
                                        //         title: const Text('Please Confirm'),
                                        //         content: const Text(
                                        //             'Are you sure you want to delete?'),
                                        //         actions: [
                                        //           // The "Yes" button
                                        //           CupertinoDialogAction(
                                        //             onPressed: () {
                                        //               setState(() {
                                        //                 isFirstClick = true;
                                        //                 Navigator.of(context).pop();
                                        //               });
                                        //             },
                                        //             child: const Text('Yes'),
                                        //             isDefaultAction: true,
                                        //             isDestructiveAction: true,
                                        //           ),
                                        //           // The "No" button
                                        //           CupertinoDialogAction(
                                        //             onPressed: () {
                                        //               Navigator.of(context).pop();
                                        //             },
                                        //             child: const Text('No'),
                                        //             isDefaultAction: false,
                                        //             isDestructiveAction: false,
                                        //           )
                                        //         ],
                                        //       );
                                        //     });
                                      },
                                      child: Image.asset(
                                        "assets/images/more-vertical.png",
                                        fit: BoxFit.cover,
                                        height: height * 0.03,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
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

                        /////////////////////////////////

                        isFirstClick == true && isSecondClick == true
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.08,
                                    right: width * 0.14,
                                    top: height * 0.04),
                                child: Column(
                                  children: [
                                    /*Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tranfer Fee          ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "Rs. 3,500",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),*/
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total          ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "Rs. ${total}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                        SizedBox(
                          height: height * 0.15,
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
                              if(items.length>0)
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CheckOutScreen(items: items)));
                                  
                                }
                              else
                                {
                                  Fluttertoast.showToast(msg: "Your Cart is Empty ",toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.green,textColor:Colors.white);
                                }
                              
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.022,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.022),
                              child: Text(
                                "Continue to Checkout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen(items)));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.047, bottom: height * 0.02),
                            child: Text(
                              "or continue to contribute more",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        /* isFirstClick == true && isSecondClick == true
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                navigationService.navigateTo(homeScreenRoute);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.047, bottom: height * 0.02),
                                child: Text(
                                  "or continue to contribute more",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),*/
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  getTotal(){
    total = 0.0;
    items.forEach((key, cartItem) {
      // list.add(Cart_Check(int.parse(key), cartItem.quantity));

      total += cartItem.price * cartItem.quantity;
    });
  }

  Future<Map<String, CartItem>> _navigateAndDisplaySelection3(
      BuildContext context, CartItem) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    // print(cart1.items);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainDrawerScreen(items: items)),
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

  void removeItem(String id) {
    items.remove(id);
    // notifyListeners();
  }
}
