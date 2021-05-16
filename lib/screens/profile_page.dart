import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_message/common_widgets/button_widget.dart';
import 'package:flutter_message/common_widgets/textformfield.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userName = TextEditingController();
  PickedFile newPhoto;

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<AuthProvider>(context, listen: false);
    userName.text = _viewModel.users.userName.toString();
    return Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
                onPressed: () => signout(context),
                child: Icon(
                  Icons.exit_to_app,
                  size: 35,
                )),
          ],
          backgroundColor: Colors.purple.shade300,
          title: Text("Profile Page"),
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:58.0),
              child: Column(
                children: [
                  Center(
                      child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return bottomSheetWidget();
                          });
                    },
                    child: CircleAvatar(
                     radius: 75,
                     backgroundColor: Colors.white,
                     backgroundImage: newPhoto ==null ? NetworkImage(_viewModel.users.profilPhoto) :
                     FileImage(File(newPhoto.path)) ,
                    )  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Textformfield(
                      controller: userName,
                      obscureText: false,
                    ),
                  ),
                  ButtonWidgets(
                      buttonText: "Save",
                      pressed: () {
                        save(context);
                      },
                      color: Colors.green.shade200,
                      icon: Icon(Icons.build)),
                ],
              ),
            ),
          ),
        ));
  }

  signout(BuildContext context) async {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    await _authProvider.signOut();
  }

  save(BuildContext context) async {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (userName.text != _authProvider.users.userName) {
      var updateResult = await _authProvider.updateUsername(
          _authProvider.users.UserId, userName.text);
    }
    if(newPhoto != null){
     var url= await _authProvider.savePhoto(_authProvider.users.UserId, "photo", newPhoto);
     await _authProvider.updatePhoto(_authProvider.users.UserId, url);

    }
  }

  bottomSheetWidget() {
    return Container(
      height: 200,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("Camera"),
            onTap: () {
              photoFromCamera();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text("Gallery"),
            onTap: () {
              photoFromGallery();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void photoFromCamera()async {
   var image= await ImagePicker().getImage(source: ImageSource.camera);
   setState(() {
        newPhoto=image;
      });
  }

  void photoFromGallery()async {
    var image= await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      newPhoto=image;
    });
  }
}
