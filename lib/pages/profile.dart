import 'package:flutter/material.dart';
import '../navigation/bottom_navigation.dart';
import '../pages/login.dart';

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
                        shadowColor: Colors.black,
                        color: Color.fromARGB(50, 0, 0, 0),
                        child: IconButton(
                            padding: EdgeInsets.only(
                                left: 2, right: 2, bottom: 2, top: 2),
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
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextField(
                              // Sementara, dikarenakan ketika controllernya
                              //tetap TextEditingController, maka ketika diedit
                              //cursornya selalu ada di paling kiri, jadi ketika
                              //edit adalah true maka controllernya null
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
                                  "Firstname",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  profile['firstname'] = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextField(
                              // Sementara, dikarenakan ketika controllernya
                              //tetap TextEditingController, maka ketika diedit
                              //cursornya selalu ada di paling kiri, jadi ketika
                              //edit adalah true maka controllernya null
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
                                  "Lastname",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  profile['lastname'] = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 14),
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                profile['email'] = value;
                              });
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
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 14),
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: TextField(
                            maxLength: 13,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              setState(() {
                                profile['phone_number'] = value;
                              });
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
