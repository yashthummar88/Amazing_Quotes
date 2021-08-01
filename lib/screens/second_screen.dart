import 'package:amazing_quotes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amazing_quotes/helper/image_helper.dart';
import 'package:amazing_quotes/helper/quotes_helper.dart';
import 'package:amazing_quotes/models/image_model.dart';
import 'package:amazing_quotes/models/quotes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'save_and_share.dart';
import 'themes_screen.dart';

class SecondScreen extends StatefulWidget {
  final int quotesId;
  final int imageId;
  static String newImage = "";
  static int newId = 1;
  SecondScreen({required this.imageId, required this.quotesId});
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late Future<List<Quotes>> fetchQuotes;
  late Future<List<ImageModel>> fetchImages;
  IconData iconFavourite = FontAwesomeIcons.star;
  ScreenshotController screenshotController = ScreenshotController();
  bool textField = false;
  TextOption textOption = TextOption.Size;
  double textSize = 24;
  TextAlign textAlign = TextAlign.center;
  TextDecoration textDecoration = TextDecoration.none;
  String textQuotes = "";
  String textAuthor = "";
  bool isUpper = true;
  double opacity = 0.4;
  int opacityText = 60;
  Color textColor = Colors.white;
  String textStyle = "f1";
  WrapAlignment wrapAlignment = WrapAlignment.center;
  String tempImage = "";
  bool isLoading = false;
  @override
  void initState() {
    fetchQuotes = dbh.getDataById(id: widget.quotesId);
    fetchImages = dbi.getImageById(id: widget.imageId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchQuotes,
        builder: (context, AsyncSnapshot snapQuotes) {
          if (snapQuotes.hasError) {
            return Center(
              child: Text(snapQuotes.error.toString()),
            );
          } else if (snapQuotes.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return FutureBuilder(
              future: fetchImages,
              builder: (context, AsyncSnapshot snapImages) {
                if (snapImages.hasError) {
                  return Center(
                    child: Text(snapImages.error.toString()),
                  );
                } else if (snapImages.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                tempImage = snapImages.data[0].image;
                if (isUpper) {
                  textAuthor = "- ${snapQuotes.data[0].author}".toString();
                  textQuotes = "\"${snapQuotes.data[0].quotes}\"".toString();
                } else {
                  textQuotes = "\"${snapQuotes.data[0].quotes}\"".toUpperCase();
                  textAuthor = "- ${snapQuotes.data[0].author}".toUpperCase();
                }
                return Container(
                  child: Stack(
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: buildImage(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: textField,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.025,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.035,
                                ),
                                margin: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.001,
                                  right:
                                      MediaQuery.of(context).size.width * 0.035,
                                  left:
                                      MediaQuery.of(context).size.width * 0.035,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  color: Color(0xff121517),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              textOption = TextOption.Size;
                                            });
                                          },
                                          child: Text(
                                            "Size",
                                            style: TextStyle(
                                              color: (textOption ==
                                                      TextOption.Size)
                                                  ? Colors.white
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              textOption = TextOption.Color;
                                            });
                                          },
                                          child: Text(
                                            "Color",
                                            style: TextStyle(
                                              color: (textOption ==
                                                      TextOption.Color)
                                                  ? Colors.white
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              textOption = TextOption.Font;
                                            });
                                          },
                                          child: Text(
                                            "Font",
                                            style: TextStyle(
                                              color: (textOption ==
                                                      TextOption.Font)
                                                  ? Colors.white
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              textOption = TextOption.Alignment;
                                            });
                                          },
                                          child: Text(
                                            "Alignment",
                                            style: TextStyle(
                                              color: (textOption ==
                                                      TextOption.Alignment)
                                                  ? Colors.white
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              textOption =
                                                  TextOption.Background;
                                            });
                                          },
                                          child: Text(
                                            "Background",
                                            style: TextStyle(
                                              color: (textOption ==
                                                      TextOption.Background)
                                                  ? Colors.white
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              textField = !textField;
                                            });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    SizedBox(height: 15),
                                    if (textOption == TextOption.Size)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "TextSize",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (textSize > 15) {
                                                  textSize--;
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.040,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade800
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "A-",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            textSize.toInt().toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                                    .withOpacity(0.6)),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (textSize < 50) {
                                                  textSize++;
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.040,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade800
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "A+",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (textOption == TextOption.Alignment)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Alignment",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textAlign = TextAlign.left;
                                                wrapAlignment =
                                                    WrapAlignment.start;
                                              });
                                            },
                                            child: Icon(
                                              Icons.format_align_left,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textAlign = TextAlign.center;
                                                wrapAlignment =
                                                    WrapAlignment.center;
                                              });
                                            },
                                            child: Icon(
                                              Icons.format_align_center,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textAlign = TextAlign.right;
                                                wrapAlignment =
                                                    WrapAlignment.end;
                                              });
                                            },
                                            child: Icon(
                                              Icons.format_align_right,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (textDecoration ==
                                                    TextDecoration.none) {
                                                  textDecoration =
                                                      TextDecoration.underline;
                                                } else {
                                                  textDecoration =
                                                      TextDecoration.none;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.format_underlined,
                                              color: Colors.grey.shade600,
                                              size: 30,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isUpper = !isUpper;
                                              });
                                            },
                                            child: Icon(
                                              Icons.text_rotation_none,
                                              color: Colors.grey.shade600,
                                              size: 32,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (textOption == TextOption.Background)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Opacity",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          InkWell(
                                            child: Icon(
                                              Icons.brightness_5,
                                              color: Colors.grey.shade600,
                                              size: 30,
                                            ),
                                            onTap: () {
                                              if (opacity < 0.9) {
                                                setState(() {
                                                  print(opacity);
                                                  opacity += 0.10;
                                                  opacityText -= 10;
                                                });
                                              }
                                            },
                                          ),
                                          Text(
                                            "${opacityText.toString()}%",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          InkWell(
                                            child: Icon(
                                              Icons.brightness_high,
                                              color: Colors.grey.shade600,
                                              size: 30,
                                            ),
                                            onTap: () {
                                              if (opacity > 0.1) {
                                                setState(() {
                                                  opacity -= 0.10;
                                                  opacityText += 10;
                                                });
                                              }
                                            },
                                          ),
                                          SizedBox(height: 1),
                                        ],
                                      ),
                                    if (textOption == TextOption.Color)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Text Color",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textColor = Colors.white;
                                              });
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textColor = Colors.red;
                                              });
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textColor = Colors.amber;
                                              });
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textColor = Colors.teal;
                                              });
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              decoration: BoxDecoration(
                                                color: Colors.teal,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text("Pick a Color!"),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ColorPicker(
                                                          pickerAreaHeightPercent:
                                                              0.8,
                                                          enableAlpha: false,
                                                          onColorChanged:
                                                              (Color value) {
                                                            setState(() {
                                                              textColor = value;
                                                            });
                                                          },
                                                          pickerColor:
                                                              textColor,
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text("Save"))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              decoration: BoxDecoration(
                                                color: Colors.teal,
                                                gradient: LinearGradient(
                                                    stops: [
                                                      0.25,
                                                      0.40,
                                                      0.65,
                                                      0.80,
                                                    ],
                                                    colors: [
                                                      Colors.red,
                                                      Colors.blue,
                                                      Colors.amber,
                                                      Colors.green,
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (textOption == TextOption.Font)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Font Style",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              itemExtent: 60,
                                              children: [
                                                getInkWell(fontFamily: "f1"),
                                                getInkWell(fontFamily: "f7"),
                                                getInkWell(fontFamily: "f6"),
                                                getInkWell(fontFamily: "f8"),
                                                getInkWell(fontFamily: "f2"),
                                                getInkWell(fontFamily: "f3"),
                                                getInkWell(fontFamily: "f4"),
                                                getInkWell(fontFamily: "f5"),
                                                getInkWell(fontFamily: "f9"),
                                                getInkWell(fontFamily: "f10"),
                                                getInkWell(fontFamily: "f11"),
                                                getInkWell(fontFamily: "f12"),
                                                getInkWell(fontFamily: "f13"),
                                                getInkWell(fontFamily: "f14"),
                                                getInkWell(fontFamily: "f15"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.width * 0.035,
                                left: MediaQuery.of(context).size.width * 0.035,
                              ),
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xff121517),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.insert_photo,
                                      color: Colors.teal,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      print(snapImages.data[0].image);
                                      dbi.getImageById2(
                                          id: snapImages.data[0].id);
                                      setState(() {
                                        dbi.getImageById(
                                            id: snapImages.data[0].id);
                                        tempImage = snapImages.data[0].image;
                                        print(tempImage);
                                      });
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        textField = !textField;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.format_size,
                                      color: Colors.redAccent,
                                      size: 33,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      SecondScreen.newImage =
                                          snapImages.data[0].image;
                                      SecondScreen.newId =
                                          snapImages.data[0].id;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ThemeScreen();
                                          },
                                        ),
                                      ).then((value) async {
                                        List<ImageModel> temp =
                                            await dbi.updateImageById2(
                                          oldId: snapImages.data[0].id,
                                          newId: SecondScreen.newId,
                                          oldImage: snapImages.data[0].image,
                                          newImage: SecondScreen.newImage,
                                        );
                                        setState(() {
                                          tempImage = temp[0].image;
                                          print(temp[0].image);
                                        });
                                      });
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.images,
                                      color: Colors.amber,
                                      size: 25,
                                    ),
                                  ),
                                  PopupMenuButton(
                                    offset: Offset(0, 50),
                                    onSelected: (popUpOption selectedOption) {
                                      String clipBoardText =
                                          "\"${snapQuotes.data[0].quotes}\"\n- ${snapQuotes.data[0].author}";
                                      setState(
                                        () {
                                          if (selectedOption ==
                                              popUpOption.CopyToClipboard) {
                                            Clipboard.setData(ClipboardData(
                                                text: clipBoardText));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                width: 200,
                                                content: Text(
                                                  "Copied to clipboard",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          } else {
                                            Share.share(clipBoardText);
                                          }
                                        },
                                      );
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.solidCopy,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text("Copy Text"),
                                        value: popUpOption.CopyToClipboard,
                                      ),
                                      PopupMenuItem(
                                        child: Text("Share as Text"),
                                        value: popUpOption.Share,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (isLoading) {
                                        getSnackBar(
                                          context: context,
                                          text: "Please Wait....",
                                          size: 17,
                                          width: 200,
                                        );
                                      }
                                      final image = await screenshotController
                                          .captureFromWidget(buildImage());
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return SaveShare(
                                            bytes: image,
                                          );
                                        }),
                                      );
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.download,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        int res1 = 0;
                                        int res2 = 1;
                                        int favourite =
                                            snapQuotes.data[0].addFavourite;
                                        if (favourite == 0) {
                                          res1 = await dbh.addToFavourite(
                                              id: snapQuotes.data[0].id);
                                          setState(() {
                                            iconFavourite =
                                                FontAwesomeIcons.solidStar;
                                            refreshData();
                                          });
                                        } else {
                                          res2 = await dbh.removeToFavourite(
                                              id: snapQuotes.data[0].id);
                                          setState(() {
                                            iconFavourite =
                                                FontAwesomeIcons.star;
                                            refreshData();
                                          });
                                        }
                                      },
                                      icon: FaIcon(
                                        (snapQuotes.data[0].addFavourite == 1)
                                            ? FontAwesomeIcons.solidStar
                                            : FontAwesomeIcons.star,
                                        color: Colors.blue,
                                        size: 25,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  InkWell getInkWell({required String fontFamily}) {
    return InkWell(
      onTap: () {
        setState(() {
          textStyle = fontFamily;
        });
      },
      child: Text(
        "Sample",
        style: TextStyle(
          color: Colors.grey.shade600,
          fontFamily: fontFamily,
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(tempImage),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(opacity),
            BlendMode.darken,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Wrap(
          alignment: wrapAlignment,
          children: [
            Text(
              textQuotes,
              textAlign: textAlign,
              style: TextStyle(
                wordSpacing: 1,
                fontSize: textSize,
                color: textColor,
                decoration: textDecoration,
                fontFamily: textStyle,
              ),
            ),
            SizedBox(height: 15),
            Text(
              textAuthor,
              textAlign: textAlign,
              style: TextStyle(
                wordSpacing: 1,
                fontSize: textSize,
                color: textColor,
                decoration: textDecoration,
                fontFamily: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  refreshData() {
    fetchQuotes = dbh.getDataById(id: widget.quotesId);
    fetchImages = dbi.getImageById(id: widget.imageId);
  }
}

enum popUpOption {
  CopyToClipboard,
  Share,
}

enum TextOption {
  Size,
  Color,
  Font,
  Alignment,
  Background,
}
