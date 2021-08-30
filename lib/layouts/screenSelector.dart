import 'package:ecommerce_app_for_admin/LogIn/Authentication.dart';
import 'package:ecommerce_app_for_admin/categoryScreens/addNewProduct.dart';
import 'package:ecommerce_app_for_admin/categoryScreens/products.dart';
import 'package:ecommerce_app_for_admin/helperProvider/screenProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget screenSelector(int flx) {
  return Expanded(
    flex: 6,
    child: Container(
      height: 1000,
      padding: const EdgeInsets.all(20),
      color: Colors.black12,
      child: Consumer<ScreenProvider>(
        builder: (context, provider, child) {
          switch (provider.screenName) {
            case "Dashboard":
              {
                return _buildContainer(provider.screenName);
              }
            case "Products":
              {
                return ProductsScreen();
              }
            case "Orders":
              {
                return _buildContainer(provider.screenName);
              }
            case "Customers":
              {
                return _buildContainer(provider.screenName);
              }
            case "Statistics":
              {
                return _buildContainer(provider.screenName);
              }
            case "Logout":
              {
                return _logOutMethod(context);
              }
            case "AddProducts":
              {
                return AddNewProduct();
              }
            default:
              {
                return _buildContainer("Error");
              }
          }
        },
      ),
    ),
  );
}

Center _logOutMethod(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do you want to Logout',
          style: TextStyle(
            color: Color(0xffFCCFA8),
            fontSize: 26,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Provider.of<Authentication>(context, listen: false).signOut();
            Provider.of<ScreenProvider>(context, listen: false)
                .changeScreen("Products");
          },
          child: Container(
            width: 300,
            padding: EdgeInsets.symmetric(vertical: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffFCCFA8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 16, color: Color(0xff2B2B2B)),
            ),
          ),
        )
      ],
    ),
  );
}

Container _buildContainer(String name) => Container(
      child: Center(
        child: Text(name),
      ),
    );
