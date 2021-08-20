
import 'package:ecommerce_app_for_admin/Widgets/topNavigationBar.dart';
import 'package:ecommerce_app_for_admin/layouts/MobileScreen.dart';
import 'package:ecommerce_app_for_admin/layouts/TabletScreen.dart';
import 'package:ecommerce_app_for_admin/layouts/WebScreen.dart';
import 'package:flutter/material.dart';
import '../Constant/constants.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: Drawer(),
        body: LayoutBuilder(
          builder: (context, constrains) {
            double _width = constrains.maxWidth;
            print(_width);
            if (_width >= lageScreenSize) {
              return WebScreen();
            } else if (_width >= mediumScreenSize) {
              return TabletScreen();
            } else {
              return MobileScreen();
            }
          },
        ));
  }
}
