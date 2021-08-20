import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_for_admin/helperProvider/drawerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final Stream<QuerySnapshot> user =
      FirebaseFirestore.instance.collection("products").snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopRow(),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: user,
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

              return Consumer<DrawerProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: provider.screenNumber == 3
                              ? 6
                              : provider.screenNumber == 2
                                  ? 4
                                  : 2,
                          childAspectRatio: 2 / 2),
                      itemCount: data!.size,
                      itemBuilder: (BuildContext context, int index) {
                        return productCard(data, index);
                      });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Row _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "All Products",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        GestureDetector(
          onTap: () {

          },
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Color(0xffFCCFA8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Add New Product",
                      style: TextStyle(color: Colors.black)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget productCard(QuerySnapshot<Object?> data, int index) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(0, 10, 15, 10),
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(data.docs[index]["url"]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.docs[index]["name"],
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "\$${data.docs[index]["price"].toString()}",
                          style: TextStyle(
                            color: Color(0xFF628395),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    elevation: 0,
                    constraints: BoxConstraints(
                      minWidth: 0,
                    ),
                    shape: CircleBorder(),
                    fillColor: Color(0xffec6813),
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
