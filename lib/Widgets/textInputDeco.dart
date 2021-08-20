import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelperWidget{

  InputDecoration buildInputDecoration(String text) {
    return InputDecoration(

      filled: true,
      fillColor: Color(0xff444444),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      hintText: text,
      hintStyle: GoogleFonts.poppins(color: Colors.white),
    );
  }
}