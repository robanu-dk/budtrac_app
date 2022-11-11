import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../navigation/bottom_navigation.dart';
import '../pages/login.dart';
import '../provider/user_provider.dart';
import '../widget/profileImage.dart';
import '../widget/iconEditProfileImage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _edit = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    Map<String, dynamic> profile = {
      'firstname': user.getFirstName,
      'lastname': user.getLastName,
      'email': user.getEmail,
      'phone_number': user.getPhoneNumber,
      'image_profile': 'images/profile.png'
    };

    selectFromCamera() async {
      XFile? cameraFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print(cameraFile!.path.toString());
    }

    selectFromGallery() async {
      XFile? galleryFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.pink[800],
          title: Text("Profile", style: TextStyle(fontSize: 24)),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Card(
              margin: EdgeInsets.only(top: 6, left: 3, right: 3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  side: BorderSide(color: Colors.grey.shade400)),
              child: Container(
                height: 170,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        shadowColor: Colors.black,
                        color: Color.fromARGB(50, 0, 0, 0),
                        child: Consumer<User>(
                          builder: (context, value, child) => IconButton(
                            padding: EdgeInsets.only(
                                left: 2, right: 2, bottom: 2, top: 2),
                            splashRadius: 10,
                            iconSize: 120,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: (MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.landscape)
                                        ? MediaQuery.of(context).size.height *
                                            0.22
                                        : MediaQuery.of(context).size.height *
                                            0.15,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            splashRadius: 50,
                                            iconSize: 85,
                                            icon: Column(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  size: 60,
                                                ),
                                                Text("Camera"),
                                              ],
                                            ),
                                            onPressed: selectFromCamera,
                                          ),
                                          IconButton(
                                            splashRadius: 50,
                                            iconSize: 85,
                                            icon: Column(
                                              children: [
                                                Icon(
                                                  Icons.perm_media_sharp,
                                                  size: 60,
                                                ),
                                                Text("Gallery"),
                                              ],
                                            ),
                                            onPressed: selectFromGallery,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: _edit
                                ? Stack(
                                    children: [
                                      ProfileImage(
                                        image:
                                            profile['image_profile'].toString(),
                                      ),
                                      IconEditProfileImage(),
                                    ],
                                  )
                                : ProfileImage(
                                    image: profile['image_profile'].toString()),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.58,
                            child: Text(
                              '${profile['firstname'] + ' ' + profile['lastname']}',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.58,
                              child: Text(
                                '${profile['email']}',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade600),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 8, left: 3, right: 3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  side: BorderSide(color: Colors.grey.shade400)),
              child: Container(
                height: 315,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _edit = !_edit;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _edit ? Icon(Icons.save) : Icon(Icons.edit),
                              Text(
                                _edit ? 'Save' : 'Edit',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Consumer<User>(
                              builder: (context, value, child) => TextField(
                                controller: _edit
                                    ? null
                                    : TextEditingController(
                                        text: '${profile['firstname']}'),
                                enabled: _edit,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.lightBlue)),
                                  border: _edit
                                      ? UnderlineInputBorder()
                                      : InputBorder.none,
                                  label: Text(
                                    "First Name",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                                onSubmitted: (value) {
                                  user.setFirstName(value);
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Consumer<User>(
                              builder: (context, value, child) => TextField(
                                controller: _edit
                                    ? null
                                    : TextEditingController(
                                        text: '${profile['lastname']}'),
                                enabled: _edit,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.lightBlue)),
                                  border: _edit
                                      ? UnderlineInputBorder()
                                      : InputBorder.none,
                                  label: Text(
                                    "Last Name",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                                onSubmitted: (value) {
                                  user.setLastName(value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 14),
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: Consumer<User>(
                            builder: (context, value, child) => TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                user.setEmail(value);
                              },
                              enabled: _edit,
                              controller: _edit
                                  ? null
                                  : TextEditingController(
                                      text: '${profile['email']}'),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue)),
                                border: _edit
                                    ? UnderlineInputBorder()
                                    : InputBorder.none,
                                label: Text(
                                  "Email Address",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 14),
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: Consumer<User>(
                            builder: (context, value, child) => TextField(
                              maxLength: 13,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                user.setPhoneNumber(value);
                              },
                              enabled: _edit,
                              controller: _edit
                                  ? null
                                  : TextEditingController(
                                      text: '${profile['phone_number']}'),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue)),
                                border: _edit
                                    ? UnderlineInputBorder()
                                    : InputBorder.none,
                                label: Text(
                                  "Phone Number",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  color: Colors.pink[700],
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: IconButton(
                      onPressed: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage())),
                      icon: Text(
                        'Log out',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      splashRadius: MediaQuery.of(context).size.width * 0.5,
                    ),
                  )),
            )
          ]),
        ),
        bottomNavigationBar: BottomNavigation(2));
  }
}
