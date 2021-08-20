import 'package:ecommerce_app_for_admin/layouts/screenSelector.dart';
import 'package:ecommerce_app_for_admin/helperProvider/drawerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  _MobileScreenState createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<DrawerProvider>(context, listen: false).changeShow(1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenSelector(1),
      ],
    );
  }
}
