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
    checkType();
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
      //  Type type = result.runtimeType;
      //  print("type $type");
        var product =  Product.fromJson(json.decode(result));
        var profile =  NameCard.fromJson(json.decode(result));
        if(product!=null ){
          //   print("product "+product.toString());
          setState(() => this.barcode = "QR Product\n\n\n"+"name:"+product.name+"\n"+"price:"+product.price);
        } else if(profile!=null){
          //print("profile "+profile.toString());
          setState(() => this.barcode = "QR Name Card\n\n\n"+"phone:"+profile.phone+"\n"+"email:"+profile.email);
        }else{
          setState(() => this.barcode = result);
        }
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
    }
    // on FormatException{
    //   setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    // }
    catch (e) {
      print("Unknown error $e");
      setState(() => this.barcode = 'Unknown error 1 : $e');
    }
  }
  checkType(){
    //var data_types = ["string", 123, 12.031, [], {"id":"7540","name":"aaaa","price":"1121","created":"10-09-2020 – 10:21:07","image":"https://avatars1.githubusercontent.com/u/16893157?s=460&u=aeb28d19ca88e78c507ea21a35dfc780f914abe3&v=4","description":"asa"} ];
    var data_types = {"id":"7540","name":"aaaa","price":"1121","created":"10-09-2020 – 10:21:07","image":"https://avatars1.githubusercontent.com/u/16893157?s=460&u=aeb28d19ca88e78c507ea21a35dfc780f914abe3&v=4","description":"asa"};
    print(data_types.runtimeType);

    if (data_types.runtimeType == String){
    print( "-it's a String");

    }else if (data_types.runtimeType == int){
    print("-it's a Int");

    }else if (data_types.runtimeType == [].runtimeType){
    print("-it's a List/Array");

    }else if (data_types.runtimeType == {}.runtimeType){
    print("-it's a Map/Object/Dict");

    }else {
    print("\n>> See this type is not their .\n");
    }
    }

}