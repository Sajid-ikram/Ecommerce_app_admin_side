import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_for_admin/LogIn/Authentication.dart';
import 'package:ecommerce_app_for_admin/LogIn/warningHelper.dart';
import 'package:ecommerce_app_for_admin/layouts/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SignIn.dart';

class HoldingPageForVerification extends StatefulWidget {
  const HoldingPageForVerification({Key? key}) : super(key: key);

  @override
  _HoldingPageForVerificationState createState() =>
      _HoldingPageForVerificationState();
}

class _HoldingPageForVerificationState
    extends State<HoldingPageForVerification> {
  bool isLoading = true;
  bool isVerified = true;

  @override
  void initState() {
    verifying();
    super.initState();
  }

  Future verifying() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userInfo = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userInfo["role"] != "admin") {
        Provider.of<Authentication>(context, listen: false).signOut();
        Provider.of<Warning>(context, listen: false).showWarning(
            "You are not Authorized to log in", Colors.amber, true);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: Color(0xFF2B2B2B),
            body: Center(
                child: CircularProgressIndicator(color: Color(0xffFCCFA8))))
        : isVerified
            ? SiteLayout()
            : SignIn();
  }
}
