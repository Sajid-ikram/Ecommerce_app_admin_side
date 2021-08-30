import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_for_admin/LogIn/warningHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class ProductServices extends ChangeNotifier {
  Future uploadNewProduct({
    required BuildContext context,
    required Uint8List file,
    required String name,
    required String details,
    required String category,
    required String fileName,
    required int price,
  }) async {
    try {
      final ref = storage.FirebaseStorage.instance.ref().child("productImage/$fileName");
      final result = await ref.putData(file);
      final url = await result.ref.getDownloadURL();

      FirebaseFirestore.instance.collection("products").doc().set(
        {
          "name": name,
          "price": price,
          "category": category,
          "details": details,
          "url": url,
        },
      );
    } catch (e) {
      Provider.of<Warning>(context, listen: false)
          .showWarning("An error occurs ", Colors.amber, true);
    }
  }
}
