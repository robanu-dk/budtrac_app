import 'dart:io';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:country_icons/country_icons.dart';
import 'package:intl/intl.dart';
import 'package:list_picker/list_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import './home.dart';
import '../widget/walletCard.dart';
import '../widget/categoryCard.dart';
import '../widget/saveDataAlertIncomeExpense.dart';
import '../widget/alertCannotSave.dart';
import '../provider/money_provider.dart';
import '../provider/category_provider.dart';
import '../controller/firebase_storage_controller.dart';

class InputExpensePage extends StatefulWidget {
  InputExpensePage({Key? key}) : super(key: key);

  @override
  State<InputExpensePage> createState() => _InputExpensePageState();
}

class _InputExpensePageState extends State<InputExpensePage> {
  FirebaseStorageController controller = FirebaseStorageController();

  Map<String, dynamic> chosen_category = {};

  final listPickerField = ListPickerField(
    label: "Payment Method",
    items: const ["Cash", "Debt", "Transfer"],
  );
  String purchase = "Transfer";
  DateTime date = DateTime.now();
  String note = "";

  TextEditingController nominal = TextEditingController();

  late File file;
  bool uploadFile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Input Expense",
            style: TextStyle(fontSize: 24),
          ),
          foregroundColor: Colors.pink[800],
          backgroundColor: Color.fromARGB(255, 235, 235, 235),
        ),
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 45.0,
                bottom: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How much?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(179, 56, 56, 56),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.88,
                    child: TextField(
                      controller: nominal,
                      autocorrect: false,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.pink[800],
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Consumer<Money>(
                          builder: (context, value, child) => Text(
                            "${value.getCurrcencySymbol}.",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.pink[800],
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "0",
                        hintStyle: TextStyle(color: Colors.pink[800]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              color: Color.fromARGB(255, 253, 244, 247),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  CardButton(context, "Currency"),
                  CardButton(context, "Date"),
                  CardButton(context, "Category"),
                  CardButton(context, "Wallet"),
                  Card(
                    elevation: 6,
                    margin: EdgeInsets.only(top: 20),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.93,
                      height: 60.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                note = value;
                              });
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text("Description"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CardButton(context, "Add attachment"),
                  uploadFile
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
                                width: MediaQuery.of(context).size.width * 1,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 50, right: 50),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: SaveButton(
                                    nominal: nominal.text,
                                    chosen_category: chosen_category,
                                    purchase: purchase,
                                    file: file,
                                    note: note,
                                    date: date,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 50, right: 50),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            child: SaveButton(
                              nominal: nominal.text,
                              chosen_category: chosen_category,
                              purchase: purchase,
                              note: note,
                              date: date,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        )

        // Old Design
        // ListView(children: [
        //   Card(
        //     shape: RoundedRectangleBorder(
        //         side: BorderSide(color: Colors.grey.shade300),
        //         borderRadius: BorderRadius.all(Radius.circular(2))),
        //     child: Container(
        //       padding: EdgeInsets.only(left: 10),
        //       height: 80,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Row(
        //             children: [
        //               Icon(Icons.monetization_on),
        //               Text(' Nominal'),
        //             ],
        //           ),
        //           Consumer<Money>(
        //             builder: (context, value, child) => Row(
        //               children: [
        //                 Container(
        //                   width: 100,
        //                   height: 22,
        //                   child: TextField(
        //                     autofocus: true,
        //                     autocorrect: false,
        //                     decoration: InputDecoration(
        //                       prefixText: money.getCurrcencySymbol,
        //                       hintStyle:
        //                           TextStyle(color: Colors.grey, fontSize: 14),
        //                     ),
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                     textAlign: TextAlign.end,
        //                     keyboardType: TextInputType.number,
        //                     onChanged: (value) {
        //                       setState(() {
        //                         nominal = value;
        //                       });
        //                     },
        //                   ),
        //                 ),
        //                 Container(
        //                   width: MediaQuery.of(context).orientation ==
        //                           Orientation.portrait
        //                       ? MediaQuery.of(context).size.width * 0.24
        //                       : MediaQuery.of(context).size.width * 0.15,
        //                   child: IconButton(
        //                     onPressed: () {
        //                       showCurrencyPicker(
        //                         context: context,
        //                         showFlag: true,
        //                         showCurrencyName: true,
        //                         showCurrencyCode: true,
        //                         onSelect: (Currency currency) {
        //                           money.currency(
        //                             currencyCode: currency.code,
        //                             currencySymbol: currency.symbol,
        //                             countryFlagCode:
        //                                 (currency.code[0] + currency.code[1])
        //                                     .toLowerCase(),
        //                           );
        //                         },
        //                       );
        //                     },
        //                     icon: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Container(
        //                             decoration: BoxDecoration(
        //                                 border: Border.all(
        //                                     color: Colors.grey.shade300)),
        //                             child: Image.asset(
        //                               'icons/flags/png/${money.getCountryFlagCode}.png',
        //                               package: 'country_icons',
        //                               width: 20,
        //                             ),
        //                           ),
        //                           Text(' ${money.getCurrcencyCode}'),
        //                           Icon(Icons.arrow_drop_down)
        //                         ]),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   Card(
        //     shape: RoundedRectangleBorder(
        //         side: BorderSide(color: Colors.grey.shade300),
        //         borderRadius: BorderRadius.all(Radius.circular(2))),
        //     child: IconButton(
        //       splashRadius:
        //           MediaQuery.of(context).orientation == Orientation.landscape
        //               ? 350
        //               : 210,
        //       iconSize: 50,
        //       icon: WalletCard(purchase: purchase),
        //       onPressed: () {
        //         showPickerDialog(
        //                 context: context,
        //                 label: listPickerField.label,
        //                 items: listPickerField.items)
        //             .then(
        //           (value) {
        //             setState(() {
        //               (value == null)
        //                   ? purchase = purchase
        //                   : purchase = value.toString();
        //             });
        //           },
        //         );
        //       },
        //     ),
        //   ),
        //   Card(
        //     shape: RoundedRectangleBorder(
        //         side: BorderSide(color: Colors.grey.shade300),
        //         borderRadius: BorderRadius.all(Radius.circular(2))),
        //     child: IconButton(
        //       splashRadius:
        //           MediaQuery.of(context).orientation == Orientation.landscape
        //               ? 350
        //               : 210,
        //       iconSize: 50,
        //       onPressed: () {
        //         showDialog(
        //           context: context,
        //           builder: ((context) {
        //             return Dialog(
        //               insetPadding:
        //                   EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        //               alignment: Alignment.bottomCenter,
        //               child: Container(
        //                 padding: EdgeInsets.all(8),
        //                 height: MediaQuery.of(context).size.height * 0.5,
        //                 child: GridView.count(
        //                   crossAxisCount: 4,
        //                   children: category.get_category_expense
        //                       .map((data) => Card(
        //                             shape: RoundedRectangleBorder(
        //                               side:
        //                                   BorderSide(color: Colors.grey.shade300),
        //                               borderRadius:
        //                                   BorderRadius.all(Radius.circular(2)),
        //                             ),
        //                             child: Container(
        //                               width: 100,
        //                               height: 100,
        //                               child: IconButton(
        //                                 splashRadius: 60,
        //                                 onPressed: () {
        //                                   setState(() {
        //                                     chosen_category = data;
        //                                   });
        //                                   Navigator.pop(context);
        //                                 },
        //                                 icon: Column(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.center,
        //                                   children: [
        //                                     Image.asset(
        //                                       data["image"],
        //                                       height: 35,
        //                                     ),
        //                                     Text(
        //                                       data["name"],
        //                                       overflow: TextOverflow.ellipsis,
        //                                     )
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ))
        //                       .toList(),
        //                 ),
        //               ),
        //             );
        //           }),
        //         );
        //       },
        //       icon: CategoryCard(chosen_category: chosen_category),
        //     ),
        //   ),
        //   Card(
        //     shape: RoundedRectangleBorder(
        //         side: BorderSide(color: Colors.grey.shade300),
        //         borderRadius: BorderRadius.all(Radius.circular(2))),
        //     child: IconButton(
        //       splashRadius:
        //           MediaQuery.of(context).orientation == Orientation.landscape
        //               ? 350
        //               : 210,
        //       iconSize: 50,
        //       onPressed: () {
        //         showDatePicker(
        //           context: context,
        //           initialDate: date,
        //           firstDate: DateTime(2000),
        //           lastDate: DateTime(2100),
        //         ).then((value) {
        //           if (value != null) {
        //             setState(() {
        //               date = value;
        //             });
        //           }
        //         });
        //       },
        //       icon: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Row(
        //             children: [
        //               Icon(
        //                 Icons.calendar_month_outlined,
        //                 size: 28,
        //               ),
        //               Text(" Date"),
        //             ],
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(right: 7.5),
        //             child: Text("${DateFormat.yMMMMd("en_us").format(date)}"),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        //   Card(
        //     shape: RoundedRectangleBorder(
        //         side: BorderSide(color: Colors.grey.shade300),
        //         borderRadius: BorderRadius.all(Radius.circular(2))),
        //     child: Padding(
        //       padding: const EdgeInsets.only(bottom: 8.0),
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(left: 8.0),
        //             child: Icon(
        //               Icons.note_add,
        //               size: 28,
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.86,
        //             child: TextField(
        //               keyboardType: TextInputType.text,
        //               decoration: InputDecoration(
        //                 border: InputBorder.none,
        //                 label: Text(" Note"),
        //               ),
        //               onChanged: (value) {
        //                 setState(() {
        //                   note = value;
        //                 });
        //               },
        //               maxLines: 5,
        //               minLines: 1,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   Card(
        //     shape: RoundedRectangleBorder(
        //       side: BorderSide(color: Colors.grey.shade300),
        //       borderRadius: BorderRadius.all(Radius.circular(2)),
        //     ),
        //     child: IconButton(
        //       iconSize: 50,
        //       splashRadius:
        //           MediaQuery.of(context).orientation == Orientation.landscape
        //               ? 350
        //               : 210,
        //       onPressed: () {
        //         showDialog(
        //           context: context,
        //           builder: (context) => Dialog(
        //             insetPadding:
        //                 EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        //             alignment: Alignment.bottomCenter,
        //             child: Container(
        //               height: (MediaQuery.of(context).orientation ==
        //                       Orientation.landscape)
        //                   ? MediaQuery.of(context).size.height * 0.22
        //                   : MediaQuery.of(context).size.height * 0.15,
        //               width: MediaQuery.of(context).size.width * 1,
        //               child: SingleChildScrollView(
        //                 scrollDirection: Axis.vertical,
        //                 child: Row(
        //                   children: [
        //                     SelectImageButton("Camera"),
        //                     SelectImageButton("Gallery"),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //       icon: Row(
        //         children: [
        //           Icon(
        //             Icons.photo,
        //             size: 28,
        //           ),
        //           Text(" Upload a Image"),
        //         ],
        //       ),
        //     ),
        //   ),
        //   uploadStat
        //       ? Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 8.0),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 "Preview",
        //                 style: TextStyle(color: Colors.blue),
        //               ),
        //               Center(
        //                 child: Image.file(file),
        //               ),
        //               Container(
        //                 alignment: Alignment.centerRight,
        //                 child: TextButton(
        //                   onPressed: () {
        //                     setState(() {
        //                       uploadStat = false;
        //                     });
        //                   },
        //                   child: Text(
        //                     "Delete",
        //                     style: TextStyle(
        //                       color: Colors.red,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 padding: EdgeInsets.only(
        //                     top: 10.0, left: 50, right: 50, bottom: 20),
        //                 width: MediaQuery.of(context).size.width * 1,
        //                 child: SaveButton(
        //                     nominal: nominal,
        //                     purchase: purchase,
        //                     chosen_category: chosen_category,
        //                     date: date,
        //                     note: note,
        //                     file: file,
        //                     incomeStat: false),
        //               )
        //             ],
        //           ),
        //         )
        //       : Padding(
        //           padding: const EdgeInsets.only(top: 30.0, left: 50, right: 50),
        //           child: SaveButton(
        //               nominal: nominal,
        //               purchase: purchase,
        //               chosen_category: chosen_category,
        //               date: date,
        //               note: note,
        //               incomeStat: false),
        //         )
        // ]),
        );
  }

  Card CardButton(BuildContext context, String content) {
    final category = Provider.of<Category>(context, listen: false);
    final income = Provider.of<Money>(context, listen: false);

    return Card(
      elevation: 6,
      margin: content == "Currency"
          ? EdgeInsets.only(top: 30)
          : EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        side: content == "Currency"
            ? BorderSide(width: 0.1)
            : BorderSide(width: 0.5),
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
                case "Currency":
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      income.currency(
                          currencyCode: currency.code,
                          currencySymbol: currency.symbol,
                          countryFlagCode: (currency.code[0] + currency.code[1])
                              .toLowerCase());
                    },
                  );
                  break;
                case "Date":
                  showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        date = value;
                      });
                    }
                  });
                  break;
                case "Category":
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
                            children: category.get_category_expense
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
                                              chosen_category = data;
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
                case "Wallet":
                  showPickerDialog(
                          context: context,
                          label: listPickerField.label,
                          items: listPickerField.items)
                      .then(
                    (value) {
                      setState(() {
                        purchase = value == null ? purchase : value.toString();
                      });
                    },
                  );
                  break;
                case "Add attachment":
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
                  content == "Add attachment"
                      ? Row(
                          children: [
                            Transform.rotate(
                              angle: -45,
                              child: Icon(Icons.attachment_outlined),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(content),
                            ),
                          ],
                        )
                      : Text(
                          content,
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                  content == "Currency"
                      ? Row(
                          children: [
                            Container(
                              color: Colors.black,
                              child: Image.asset(
                                'icons/flags/png/${value.getCountryFlagCode}.png',
                                package: 'country_icons',
                                width: 35,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(value.getCurrcencyCode),
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        )
                      : content == "Date"
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                      "${DateFormat.yMMMMd("en_us").format(date)}"),
                                ),
                                Icon(Icons.calendar_month),
                              ],
                            )
                          : content == "Category"
                              ? Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: chosen_category.length == 0
                                          ? Text("none")
                                          : Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                    chosen_category['name']),
                                              ),
                                              Image.asset(
                                                chosen_category['image'],
                                                width: 25,
                                              ),
                                            ]),
                                    ),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                )
                              : content == "Wallet"
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(purchase),
                                        ),
                                        Icon(Icons.keyboard_arrow_down)
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
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    required this.nominal,
    required this.purchase,
    required this.chosen_category,
    required this.date,
    required this.note,
    this.file = "",
  });

  final String nominal, purchase, note;
  final Map<String, dynamic> chosen_category;
  final DateTime date;
  final file;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[800],
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        splashRadius: 160,
        iconSize: 28,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => (nominal == '' || chosen_category.length == 0)
                ? AlertCantSave(
                    incomeExpense: true,
                  )
                : SaveData(
                    nominal: nominal,
                    purchase: purchase,
                    chosen_category: chosen_category,
                    date: date,
                    note: note,
                    file: file,
                    incomeStat: false,
                  ),
          );
        },
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.save,
              color: Colors.white,
            ),
            Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
