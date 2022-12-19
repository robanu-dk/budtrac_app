import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import './splash.dart';
import '../navigation/bottom_navigation.dart';
import '../provider/user_provider.dart';
import '../widget/profileImage.dart';
import '../widget/iconEditProfileImage.dart';
import '../widget/tombolAction.dart';
import '../widget/previewUploadImage.dart';
import '../controller/firebase_storage_controller.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _edit = false;
  FirebaseStorageController controller = FirebaseStorageController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    // Map<String, dynamic> profile = {
    //   'firstname': user.getFirstName,
    //   'lastname': user.getLastName,
    //   'email': user.getEmail,
    //   'phone_number': user.getPhoneNumber,
    //   'image_profile': user.getImage
    // };

    selectFile(String source) {
      (source == 'Camera')
          ? controller.selectImageFromCamera().then(
                (file) => file != null
                    ? showDialog(
                        context: context,
                        builder: (context) => PreviewUploadImage(
                          file: file,
                          imageFor: "profile",
                          userId: user.userId,
                        ),
                      )
                    : null,
              )
          : (source == 'Gallery')
              ? controller.selectImageFromGallery().then(
                    (file) => file != null
                        ? showDialog(
                            context: context,
                            builder: (context) => PreviewUploadImage(
                              file: file,
                              imageFor: "profile",
                              userId: user.userId,
                            ),
                          )
                        : null,
                  )
              : showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Alert"),
                    content: Text("Delete profile photo?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("No")),
                      TextButton(
                        onPressed: () {
                          print(user.getImage);
                          controller.deleteImage(user.getImage).then((value) =>
                              user.updateProfileImage("profile.png+ "));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                        child: Text("Yes"),
                      )
                    ],
                  ),
                );
    }

    Card inputanFile(String source) {
      return Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        color: Colors.grey[300],
        elevation: 6,
        child: IconButton(
          splashRadius: 50,
          iconSize: 70,
          icon: Column(
            children: [
              Icon(
                (source == 'Camera')
                    ? Icons.camera_alt_rounded
                    : (source == "Gallery")
                        ? Icons.perm_media_sharp
                        : Icons.delete,
                size: 50,
              ),
              Text(source),
            ],
          ),
          // onPressed: selectFromCamera,
          onPressed: () {
            selectFile(source);
          },
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.pink[800],
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 24),
          ),
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
                              _edit
                                  ? showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: (MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.30
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Row(
                                              children: [
                                                inputanFile('Camera'),
                                                inputanFile('Gallery'),
                                                (value.getImage !=
                                                        "profile.png")
                                                    ? inputanFile('Delete')
                                                    : Text(''),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : null;
                            },
                            icon: _edit
                                ? Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      ProfileImage(
                                        image: (value.getImage == 'profile.png')
                                            ? Image.asset(
                                                'images/${value.getImage}',
                                              )
                                            : Image.network(value.getImageUrl),
                                      ),
                                      IconEditProfileImage(),
                                    ],
                                  )
                                : ProfileImage(
                                    image: (value.getImage == 'profile.png')
                                        ? Image.asset(
                                            'images/${value.getImage}',
                                          )
                                        : Image.network(
                                            value.getImageUrl,
                                          ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 10),
                      child: Consumer<User>(
                        builder: (context, value, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.58,
                              child: Text(
                                // '${profile['firstname'] + ' ' + profile['lastname']}',
                                '${value.getFirstName + ' ' + value.getLastName}',
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
                                  // '${profile['email']}',
                                  '${value.getEmail}',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade600),
                                ),
                              ),
                            )
                          ],
                        ),
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
                        width: 170,
                        child: _edit
                            ? Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Save Changes?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                user.updateData();
                                                setState(() {
                                                  _edit = !_edit;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: TombolActionProfilePage(
                                      icon: Icons.save,
                                      title: "Save",
                                      icon_color: Colors.blue,
                                      style_title: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _edit = !_edit;
                                      });
                                    },
                                    child: TombolActionProfilePage(
                                      icon: Icons.cancel,
                                      title: "Cancel",
                                      icon_color: Colors.red,
                                      style_title: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    _edit = !_edit;
                                  });
                                },
                                child: TombolActionProfilePage(
                                  icon: Icons.edit,
                                  title: "Edit",
                                  icon_color: Colors.blue,
                                  style_title: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
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
                                        text:
                                            // '${profile['firstname']}',
                                            user.getFirstName,
                                      ),
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
                                onChanged: (value) {
                                  user.set_firstName_sementara(value);
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
                                        text:
                                            // '${profile['lastname']}',
                                            user.getLastName,
                                      ),
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
                                onChanged: (value) {
                                  user.set_lastName_sementara(value);
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
                              // onChanged: (value) {
                              //   user.set_email_sementara(value);
                              // },
                              enabled: false,
                              controller: _edit
                                  ? null
                                  : TextEditingController(
                                      text:
                                          // '${profile['email']}',
                                          '${user.getEmail}',
                                    ),
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
                                user.set_phone_number_sementara(value);
                              },
                              enabled: _edit,
                              controller: _edit
                                  ? null
                                  : TextEditingController(
                                      text:
                                          // '${profile['phone_number']}',
                                          '${value.getPhoneNumber}',
                                    ),
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {},
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  user.logout().then(
                                        (value) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SplashPage(),
                                          ),
                                        ),
                                      );
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        );
                      },
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
