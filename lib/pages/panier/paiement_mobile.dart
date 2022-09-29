import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementMobile extends StatefulWidget {
  //
  String lien;
  //
  Map<String, String> params;
  //
  PaiementMobile(this.lien, this.params);
  //
  @override
  _PaiementMobile createState() => _PaiementMobile();
}

class _PaiementMobile extends State<PaiementMobile> {
  //
  WebViewController? webViewController;
  //
  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 232, 235),
          //appBar: AppBar(),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 137, 147, 1),
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          //
                          Get.back();
                          //
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(
                                "Panier",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(widget.lien),
                      // method: 'POST',
                      // body: Uint8List.fromList(
                      //   utf8.encode(
                      //     jsonEncode(widget.params),
                      //   ),
                      // ),
                      // headers: {
                      //   'Content-Type': 'application/x-www-form-urlencoded'
                      // },
                    ),
                    onWebViewCreated: (controller) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
WebView(
      initialUrl: widget.lien,
    )
*/