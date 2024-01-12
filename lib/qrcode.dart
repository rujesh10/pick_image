import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myqrcode/dispay.dart';
import 'package:myqrcode/image.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/scan.dart';
import 'package:toggle_switch/toggle_switch.dart';

class QrcodeTest extends StatefulWidget {
  const QrcodeTest({super.key});

  @override
  State<QrcodeTest> createState() => _QrcodeTestState();
}

class _QrcodeTestState extends State<QrcodeTest> {
  List<bool> isSelected = [true, false];

  qrData() {
    var data = {
      "accountName": "Ankit Shrestha",
      "accountNumber": "01044751324662",
      "bankCode": "Prabhu Bank Ltd"
    };
    return jsonEncode(data);
  }

  PageController page = PageController(initialPage: 0);
  File _file = File("");
  File _sample = File("");
  File? cropimage;

  ScanController controller = ScanController();
  final cropKey = GlobalKey<CropState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _sample.path.isEmpty
            ? Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.036),
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromARGB(255, 177, 24, 13),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            "Scan Or Share",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: ToggleButtons(
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.red,
                            children: [
                              Container(
                                height: 20, // increased the height
                                width: MediaQuery.of(context).size.width * 0.47,
                                child: Center(
                                    child: Text(
                                  "Scan",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ),
                              Container(
                                height: 20, // increased the height
                                width: MediaQuery.of(context).size.width * 0.47,
                                child: Center(
                                    child: Text(
                                  "Share",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                            fillColor: Colors.white,
                            selectedColor: Colors.black,
                            isSelected: isSelected,
                            color: Colors.white,
                            onPressed: (index) {
                              setState(() {
                                for (int i = 0; i < isSelected.length; i++) {
                                  if (i == index) {
                                    isSelected[i] = true;
                                  } else {
                                    isSelected[i] = false;
                                  }
                                  if (index == 1) {
                                    page.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut);
                                  } else {
                                    page.previousPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut);
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 120, left: 11, right: 11),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          // color: Colors.green,
                          child: PageView(
                            onPageChanged: (index) {
                              setState(() {
                                if (index == 0) {
                                  isSelected[0] = true;
                                  isSelected[1] = false;
                                } else {
                                  isSelected[0] = false;
                                  isSelected[1] = true;
                                }
                              });
                            },
                            controller: page,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                color: Colors.black,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ScanView(
                                      onCapture: (data) {
                                        message(data);

                                        controller.resume();
                                      },
                                      controller: controller,
                                      scanAreaScale: .5,
                                      scanLineColor: Colors.blue,
                                    ),
                                    Positioned(
                                      top: 10,
                                      child: SizedBox(
                                        height: 50,
                                        width: 60,
                                        child: Image.asset(
                                            "assets/images/fonepay.png"),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 40,
                                      child: Center(
                                        child: SizedBox(
                                          child: Text(
                                            "Scan to Pay on Merchant outlets",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 290,
                                      top: 10,
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: GestureDetector(
                                          onTap: () {
                                            pickImageFormGallery();
                                          },
                                          child: Icon(
                                            Icons.photo,
                                            size: 28,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              spreadRadius: 0.5)
                                        ]),
                                    height: 120,
                                    // color: Colors.white,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Ankit Khakda",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 7,
                                                              right: 7,
                                                              top: 5,
                                                              bottom: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.green),
                                                      // color: Colors.green,

                                                      child: const Center(
                                                        child: Text(
                                                          "PRIMARY",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height: 10,
                                                // ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                    "SPECIAL SAVINGS",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "39071341656689",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Icon(
                                                    Icons.share,
                                                    size: 35,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                            color: Colors.grey, width: 0.20)),
                                    height: 500,
                                    width: 500,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1)),
                                            // color: Colors.green,
                                            height: 200,
                                            width: 330,
                                            child: QrImage(
                                              data: qrData(),
                                              version: QrVersions.auto,
                                              size: 170,
                                              gapless: false,
                                              embeddedImage: AssetImage(
                                                  'assets/images/my_embedded_image.png'),
                                              embeddedImageStyle:
                                                  QrEmbeddedImageStyle(
                                                size: Size(80, 80),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width: 330,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Image.asset(
                                            "assets/images/prabhu.png",
                                            scale: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          // color: Colors.blue,
                                          width: 330,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,

                                          decoration: BoxDecoration(
                                              color: Color(0xfff7f7ff),
                                              border: Border.all(
                                                  color: Colors.blue,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 10),
                                                      child: Icon(
                                                        Icons.info_outline,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 250,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          "You will be sharing the following information",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 60,
                                                            bottom: 10),
                                                    child: Text(
                                                      "1. Full Name",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 50,
                                                            bottom: 10),
                                                    child: Text(
                                                      "2. Bank Name",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            bottom: 10),
                                                    child: Text(
                                                      "3. Bank Account Number",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    // color: Colors.pink,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Container(
                child: cropImage(),
              ));
  }

  message(value) {
    var data = jsonDecode(value);
    var accountName = data["accountName"];
    var accountNumber = data["accountNumber"];
    var bankCode = data["bankCode"];

    // Fluttertoast.showToast(
    //     msg: "$bankCode\n $accountName\n $accountNumber",
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.TOP,
    //     timeInSecForIosWeb: 3,
    //     backgroundColor: Colors.blue,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pop(context);
        });
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    accountNumber,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15.0,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    accountName,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15.0,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    bankCode,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15.0,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 0), end: const Offset(0, 0.05))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  pickImageFormGallery() async {
    var pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    var imagePath = File(pickImage!.path);
    print(imagePath);
    final sample = await ImageCrop.sampleImage(
        file: imagePath, preferredSize: context.size?.longestSide.ceil());
    setState(() {
      _sample = sample;
      _file = imagePath;
    });
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ImageFromGallery(
    //         filePath: imagePath,
    //       ),
    //     )
    //     );
  }

  Widget cropImage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _sample = File("");
                  });
                },
                icon: Icon(Icons.arrow_back),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  cropedImage();
                },
                icon: Icon(
                  Icons.check,
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Crop.file(
          _sample,
          key: cropKey,
        )),
      ],
    );
  }

  cropedImage() async {
    final crop = cropKey.currentState;

    final scale = crop?.scale;
    final area = crop?.area;

    if (area == null) {}
    final sampledFile = await ImageCrop.sampleImage(
        file: _file, preferredSize: (2000 / scale!).round());

    final croppedFile = await ImageCrop.cropImage(
      file: sampledFile,
      area: area!,
    );
    cropimage = croppedFile;
    String? result = await Scan.parse(cropimage!.path);
    message(result);
    print(result);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Display(
                  displayform: result,
                )));
  }
}
