import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/model/product.dart';
import 'package:qr_code/model/name_card.dart';

class ScanScreen extends StatefulWidget {
  //https://github.com/eccosuprastyo/flutter/tree/master/barcode_scanner
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
          backgroundColor: Colors.deepOrange,
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.teal),),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    try {

      ScanResult codeSanner =await BarcodeScanner.scan();
      // print("codeSanner $codeSanner");
      // print("codeSanner toString ${codeSanner.toString()}");
      // print("codeSanner runtimeType ${codeSanner.runtimeType}");
      // print("codeSanner rawContent ${codeSanner.rawContent}");

      var result =codeSanner.rawContent;
      if(result!=null){
        print("result $result");
        //var parsedJson = json.decode(result);

        // print("parsedJson : "'${parsedJson.runtimeType} : $parsedJson');
        var profile =  NameCard.fromJson(json.decode(result));
        var product =  Product.fromJson(json.decode(result));
      //  NameCard profile=  NameCard.fromJson(json.decode(codeSanner.rawContent));
        if(profile!=null){
          setState(() => this.barcode = "QR Name Card\n"+"phone:"+profile.phone+"\n"+"email:"+profile.email);
        } else if(product!=null){
          setState(() => this.barcode = "QR Product\n"+"name:"+product.name+"\n"+"price:"+product.price);
          //NameCard profile= new NameCard.fromJson(json.decode(codeSanner.rawContent));

        }
        else{
          setState(() => this.barcode = codeSanner.rawContent);
        }
        // if(result.contains("id")){// todo: search other solution
        //   Product product= new Product.fromJson(json.decode(codeSanner.rawContent));
        //   setState(() => this.barcode = "QR Product\n"+"name:"+product.name+"\n"+"price:"+product.price);
        // }else if(result.contains('email')){
        //   NameCard profile= new NameCard.fromJson(json.decode(codeSanner.rawContent));
        //   setState(() => this.barcode = "QR Name Card\n"+"phone:"+profile.phone+"\n"+"email:"+profile.email);
        // }


      }else{
        setState(() => this.barcode = "Error: Qr Code valid");
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error 0 : $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      print("Unknown error $e");
      setState(() => this.barcode = 'Unknown error 1 : $e');
    }
  }

}