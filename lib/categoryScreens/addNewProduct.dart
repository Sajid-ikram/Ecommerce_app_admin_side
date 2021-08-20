
import 'package:ecommerce_app_for_admin/Widgets/textInputDeco.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _descriptionKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();
  String dropdownValue = 'Fashion';

  final picker = ImagePicker();
  //late File _imageFile;
  bool isSelected = false;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    descriptionController.clear();
    super.dispose();
  }

  Future pickImage() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        setState(() {
          isSelected = true;
          //_imageFile = File(pickedFile);
        });
      }
    } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width7by1 = MediaQuery.of(context).size.width/7;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitleText("Add Photo", 20),
              Container(
                margin: EdgeInsets.only(
                    left: 20,),
                height: _height*0.2,
                width: _width7by1*3,
                color: Colors.grey,
                child: /*isSelected
                        ? Image.file(_imageFile)
                        :*/ Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Upload Photo",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 13),
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
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),



            ],
          ),
          Row(
            children: [
              buildTitleText("Add description", 20),
              Container(
                width: 400,
                margin: EdgeInsets.only(left: 20),
                child: Form(
                  key: _descriptionKey,
                  child: TextFormField(
                    maxLines: 5,
                    style: TextStyle(color: Colors.white),
                    autofillHints: [AutofillHints.email],
                    controller: descriptionController,
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? "Enter Description"
                          : null;
                    },
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                    HelperWidget().buildInputDecoration("Description"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildTitleText("Add name", 20),
              Container(
                width: 400,
                margin: EdgeInsets.only(left: 20),
                child: Form(
                  key: _nameKey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    autofillHints: [AutofillHints.email],
                    controller: descriptionController,
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? "Enter Name"
                          : null;
                    },
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                    HelperWidget().buildInputDecoration("Product Name"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildTitleText("Select category", 20),
              Container(
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
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    'Popular',
                    'Fashion',
                    'Electronics',
                    'Furniture'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget buildTitleText(String text, double size) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: GoogleFonts.poppins(color: Color(0xffFCCFA8), fontSize: size),
    ),
  );
}
