import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Product{
  String id;
  String name;
  String price;
  String created;
  String image;
  String description;
  //external Type get runtimeType;

  Product({this.id, this.name, this.price, this.created, this.image,
      this.description});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created'] = this.created;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
  factory Product.fromJson(Map<String, dynamic> json){
    if(json!=null){
      try{
        if(json["id"]  as String==null||json["price"]==null||json["image"]==null){
          return null;
        }
        return Product (
          id: json["id"] as String,
          name: json["name"],
          price: json["price"],
          created: json["created"],
          image: json["image"],
          description: json["description"],
        );
      }
      catch(e){
        print("Product Error $e");
        return null;
      }

    }else{
      return null;
    }
  }

  @override
  String toString() {
    return '{id: $id, name: $name, price: $price, created: $created, image: $image, description: $description}';
  }
}