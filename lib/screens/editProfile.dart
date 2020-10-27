import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var containerH = 280.0;
  var imageRadius = 150.0;
  var editIcon = 50.0;
  File _image;
  final imagePicker = ImagePicker();
  final _form = GlobalKey<FormState>();
  var name = '';
  var number = '';
  var email = '';
  var address = '';

  Future pickImage() async {
    final pickedImage = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected');
      }
    });
  }

  saveForm() {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print('valid');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: containerH,
                width: double.infinity,
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    Container(
                      height: containerH,
                      child: Image.asset(
                        'assets/images/profilebg.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: containerH / 2 - imageRadius / 2,
                      left: width / 2 - imageRadius / 2,
                      child: Container(
                        height: imageRadius,
                        width: imageRadius,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(imageRadius),
                        ),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(imageRadius),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: imageRadius / 2,
                              ),
                      ),
                    ),
                    Positioned(
                      top: containerH / 2 + editIcon / 2,
                      left: width / 2 + editIcon / 2 + 10,
                      child: InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          height: editIcon,
                          width: editIcon,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(editIcon),
                          ),
                          child: Icon(FontAwesomeIcons.camera),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter Your Name',
                          icon: Icon(FontAwesomeIcons.user),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            name = newValue;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Your Email Address',
                          icon: Icon(Icons.mail_outline),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter email address!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            email = newValue;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          hintText: 'Enter Your Phone Number',
                          icon: Icon(Icons.phone_outlined),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the number!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            number = newValue;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          hintText: 'Enter Your Address',
                          icon: Icon(FontAwesomeIcons.addressBook),
                        ),
                        keyboardType: TextInputType.streetAddress,
                        onSaved: (newValue) {
                          setState(() {
                            address = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          saveForm();
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                  color: Colors.black38),
                            ],
                          ),
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TimeBurner',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
