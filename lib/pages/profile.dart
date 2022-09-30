import 'package:flutter/material.dart';
import '../navigation/bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> profile = {
    'firstname': 'Contoh',
    'lastname': 'Pengguna',
    'email': 'contoh_pengguna@gmail.com',
    'phone_number': '082011633000',
    'image_profile': 'images/profile.png'
  };
  bool _change_image = false;
  bool _edit = false;
  Icon _edit_icon = Icon(Icons.edit);
  String _edit_text = 'edit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                        shadowColor: Colors.white,
                        color: Colors.grey.shade400,
                        child: IconButton(
                            splashRadius: 10,
                            iconSize: 120,
                            onPressed: () {
                              _change_image ? print('change') : null;
                            },
                            icon: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Image.asset('${profile['image_profile']}'),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${profile['firstname'] + ' ' + profile['lastname']}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              '${profile['email']}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade600),
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
                height: 330,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            if (_edit) {
                              setState(() {
                                _edit = false;
                                _edit_icon = Icon(Icons.edit);
                                _edit_text = 'Edit';
                              });
                            } else {
                              setState(() {
                                _edit = true;
                                _edit_icon = Icon(Icons.save);
                                _edit_text = 'Save';
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _edit_icon,
                              Text(
                                _edit_text,
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
                            width: 175,
                            child: TextField(
                              enabled: _edit,
                              autocorrect: false,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(),
                                border: _edit
                                    ? UnderlineInputBorder()
                                    : InputBorder.none,
                                labelText: "Firstname",
                              ),
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                          Container(
                            width: 175,
                            child: TextField(
                              enabled: _edit,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  border: _edit
                                      ? UnderlineInputBorder()
                                      : InputBorder.none,
                                  labelText: "Lastname"),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomNavigation(2));
  }
}
