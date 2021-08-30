import 'package:ecommerce_app_for_admin/LogIn/warningHelper.dart';
import 'package:ecommerce_app_for_admin/Widgets/loadingIndicator.dart';
import 'package:ecommerce_app_for_admin/Widgets/textInputDeco.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Authentication.dart';
import 'ErrorDialog.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVerified = false;
  bool isLoading = false;

  final _emailKey = GlobalKey<FormState>();

  final _passKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();

    super.dispose();
  }

  validate() async {
    if (_passKey.currentState!.validate() &&
        _emailKey.currentState!.validate()) {
      buildShowDialog(context);
      Provider.of<Authentication>(context, listen: false)
          .signIn(emailController.text, passwordController.text,context)
          .then(
        (value) {
          Navigator.of(context, rootNavigator: true).pop();
          if (value != "Success") {
            Provider.of<Warning>(context, listen: false)
                .showWarning(value, Colors.amber, true);
          }
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),

      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(

                        width: 400,
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: Column(

                          children: <Widget>[

                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.3),
                            Text(
                              "Admin Dashboard",
                              style: GoogleFonts.poppins(color: Color(0xffFCCFA8),fontSize: 30),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.1),
                            Form(
                              key: _emailKey,
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                autofillHints: [AutofillHints.email],
                                controller: emailController,
                                validator: (value) {
                                  return value == null || value.isEmpty
                                      ? "Enter a Email"
                                      : value.contains('@') &&
                                              value.contains('.com')
                                          ? null
                                          : "Enter a valid email";
                                },
                                keyboardAppearance: Brightness.light,
                                keyboardType: TextInputType.emailAddress,
                                decoration: HelperWidget().buildInputDecoration("Email"),
                              ),
                            ),
                            SizedBox(height: 10),
                            Form(
                              key: _passKey,
                              child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    return value == null || value.isEmpty
                                        ? "Enter a Password"
                                        : value.length < 6
                                            ? "Length should be more than 6"
                                            : null;
                                  },
                                  decoration: HelperWidget().buildInputDecoration("Password")),
                            ),
                            SizedBox(height: 25),
                            InkWell(
                              onTap: () {
                                validate();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 18),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xffFCCFA8),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Color(0xff2B2B2B)),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ErrorDialog(),
              ],
            ),
    );
  }

}
