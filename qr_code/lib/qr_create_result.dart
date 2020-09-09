import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code/model/name_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'model/product.dart';

class QRCreateResult extends StatefulWidget {
   Product product;
   NameCard profile;

   QRCreateResult(this.product,this.profile);

  @override
  _QRCreateResultState createState() => _QRCreateResultState();
}

class _QRCreateResultState extends State<QRCreateResult> {
  GlobalKey globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(title: Text("QR Code"),),
      body: Center(
        child: RepaintBoundary(
          key: globalKey,
          child: QrImage(
            //data: widget.product.toJson().toString(),
            data:json.encode(widget.product!=null?widget.product.toJson():widget.profile.toJson()),
            size: 0.45 * bodyHeight,
          ),
        ),
      ),
    );
  }
}
