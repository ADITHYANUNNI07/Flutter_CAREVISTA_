import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }

  return image;
}

Future<String?> getDOBFromUserId(String uid) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot =
      await firestore.collection('users').where('uid', isEqualTo: uid).get();
  if (querySnapshot.docs.isNotEmpty) {
    Map<String, dynamic> data =
        querySnapshot.docs.first.data() as Map<String, dynamic>;
    String? dob = data['DOB'];
    return dob;
  }
  return null;
}

Future<String?> getGenderFromUserId(String uid) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot =
      await firestore.collection('users').where('uid', isEqualTo: uid).get();
  if (querySnapshot.docs.isNotEmpty) {
    Map<String, dynamic> data =
        querySnapshot.docs.first.data() as Map<String, dynamic>;
    String? dob = data['Gender'];
    return dob;
  }
  return null;
}

Future<String?> getImageURLFromUserId(String uid) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot =
      await firestore.collection('users').where('uid', isEqualTo: uid).get();
  if (querySnapshot.docs.isNotEmpty) {
    Map<String, dynamic> data =
        querySnapshot.docs.first.data() as Map<String, dynamic>;
    String? dob = data['profilepic'];
    return dob;
  }
  return null;
}

Future<String?> getAdministration(String email) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firestore
      .collection('Admin')
      .where('email', isEqualTo: email)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    Map<String, dynamic> data =
        querySnapshot.docs.first.data() as Map<String, dynamic>;
    String? dob = data['phoneNo'];
    return dob;
  }
  return null;
}
