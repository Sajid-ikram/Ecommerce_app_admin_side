import 'package:ecommerce_app_for_admin/helperProvider/drawerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/constants.dart';


AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    elevation: 0,
    leading: Consumer<DrawerProvider>(
      builder: (context, provider, child) {
        return provider.screenNumber != 3 ? IconButton(
          onPressed: () {
            key.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ): Icon(Icons.admin_panel_settings);
      },
    ),

    title: Row(
      children: [
        Text(
          "Admin Panel",
          style: TextStyle(
              color: lightGrey, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Expanded(child: SizedBox()),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: dark.withOpacity(.7),
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: dark.withOpacity(.7),
              ),
            ),
            Positioned(
              child: Container(
                height: 12,
                width: 12,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: active,
                    border: Border.all(
                      color: light,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30)),
              ),
              top: 7,
              right: 7,
            )
          ],
        ),
        Container(
          width: 1,
          height: 22,
          color: lightGrey,
        ),
        SizedBox(
          width: 24,
        ),

        Text(
          "Sajid Ikram",
          style: TextStyle(
              color: lightGrey, fontWeight: FontWeight.normal, fontSize: 15),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundColor: light,
              child: Icon(
                Icons.person_outline,

              ),
            ),
          ),
        )
      ],
    ),
    iconTheme: IconThemeData(color: dark),
    backgroundColor: Colors.transparent,
  );
}
