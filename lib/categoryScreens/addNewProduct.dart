import 'dart:typed_data';
import 'package:ecommerce_app_for_admin/Widgets/loadingIndicator.dart';
import 'package:ecommerce_app_for_admin/Widgets/textInputDeco.dart';
import 'package:ecommerce_app_for_admin/firebaseServices/productService.dart';
import 'package:ecommerce_app_for_admin/helperProvider/drawerProvider.dart';
import 'package:ecommerce_app_for_admin/helperProvider/screenProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final _descriptionKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();
  final _priceKey = GlobalKey<FormState>();
  String dropdownValue = 'Fashion';
  bool isSelected = false;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    super.dispose();
  }

  Uint8List? file;
  String fileName = "";

  Future pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        file = result.files.first.bytes;
        fileName = result.files.first.name;
        setState(() {
          isSelected = true;
        });
      }
    } catch (e) {}
  }

  void _validate() {
    if (_priceKey.currentState!.validate() &&
        _descriptionKey.currentState!.validate() &&
        _nameKey.currentState!.validate()) {
      buildShowDialog(context);
      Provider.of<ProductServices>(context, listen: false)
          .uploadNewProduct(
        category: dropdownValue,
        context: context,
        details: descriptionController.text,
        file: file!,
        fileName: fileName,
        name: nameController.text,
        price: int.parse(priceController.text),
      )
          .then((value) {
        Navigator.of(context, rootNavigator: true).pop();
        Provider.of<ScreenProvider>(context, listen: false)
            .changeScreen("Products");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Consumer<DrawerProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTopRow(),
              SizedBox(
                height: 40,
              ),
              provider.screenNumber != 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add Photo :", 20, _height),
                        buildPhotoContainer(_height, provider.screenNumber),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add Photo :", 20, _height),
                        buildPhotoContainer(_height, provider.screenNumber),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
              provider.screenNumber != 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add description :", 20, _height),
                        buildDescriptionContainer(provider.screenNumber),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add description :", 20, _height),
                        buildDescriptionContainer(provider.screenNumber),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
              provider.screenNumber != 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add name :", 20, _height),
                        buildNameContainer(provider.screenNumber),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add name :", 20, _height),
                        buildNameContainer(provider.screenNumber),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
              provider.screenNumber != 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add Price :", 20, _height),
                        buildPriceContainer(provider.screenNumber),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTitleText("Add Price :", 20, _height),
                        buildPriceContainer(provider.screenNumber),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: provider.screenNumber != 1
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  buildTitleText("Select category :", 20, _height),
                  buildSelectorContainer(provider.screenNumber),
                  SizedBox(
                    width: provider.screenNumber == 3
                        ? 600
                        : provider.screenNumber == 2
                            ? 400
                            : 0,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Row _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<ScreenProvider>(context, listen: false)
                .changeScreen("Products");
          },
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        GestureDetector(
          onTap: () {
            _validate();
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
                  Text("Upload", style: TextStyle(color: Colors.black)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.upload,
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

  Container buildSelectorContainer(int screenNumber) {
    return Container(
      width: 100,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        dropdownColor: Color(0xff444444),
        elevation: 16,
        style: const TextStyle(color: Color(0xffFCCFA8)),
        underline: Container(
          height: 2,
          color: Colors.white,
          width: 10,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Popular', 'Fashion', 'Electronics', 'Furniture']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Container buildNameContainer(int screenNumber) {
    return Container(
      width: screenNumber == 3
          ? 700
          : screenNumber == 2
              ? 500
              : double.infinity,
      child: Form(
        key: _nameKey,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          autofillHints: [AutofillHints.email],
          controller: nameController,
          validator: (value) {
            return value == null || value.isEmpty ? "Enter Name" : null;
          },
          keyboardAppearance: Brightness.light,
          keyboardType: TextInputType.emailAddress,
          decoration: HelperWidget().buildInputDecoration("Product Name"),
        ),
      ),
    );
  }

  Container buildPriceContainer(int screenNumber) {
    return Container(
      width: screenNumber == 3
          ? 700
          : screenNumber == 2
              ? 500
              : double.infinity,
      child: Form(
        key: _priceKey,
        child: TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          style: TextStyle(color: Colors.white),
          autofillHints: [AutofillHints.email],
          controller: priceController,
          validator: (value) {
            return value == null || value.isEmpty ? "Enter Price" : null;
          },
          keyboardAppearance: Brightness.light,
          keyboardType: TextInputType.number,
          decoration: HelperWidget().buildInputDecoration("Price"),
        ),
      ),
    );
  }

  Container buildDescriptionContainer(int screenNumber) {
    return Container(
      width: screenNumber == 3
          ? 700
          : screenNumber == 2
              ? 500
              : double.infinity,
      child: Form(
        key: _descriptionKey,
        child: TextFormField(
          maxLines: 5,
          style: TextStyle(color: Colors.white),
          autofillHints: [AutofillHints.email],
          controller: descriptionController,
          validator: (value) {
            return value == null || value.isEmpty ? "Enter Description" : null;
          },
          keyboardAppearance: Brightness.light,
          keyboardType: TextInputType.emailAddress,
          decoration: HelperWidget().buildInputDecoration("Description"),
        ),
      ),
    );
  }

  Container buildPhotoContainer(double _height, int screenNumber) {
    return Container(
      height: _height * 0.2,
      width: screenNumber == 3
          ? 700
          : screenNumber == 2
              ? 500
              : double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff444444), borderRadius: BorderRadius.circular(15)),
      child: isSelected
          ? Image.memory(file!)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Upload Photo",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Icon(
                    Icons.upload_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                )
              ],
            ),
    );
  }
}

Widget buildTitleText(String text, double size, double height) {
  return Container(
    alignment: Alignment.centerLeft,
    width: 220,
    child: Text(
      text,
      style: GoogleFonts.poppins(color: Color(0xffFCCFA8), fontSize: size),
    ),
  );
}
