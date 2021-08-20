
import 'package:ecommerce_app_for_admin/categoryScreens/products.dart';
import 'package:ecommerce_app_for_admin/helperProvider/screenProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget screenSelector(int flx){
  return Expanded(
    flex: 6,
    child: Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black12,
      child: Consumer<ScreenProvider>(
        builder: (context, provider, child) {
          switch (provider.screenName) {
            case "Dashboard":
              {
                return buildContainer(provider.screenName);
              }
            case "Products":
              {
                return ProductsScreen();
              }
            case "Orders":
              {
                return buildContainer(provider.screenName);
              }
            case "Customers":
              {
                return buildContainer(provider.screenName);
              }
            case "Statistics":
              {
                return buildContainer(provider.screenName);
              }
            case "Logout":
              {
                return buildContainer(provider.screenName);
              }
            default:
              {
                return buildContainer("Error");
              }
          }
        },
      ),
    ),
  );
}

Container buildContainer(String name) => Container(
  child: Center(
    child: Text(name),
  ),
);