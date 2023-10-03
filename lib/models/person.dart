import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String? email;
  String? password;
  String? imageProfile;
  String? name;
  int? age;
  String? city;
  String? state;
  String? phoneNo;
  String? profileheading;
  int? publishedDateTime;

  Person(
      {this.imageProfile,
      this.email,
      this.password,
      this.name,
      this.age,
      this.city,
      this.phoneNo,
      this.profileheading,
      this.publishedDateTime,
      this.state});

  static Person fromDataSnapshot(DocumentSnapshot snapshot){

    
    var dataSnapshot = snapshot.data() as Map<String, dynamic> ;

    return Person(
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      imageProfile: dataSnapshot["imageProfile"],
      name: dataSnapshot["name"],
      age: dataSnapshot["age"],
      city: dataSnapshot["city"],
      state: dataSnapshot["state"],
      phoneNo: dataSnapshot["phoneNo"],
      profileheading: dataSnapshot["profileheading"],
      publishedDateTime: dataSnapshot["publishedDateTime"]
    );

  }    

  Map<String, dynamic> tojson() => {

    "email": email,
    "password": password,
    "name": name,
    "imageProfile" : imageProfile,
    "age": age,
    "city": city,
    "state": state,
    "phoneNo": phoneNo,
    "profileheading": profileheading,
    "publishedDateTime":publishedDateTime,

  } ;
}
