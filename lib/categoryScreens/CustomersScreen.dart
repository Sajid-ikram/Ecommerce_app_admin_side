import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_for_admin/LogIn/Authentication.dart';
import 'package:ecommerce_app_for_admin/helperProvider/drawerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final Stream<QuerySnapshot> products =
      FirebaseFirestore.instance.collection("users").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: products,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final data = snapshot.data;
        if (data == null) {
          Center(child: Text("No Users"));
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return individualUser(data!.docs[index]);
          },
          itemCount: data!.size,
        );
      },
    );
  }

  Widget individualUser(QueryDocumentSnapshot<Object?> data) {
    return Align(
      alignment: Alignment.center,
      child: Consumer<DrawerProvider>(
        builder: (context, provider, child) {
          return Container(
            width: provider.screenNumber == 3
                ? 900
                : provider.screenNumber == 2
                    ? 700
                    : 500,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(80.0),
                  topLeft: Radius.circular(80.0)),
              color: Color(0xff444444),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: 'assets/profile.jpg',
                      image: data["url"],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      data["name"],
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      data["email"],
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      "Role : " + data["role"],
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    _showMyDialog(context, data);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 120,
                    height: 47,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffFCCFA8)),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                        child: Text(
                      data["role"] == "admin" ? "Remove admin" : "Make Admin",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(color: Color(0xffFCCFA8)),
      );
    },
  );
}

Future<void> _showMyDialog(
    BuildContext context, QueryDocumentSnapshot<Object?> data) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(data["role"] == "admin"
            ? "Do you want to remove this admin ?"
            : "Do you want to make him admin ?"),
        content: Text(data["role"] == "admin"
            ? "This will remove him from admin and he will not be able to edit or login to this admin panel"
            : 'This will make him an admin and he will have same power as you have'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final pro = Provider.of<Authentication>(context, listen: false);
              data["role"] == "admin"
                  ? pro.removeAdmin(data.id)
                  : pro.makeAdmin(data.id);

              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
