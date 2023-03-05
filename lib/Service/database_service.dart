import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
//referance for our collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("Favorites");

//Saving the user data
  Future savingUserData(
      String fullname, String email, String phone, String adKey) async {
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "phoneNo": phone,
      "profilepic": "",
      "uid": uid,
      "email": email,
      "AdKey": adKey,
      "Gender": "",
      "DOB": "",
    });
  }

  //Getting the user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}

class DatabaseServiceHospital {
  final CollectionReference hospitalCollection =
      FirebaseFirestore.instance.collection("hospitals");
  Future savingHospitaldetails(
    String hospitalname,
    String year,
    String location,
    String district,
    String address,
    String highlight,
    String phoneno,
    String time,
    String doctorsNo,
    String bedNo,
    String ambulanceNo,
    String gmap,
  ) async {
    return await hospitalCollection.doc('hospital').set({
      "hospitalName": hospitalname,
      "establishedYear": year,
      "profilepic": "",
      "location": location,
      "district": district,
      "address": address,
      "highlight": highlight,
      "phoneno": phoneno,
      "time": time,
      "doctorsNo": doctorsNo,
      "bedNo": bedNo,
      "gMap": gmap,
    });
  }
}
