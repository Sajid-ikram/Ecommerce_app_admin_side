import 'package:ecommerce_app_for_admin/layouts/screenSelector.dart';
import 'package:ecommerce_app_for_admin/helperProvider/drawerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabletScreen extends StatefulWidget {
  const TabletScreen({Key? key}) : super(key: key);

  @override
  _TabletScreenState createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<DrawerProvider>(context, listen: false).changeShow(2);
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
