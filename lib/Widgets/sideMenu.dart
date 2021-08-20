import 'package:ecommerce_app_for_admin/helperProvider/screenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List<String> menuItems = [
    "Dashboard",
    "Products",
    "Orders",
    "Customers",
    "Statistics",
    "Logout"
  ];

  List<Widget> menuIcons = [
    Icon(Icons.dashboard, color: Colors.white),
    Icon(Icons.list_alt, color: Colors.white),
    Icon(Icons.shopping_cart_outlined, color: Colors.white),
    Icon(Icons.people, color: Colors.white),
    Icon(Icons.stacked_line_chart, color: Colors.white),
    Icon(Icons.logout, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Center(
          child: GestureDetector(
            onTap: () {
              Provider.of<ScreenProvider>(context, listen: false)
                  .changeScreen(menuItems[index]);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  menuIcons[index],
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    menuItems[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: menuItems.length,
    );
  }
}
