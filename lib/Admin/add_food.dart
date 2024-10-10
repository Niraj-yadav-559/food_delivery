import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'; // Import this to use kIsWeb
import 'package:flutter/material.dart';
import 'package:food_app/DataBase/users_detail.dart';
import 'package:food_app/wiget/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> fooditems = ['Ice-cream', 'Burger', 'Salad', 'Pizza'];
  String? value; // Dropdown value
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? selectedImageUrl; // To store the image URL for web

  // Function to pick an image
  Future<void> getImage() async {
    try {
      var image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (!kIsWeb) {
          // Running on mobile, use File
          setState(() {
            selectedImage = File(image.path);
          });
        } else {
          // Running on web, store the image URL
          setState(() {
            selectedImageUrl = image.path;
          });
        }
      } else {
        _showSnackBar("No image selected", Colors.redAccent);
      }
    } catch (e) {
      _showSnackBar("Error selecting image: $e", Colors.redAccent);
    }
  }

  // Function to upload the item details
  Future<void> uploadItem() async {
    if ((selectedImage != null || selectedImageUrl != null) &&
        namecontroller.text.isNotEmpty &&
        pricecontroller.text.isNotEmpty &&
        detailcontroller.text.isNotEmpty &&
        value != null) {
      try {
        String addId = randomAlphaNumeric(10);
        String? downloadUrl;

        if (!kIsWeb && selectedImage != null) {
          // Uploading the image from mobile device
          Reference firebaseStorageRef =
              FirebaseStorage.instance.ref().child("blogImages").child(addId);
          final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

          downloadUrl = await (await task).ref.getDownloadURL();
        } else if (selectedImageUrl != null) {
          // Uploading the image from web
          Reference firebaseStorageRef =
              FirebaseStorage.instance.ref().child("blogImages").child(addId);
          final UploadTask task = firebaseStorageRef.putData(
            await XFile(selectedImageUrl!).readAsBytes(),
          );

          downloadUrl = await (await task).ref.getDownloadURL();
        }

        Map<String, dynamic> addItem = {
          "Image": downloadUrl,
          "Name": namecontroller.text,
          "Price": pricecontroller.text,
          "Detail": detailcontroller.text,
          "Category": value
        };

        await DatabaseMethods().addFoodItem(addItem).then(() {
          _showSnackBar(
            "Food Item has been added successfully",
            Colors.orangeAccent,
          );
        });
      } catch (e) {
        _showSnackBar("Error uploading item: $e", Colors.redAccent);
      }
    } else {
      _showSnackBar(
          "Please fill all the fields and select an image", Colors.redAccent);
    }
  }

  // Function to show a SnackBar message
  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:
              Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF373866)),
        ),
        centerTitle: true,
        title: Text("Add Item", style: AppWidget.HeadlineTextFeildStyle()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload the Item Picture",
                  style: AppWidget.semiboldTextFeildStyle()),
              SizedBox(height: 20.0),
              // Display image differently for mobile and web
              selectedImage == null && selectedImageUrl == null
                  ? GestureDetector(
                      onTap: getImage,
                      child: Center(
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(Icons.camera_alt_outlined,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: !kIsWeb
                                ? Image.file(selectedImage!)
                                : Image.network(selectedImageUrl!),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30.0),
              Text("Item Name", style: AppWidget.semiboldTextFeildStyle()),
              SizedBox(height: 10.0),
              _buildTextField(namecontroller, "Enter Item Name"),
              SizedBox(height: 30.0),
              Text("Item Price", style: AppWidget.semiboldTextFeildStyle()),
              SizedBox(height: 10.0),
              _buildTextField(pricecontroller, "Enter Item Price"),
              SizedBox(height: 30.0),
              Text("Item Detail", style: AppWidget.semiboldTextFeildStyle()),
              SizedBox(height: 10.0),
              _buildTextField(detailcontroller, "Enter Item Detail",
                  maxLines: 6),
              SizedBox(height: 20.0),
              Text("Select Category",
                  style: AppWidget.semiboldTextFeildStyle()),
              SizedBox(height: 20.0),
              _buildDropdown(),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: uploadItem,
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build TextFields
  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFececf8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppWidget.LightTextFeildStyle(),
        ),
      ),
    );
  }

  // Helper method to build Dropdown
  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFececf8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: fooditems
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
      ),
    );
  }
}
