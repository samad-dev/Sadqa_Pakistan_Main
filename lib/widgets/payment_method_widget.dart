import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/PaypalPayment.dart';

class PaymentMethodWidget extends StatefulWidget {
  final data;
  bool? active;
  ValueChanged<String>? action;
  final String? tag;

  PaymentMethodWidget({Key? key, this.action, this.active, this.data, this.tag})
      : super(key: key);

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  void handleTap() {
    print(widget.data['id']);
    if(widget.data['id']=='2'){
      /*showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    title: Text(
                      "Zelle (Bank to Bank transfer to USA)",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    actionsAlignment:
                    MainAxisAlignment.spaceAround,
                    content: Text(
                      "Subscribers in the United States can use the ZELLE service to transfer funds at email sadqapakistan@gmail.com. "
                          "Please ensure that cart invoice is in USD and NOT in PKR.",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context)
                            .size
                            .width *
                            0.03,
                      ),
                    ),
                    actions: <Widget>[
                      // TextButton(
                      //     style: ButtonStyle(
                      //         backgroundColor:
                      //         MaterialStateProperty
                      //             .all(Colors.red)),
                      //     onPressed: () {
                      //       setState(() {
                      //         // isFirstClick = true;
                      //         Navigator.of(context)
                      //             .pop(false);
                      //       });
                      //     },
                      //     child: Text(
                      //       "Yes",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontFamily: 'Nunito',
                      //         fontWeight:
                      //         FontWeight.w600,
                      //         fontSize:
                      //         MediaQuery.of(context)
                      //             .size
                      //             .width *
                      //             0.03,
                      //       ),
                      //     )),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty
                                  .all(
                                  Colors.grey)),
                          onPressed: () =>
                              Navigator.of(context)
                                  .pop(false),
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
          });*/

      // Fluttertoast.showToast(msg: "Zelle (Bank to Bank transfer to USA)\n Subscribers in the United States can use the ZELLE service to transfer funds at email sadqapakistan@gmail.com. "
      //     "Please ensure that cart invoice is in USD and NOT in PKR.",toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,backgroundColor: Colors.green,textColor: Colors.white);

    }
    else if(widget.data['id']=='3'){
      // Fluttertoast.showToast(msg: "Bank Deposit (For Donors in Pakistan)\n Deposit your order amount in the following Bank Account."
      //     "Habib Metropolitan Bank Pakistan  "
      //     "Title: Taraqqi Enterprise "
      //     "Account #: IBAN# PK87MPBL1102027140266234 "
      //     "Account # 6110220311714266234",toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,backgroundColor: Colors.green,textColor: Colors.white);
      /*showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    title: Text(
                      "Habib Metropolitan Bank Pakistan  ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    actionsAlignment:
                    MainAxisAlignment.spaceAround,
                    content: Text(
                        "Bank Deposit (For Donors in Pakistan)\n Deposit your order amount in the following Bank Account."
                  "Habib Metropolitan Bank Pakistan  "
                  "Title: Taraqqi Enterprise "
                  "Account #: IBAN# PK87MPBL1102027140266234 "
                    "Account # 6110220311714266234",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context)
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
                                  .all(
                                  Colors.grey)),
                          onPressed: () =>
                              Navigator.of(context)
                                  .pop(false),
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
          });*/

    }

    else if(widget.data['id']=='4'){

    }
    setState(() {
      widget.action!(widget.tag!);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: handleTap,
          child: Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(15, 3, 15, 2),
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.active!
                      ? const Color.fromRGBO(247,185,20,1)
                      : Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data['title'],
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromRGBO(6, 7, 12, 0.5)),
                ),
                widget.data['title'] == 'Credit/Debit Card (Payfast)'
                    ? Row(
                        children: [
                          Image.asset(
                            'assets/images/mastercard.png',
                            scale: 2,
                          ),
                          Image.asset(
                            'assets/images/visa.png',
                            scale: 2,
                          ),
                          Image.asset(
                            'assets/images/unionpay.png',
                            scale: 2,
                          )
                        ],
                      )
                    : Image.asset(
                        widget.data['icon'],
                        scale: 2,
                      ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
