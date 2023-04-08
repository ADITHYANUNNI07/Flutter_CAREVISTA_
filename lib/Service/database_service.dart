import 'package:carevista_ver05/SCREEN/addons/recorddetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  Future updateUserData(String fullname, String email, String phone,
      String adKey, String gender, String dob, String imageUrl) async {
    return await userCollection.doc(uid).update({
      "fullName": fullname,
      "phoneNo": phone,
      //"profilepic": profile,
      "uid": uid,
      "email": email, "AdKey": adKey,
      "Gender": gender,
      "DOB": dob,
      "profilepic": imageUrl,
    });
  }

  Future folderDB(String folderName, String remark) async {
    final userDoc = await userCollection.doc(uid).get();
    final newCollectionRef = userDoc.reference.collection('PatientRecord');
    final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    // ignore: unused_local_variable
    final newDocRef = await newCollectionRef.doc(folderName).set({
      'FolderName': folderName,
      'Remark': remark,
      'Date': currentDate,
      'ImageNo': '1',
      'PDFNo': '5',
      'UpdateDate': '',
      'File2': '',
      'File11': '',
      'File3': '',
      'File4': '',
      'File5': '',
      'File6': '',
      'File7': '',
      'File8': '',
      'File9': '',
      'File10': '',
    });
  }

  Future<void> updateFolderDB(
      String folderId,
      String folderName,
      String remark,
      String date,
      String imageNo,
      String pdfNo,
      String file,
      String fileurl) async {
    final userDoc = await userCollection.doc(uid).get();
    final folderDoc =
        await userDoc.reference.collection('PatientRecord').doc(folderId).get();
    final updateDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    await folderDoc.reference.update({
      'FolderName': folderName,
      'Remark': remark,
      'Date': date,
      'ImageNo': imageNo,
      'PDFNo': pdfNo,
      'UpdateDate': updateDate,
      file: fileurl,
    });
  }

  Future diaryDB(String title, String note) async {
    final userDoc = await userCollection.doc(uid).get();
    // ignore: unused_local_variable
    final newCollectionRef = userDoc.reference.collection('Diary');
    // ignore: unused_local_variable
    final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final newDocRef = await newCollectionRef.doc(title).set({
      'Title': title,
      'Diary': note,
      'Date': currentDate,
      'UpdateDate': '',
    });
  }

  //Getting the user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future gettingUserDatapH(String phone) async {
    QuerySnapshot snapshot =
        await userCollection.where("phoneNo", isEqualTo: phone).get();
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
    String logoUrl,
    String govtprivate,
    String type,
    String affiliatted,
    String emergencydpt,
    String splace1,
    String sdistance1,
    String stime1,
    String splace2,
    String sdistance2,
    String stime2,
    int length,
    List doctorname,
    List specialist,
    String hospital1,
    String hospital2,
    String hospital3,
    String overview,
    String service,
    String image1url,
    String image2url,
    String image3url,
    String image4url,
    String image5url,
    String uploadername,
    String uploaderphone,
    String lat,
    String long,
  ) async {
    return await hospitalCollection.doc('$hospitalname').set({
      "hospitalName": hospitalname,
      "establishedYear": year,
      "GovtorPrivate": govtprivate,
      "location": location,
      "district": district,
      "address": address,
      "type": type,
      "affiliateduniversity": affiliatted,
      "emergencydepartment": emergencydpt,
      "surroundingplace1": splace1,
      "surroundingdistance1": sdistance1,
      "surroundingtime1": stime1,
      "surroundingplace2": splace2,
      "surroundingdistance2": sdistance2,
      "surroundingtime2": stime2,
      "highlight": highlight,
      "phoneno": phoneno,
      "time": time,
      "doctorsNo": doctorsNo,
      "bedNo": bedNo,
      "sitLink": gmap,
      "Logo": logoUrl,
      "doctorName&Specialist": FieldValue.arrayUnion([
        for (int i = 0; i < length; i++)
          {
            "DoctorName": doctorname.toList()[i].text,
            "Specialist": specialist.toList()[i].text,
          },
      ]),
      "hospital1": hospital1,
      "hospital2": hospital2,
      "hospital3": hospital3,
      "ambulanceNo": ambulanceNo,
      "overview": overview,
      "services": service,
      "image1": image1url,
      "image2": image2url,
      "image3": image3url,
      "image4": image4url,
      "image5": image5url,
      'uploadDocternumber': length,
      "uploaderName": uploadername,
      "uploaderPhoneNo": uploaderphone,
      'Latitude': lat,
      'Longitude': long,
    });
  }
}
