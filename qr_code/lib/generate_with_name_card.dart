import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/model/name_card.dart';
import 'package:qr_code/qr_create_result.dart';
import 'dart:math';
import 'model/product.dart';
import 'package:intl/intl.dart';

class CreateWithNameCard extends StatefulWidget {

  @override
  _CreateWithNameCardState createState() => _CreateWithNameCardState();
}

class _CreateWithNameCardState extends State<CreateWithNameCard> {
  final formKey = GlobalKey<FormState>();
  String _errorName;
  String _errorPrice;
  String _errorDescription;
  final TextEditingController _nameController =  TextEditingController();
  final TextEditingController _emailController =  TextEditingController();
  final TextEditingController _phoneController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code with Name card'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _contentWidget(),
    );
  }
  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration:  InputDecoration(
                  hintText: "Enter name",
                  errorText: _errorName,
                ),
                validator: (val) {
                  return val.length >= 3
                      ? null
                      : "Name 3+ characters";
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _emailController,

                decoration:  InputDecoration(
                  hintText: "Enter Email",
                  errorText: _errorPrice,
                ),
                validator: (val) {
                  return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)
                      ? null
                      : "Enter correct email";
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _phoneController,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,new LengthLimitingTextInputFormatter(42)],
                decoration:  InputDecoration(
                  hintText: "Enter Phone",
                  errorText: _errorDescription,
                ),
                validator: (val) {
                  return val.length >= 10
                      ? null
                      : "please enter Phone";
                },
              ),
              SizedBox(height: 20,),
              GestureDetector(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Create",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18),
                    )),
                onTap: () {
                  _handle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  _handle() async{
    if (formKey.currentState.validate()) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy – HH:mm:ss').format(now);
      Random random = new Random();
      int id = random.nextInt(10000);
      NameCard profile = new NameCard(name: _nameController.text,email: _emailController.text,phone: _phoneController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCreateResult(null, profile)));
    }
  }
}
