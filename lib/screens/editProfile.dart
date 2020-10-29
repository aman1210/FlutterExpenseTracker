import 'dart:io';

import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  Future pickImage(ImageSource source) async {
    final pickedImage = await imagePicker.getImage(source: source);
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
    Provider.of<ProfileProvider>(context, listen: false)
        .addProfile(_image.path, name, number, email, address);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<ProfileProvider>(context, listen: false);
    if (provider.name != '') {
      name = provider.name;
      _image = File(provider.path);
      number = provider.number;
      email = provider.email;
      address = provider.address;
    }
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
                          color: Provider.of<ProfileProvider>(context).isDark ==
                                  true
                              ? Theme.of(context).primaryColor
                              : Colors.grey[100],
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
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 105,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Profile Photo',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              pickImage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 60,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "TimeBurner",
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              pickImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 60,
                                              color:
                                                  Theme.of(context).accentColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(FontAwesomeIcons.image,
                                                      color: Colors.black),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontFamily: "TimeBurner",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: editIcon,
                          width: editIcon,
                          decoration: BoxDecoration(
                            color:
                                Provider.of<ProfileProvider>(context).isDark ==
                                        true
                                    ? Color.fromRGBO(101, 111, 112, 1)
                                    : Colors.grey[400],
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
                        initialValue: name,
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
                        initialValue: email,
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
                        initialValue: number,
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
                        initialValue: address,
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
