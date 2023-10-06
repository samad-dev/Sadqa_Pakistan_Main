import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class UtilService {
  // FirebaseService firebaseService = locator<FirebaseService>();

  showToast(BuildContext context,String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.03);
  }

  showSnackBar(BuildContext context, String masg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        masg,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
      ),
    ));
  }

  showModelSheets(
    BuildContext context,
    Widget Function() createPage,
  ) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 1,
          // minChildSize: 1,
          snap: true,
          builder: (context, scrollController) {
            return SingleChildScrollView(
                controller: scrollController, child: createPage());
          },
        );
      },
    );
  }
}
