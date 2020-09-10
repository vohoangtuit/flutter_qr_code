import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NameCard{
  String name;
  String email;
  String phone;
  //external Type get runtimeType;
  NameCard({this.name, this.email, this.phone});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
  factory NameCard.fromJson(Map<String, dynamic> json){
    if(json!=null){
      try{
        if(json["email"]==null||json["phone"]==null){
          return null;
        }
        return NameCard (
          name: json["name"],
          email: json["email"],
          phone: json["phone"],
        );
      }catch(e){
        print("NameCard Error $e");
        return null;
      }

    }else{
      return null;
    }

  }

  @override
  String toString() {
    return '{name: $name, email: $email, phone: $phone}';
  }
}