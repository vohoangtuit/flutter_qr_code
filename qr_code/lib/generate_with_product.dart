import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/qr_create_result.dart';
import 'dart:math';
import 'model/product.dart';
import 'package:intl/intl.dart';

class CreateWithProduct extends StatefulWidget {

  @override
  _CreateWithProductState createState() => _CreateWithProductState();
}

class _CreateWithProductState extends State<CreateWithProduct> {
  final formKey = GlobalKey<FormState>();
  String _errorName;
  String _errorPrice;
  String _errorDescription;
  final TextEditingController _nameController =  TextEditingController();
  final TextEditingController _priceController =  TextEditingController();
  final TextEditingController _descriptionController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code with Product'),
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
                controller: _priceController,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,new LengthLimitingTextInputFormatter(42)],
                decoration:  InputDecoration(
                  hintText: "Enter price",
                  errorText: _errorPrice,
                ),
                validator: (val) {
                  return val.length >1
                      ? null
                      : "please enter price";
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 1,//Normal textInputField will be displayed
                maxLines: 5,// when user presses enter it will adapt to it
                decoration:  InputDecoration(
                  hintText: "Enter description",
                  errorText: _errorDescription,
                ),
                validator: (val) {
                  return val.length >= 1
                      ? null
                      : "please enter description";
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
      String id = random.nextInt(10000).toString();
      Product product = new Product(id:id,name: _nameController.text,price: _priceController.text,created: formattedDate,image: "https://avatars1.githubusercontent.com/u/16893157?s=460&u=aeb28d19ca88e78c507ea21a35dfc780f914abe3&v=4",description: _descriptionController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCreateResult(product,null)));
    }
  }
}
