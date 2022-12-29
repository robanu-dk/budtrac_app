import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_picker/list_picker.dart';
import 'package:moneytracker/pages/history.dart';
import 'package:moneytracker/pages/home.dart';
import 'package:moneytracker/provider/category_provider.dart';
import 'package:moneytracker/provider/history_provider.dart';
import 'package:moneytracker/provider/money_provider.dart';
import 'package:provider/provider.dart';
import '../controller/firebase_storage_controller.dart';

class DetailHistory extends StatefulWidget {
  Map<String, dynamic> data;

  DetailHistory(this.data);

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  final listPickerField_expense = ListPickerField(
    label: "Payment Method",
    items: const ["Cash", "Debt", "Transfer"],
  );

  final listPickerField_income = ListPickerField(
    label: "Source of Income",
    items: const ["Salary", "Debt", "Transfer"],
  );

  var date, purchase, chosen_category;

  FirebaseStorageController controller = FirebaseStorageController();

  TextEditingController nominal = TextEditingController();
  TextEditingController note = TextEditingController();

  late File file;
  bool uploadFile = false;
  bool edit = false;
  bool deleteAttachment = false;

  // Map<String, dynamic> iconDataFor = {
  //   'category': Icon(Icons.category),
  //   'nominal': Icon(Icons.monetization_on),
  //   'wallet': Icon(Icons.account_balance_wallet_rounded),
  //   'date': Icon(Icons.calendar_month),
  //   'note': Icon(Icons.note),
  //   'media': Icon(Icons.image),
  // };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(5.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Detail ${widget.data["income"] ? "Income" : "Expense"}'),
          Row(
            children: [
              action('Edit'),
              action('Delete'),
            ],
          )
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                bottom: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nominal",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(179, 56, 56, 56),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.88,
                    child: TextField(
                      enabled: edit,
                      controller: edit
                          ? nominal
                          : TextEditingController(text: widget.data['nominal']),
                      autocorrect: false,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.pink[800],
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        prefixIcon: Text(
                          "${widget.data['currency']}  ",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.pink[800],
                          ),
                        ),
                        hintText: edit ? '0' : null,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.pink[800]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                CardButton(context, "${edit ? 'Change Date' : 'Date'}"),
                CardButton(context, "${edit ? 'Change Category' : 'Category'}"),
                CardButton(context, "${edit ? 'Change Wallet' : 'Wallet'}"),
                Card(
                  elevation: 6,
                  margin: EdgeInsets.only(top: 20),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    // height: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: TextField(
                          enabled: edit,
                          controller: edit
                              ? note
                              : TextEditingController(
                                  text: widget.data['note']),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: Text("Note"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CardButton(
                    context, "${edit ? 'Change Attachment' : 'Attachment'}"),
                (widget.data['mediaUrl'] != "" && deleteAttachment)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  deleteAttachment = false;
                                });
                              },
                              child: Text(
                                "Cancel Delete Attachment",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      )
                    : (widget.data['mediaUrl'] != "" && !uploadFile)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Attachment:",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Image.network(widget.data['mediaUrl']),
                                edit
                                    ? TextButton(
                                        onPressed: () {
                                          setState(() {
                                            // uploadFile = false;
                                            deleteAttachment = true;
                                          });
                                        },
                                        child: Text(
                                          "Delete Attachment",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : Text(''),
                              ],
                            ),
                          )
                        : uploadFile
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 6.0,
                                      ),
                                      child: Text(
                                        "Preview:",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    Image.file(
                                      file,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          uploadFile = false;
                                        });
                                      },
                                      child: Text(
                                        "Delete attachment",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text('')
              ],
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          color: Colors.pink[800],
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: IconButton(
              splashRadius: MediaQuery.of(context).size.width * 0.33,
              onPressed: () {
                if (edit) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Leave now?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No")),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => HistoryPage(),
                            ));
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Text(
                "Close",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
        )
      ],
    );
  }

  Card action(String actionName) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      color: actionName == "Edit" ? Colors.blue : Colors.red,
      child: TextButton(
        onPressed: () {
          late String media, mediaUrl;
          if (actionName == "Edit") {
            if (edit) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Save Changes?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () async {
                          if (deleteAttachment) {
                            // if (widget.data['media'] != "") {
                            //   await controller.deleteImage(widget.data['media']);
                            // }
                            // await controller.deleteImage(widget.data['media']);
                            controller.deleteImage(widget.data['media']);
                            saveChanges(context, "", "");
                          } else if (uploadFile) {
                            if (widget.data['media'] == "") {
                              await controller
                                  .uploadImage(
                                      "Money", widget.data['idUser'], file)
                                  .then((value) {
                                saveChanges(context, value.split('+').first,
                                    value.split('+').last);
                              });
                            } else {
                              await controller
                                  .updateAttachmentHistory(
                                      widget.data['media'], file)
                                  .then((value) {
                                saveChanges(context, value.split('+').first,
                                    value.split('+').last);
                              });
                            }
                          } else {
                            saveChanges(context, widget.data['media'],
                                widget.data['mediaUrl']);
                          }

                          // Provider.of<HistoryProvider>(context, listen: false)
                          //     .updateDataHistory(
                          //   widget.data,
                          //   nominal.text,
                          //   this.date,
                          //   this.chosen_category,
                          //   this.purchase,
                          //   media,
                          //   mediaUrl,
                          //   note.text,
                          // );

                          setState(() {
                            edit = false;
                            deleteAttachment = false;
                          });
                          Navigator.of(context).pop();

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Save Successfully!!"),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        child: Text("Yes")),
                  ],
                ),
              );
            } else {
              setState(() {
                edit = true;
              });
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Are you sure delete this history?"),
                content:
                    Text("History that has been deleted cannot be restored"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("No")),
                  TextButton(
                    onPressed: () {
                      Provider.of<HistoryProvider>(context, listen: false)
                          .deleteHistory(widget.data['id']);
                      Navigator.pop(context);
                      // Flushbar(
                      //   message: "History has been deleted!!",
                      //   duration: Duration(seconds: 3),
                      //   flushbarPosition: FlushbarPosition.TOP,
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("History has been deleted!!"),
                        ),
                      );
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ).then((_) {
              Navigator.pop(context);
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              actionName == "Edit"
                  ? edit
                      ? Icons.save
                      : Icons.edit
                  : Icons.delete,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                actionName == "Edit"
                    ? edit
                        ? "Save"
                        : actionName
                    : actionName,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveChanges(BuildContext context, String media, String mediaUrl) {
    Provider.of<HistoryProvider>(context, listen: false).updateDataHistory(
      widget.data,
      nominal.text,
      this.date,
      this.chosen_category,
      this.purchase,
      media,
      mediaUrl,
      note.text,
    );
  }

  Card CardButton(BuildContext context, String content) {
    final category = Provider.of<Category>(context, listen: false);
    final income = Provider.of<Money>(context, listen: false);
    final categories = widget.data['income']
        ? category.get_category_income
        : category.get_category_expense;

    DateTime date = DateTime.parse(widget.data['date']);
    String purchase = widget.data['wallet'];

    Map<String, dynamic> chosen_category = [
      ...category.get_category_expense,
      ...category.get_category_income
    ].firstWhere((element) => element['name'] == widget.data['category'])
        as Map<String, dynamic>;

    return Card(
      elevation: 6,
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.93,
        height: 60.0,
        child: Consumer<Money>(
          builder: (context, value, child) => IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.465,
            onPressed: () {
              switch (content) {
                case "Change Date":
                  showDatePicker(
                    context: context,
                    initialDate: this.date ?? date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        this.date = value;
                      });
                    }
                  });
                  break;
                case "Change Category":
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return Dialog(
                        insetPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: GridView.count(
                            crossAxisCount: 4,
                            children: categories
                                .map((data) => Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)),
                                      ),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: IconButton(
                                          splashRadius: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? 350
                                              : 60,
                                          onPressed: () {
                                            setState(() {
                                              this.chosen_category =
                                                  data as Map<String, dynamic>;
                                            });
                                            Navigator.pop(context);
                                          },
                                          icon: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                data["image"],
                                                height: 35,
                                              ),
                                              Text(
                                                data["name"],
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    }),
                  );
                  break;
                case "Change Wallet":
                  showPickerDialog(
                    context: context,
                    label: widget.data["income"]
                        ? listPickerField_income.label
                        : listPickerField_expense.label,
                    items: widget.data["income"]
                        ? listPickerField_income.items
                        : listPickerField_expense.items,
                  ).then(
                    (value) {
                      setState(() {
                        if (this.purchase == null && value == null) {
                          this.purchase = purchase;
                        } else {
                          this.purchase =
                              value == null ? this.purchase : value.toString();
                        }
                      });
                    },
                  );
                  break;
                case "Change Attachment":
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: (MediaQuery.of(context).orientation ==
                                Orientation.landscape)
                            ? MediaQuery.of(context).size.height * 0.30
                            : MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width * 1,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                            children: [
                              selectFileButton("Camera"),
                              selectFileButton("Gallery"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  break;
                default:
              }
            },
            icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  content == "Attachment" || content == "Change Attachment"
                      ? Row(
                          children: [
                            Transform.rotate(
                              angle: -45,
                              child: Icon(Icons.attachment_outlined),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                content,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 110, 110, 110)),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          content,
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                  content == "Date" || content == "Change Date"
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                  "${this.date == null ? DateFormat.yMMMMd("en_us").format(date) : DateFormat.yMMMMd("en_us").format(this.date)}"),
                            ),
                            Icon(Icons.calendar_month),
                          ],
                        )
                      : content == "Category" || content == "Change Category"
                          ? edit
                              ? Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(this.chosen_category ==
                                                  null
                                              ? chosen_category['name']
                                              : this.chosen_category['name']),
                                        ),
                                        Image.asset(
                                          this.chosen_category == null
                                              ? chosen_category['image']
                                              : this.chosen_category['image'],
                                          width: 25,
                                        ),
                                      ]),
                                    ),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(this.chosen_category ==
                                                  null
                                              ? chosen_category['name']
                                              : this.chosen_category['name']),
                                        ),
                                        Image.asset(
                                          this.chosen_category == null
                                              ? chosen_category['image']
                                              : this.chosen_category['image'],
                                          width: 25,
                                        ),
                                      ]),
                                    ),
                                  ],
                                )
                          : content == "Wallet" || content == "Change Wallet"
                              ? edit
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child:
                                              Text(this.purchase ?? purchase),
                                        ),
                                        Icon(Icons.keyboard_arrow_down)
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(purchase),
                                        ),
                                      ],
                                    )
                              : Text(""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card selectFileButton(String source) {
    void selectFile(String source) async {
      if (source == "Camera") {
        await controller.selectImageFromCamera().then((value) {
          setState(() {
            file = value;
          });
        });
      } else {
        await controller.selectImageFromGallery().then((value) {
          setState(() {
            file = value;
          });
        });
      }

      // Change uploadFile status
      setState(() {
        uploadFile = true;
        deleteAttachment = false;
      });

      // Pop context
      Navigator.of(context).pop();
    }

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
              source == "Camera"
                  ? Icons.camera_alt_rounded
                  : Icons.perm_media_sharp,
              size: 50,
            ),
            Text(source),
          ],
        ),
        onPressed: () {
          selectFile(source);
        },
      ),
    );
  }

  // Row rowInformation(BuildContext context, String dataFor) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           iconDataFor[dataFor],
  //           Padding(
  //             padding: const EdgeInsets.only(left: 8.0),
  //             child: Text(
  //               "${dataFor[0].toUpperCase() + dataFor.substring(1)}",
  //               style: TextStyle(color: Colors.grey[600]),
  //             ),
  //           ),
  //         ],
  //       ),
  //       dataFor == "category"
  //           ? Row(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 8.0),
  //                   child: SizedBox(
  //                     width: MediaQuery.of(context).size.width * 0.35,
  //                     child: Text(
  //                       '${widget.data[dataFor]}',
  //                       textAlign: TextAlign.end,
  //                     ),
  //                   ),
  //                 ),
  //                 CircleAvatar(
  //                   child: Image.asset(widget.category_image),
  //                   backgroundColor: Colors.black,
  //                 )
  //               ],
  //             )
  //           : dataFor == "nominal"
  //               ? Row(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(right: 8.0),
  //                       child: SizedBox(
  //                         width: MediaQuery.of(context).size.width * 0.35,
  //                         child: Text(
  //                           '${widget.data[dataFor]}',
  //                           textAlign: TextAlign.end,
  //                         ),
  //                       ),
  //                     ),
  //                     CircleAvatar(
  //                       child: Text(
  //                         '${widget.data['currency']}',
  //                         style: TextStyle(
  //                             color: Colors.black, fontWeight: FontWeight.bold),
  //                       ),
  //                       backgroundColor: Color.fromARGB(255, 211, 210, 210),
  //                     )
  //                   ],
  //                 )
  //               : SizedBox(
  //                   width: MediaQuery.of(context).size.width * 0.35,
  //                   child: Text(
  //                     '${dataFor == "date" ? DateFormat.yMMMMd().format(DateTime.parse(widget.data["date"])) : widget.data[dataFor]}',
  //                     textAlign: TextAlign.end,
  //                   ),
  //                 ),
  //     ],
  //   );
  // }
}
