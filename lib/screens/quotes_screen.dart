import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amazing_quotes/screens/themes_screen.dart';
import 'package:amazing_quotes/screens/second_screen.dart';
import 'package:amazing_quotes/helper/quotes_helper.dart';
import 'package:amazing_quotes/models/quotes_model.dart';
import 'package:amazing_quotes/helper/image_helper.dart';
import 'package:amazing_quotes/models/image_model.dart';
import 'package:amazing_quotes/screens/save_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class QuotesScreen extends StatefulWidget {
  final String name;
  final String type;
  static String newImage = "";
  static int newId = 1;
  QuotesScreen({required this.name, required this.type});
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  late Future<List<Quotes>> fetchQuotes;
  late Future<List<ImageModel>> fetchImages;
  IconData iconFavourite = FontAwesomeIcons.star;
  @override
  void initState() {
    fetchQuotes = dbh.getDataByType(type: widget.type);
    fetchImages = dbi.getAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffedf2fb),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
      ),
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
                return ListView.builder(
                  itemCount: snapQuotes.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, 3),
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.6)),
                        ],
                        image: DecorationImage(
                          image: AssetImage(snapImages.data[index].image),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4), BlendMode.darken),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 7,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return SecondScreen(
                                      imageId: snapImages.data[index].id,
                                      quotesId: snapQuotes.data[index].id,
                                    );
                                  }),
                                ).then(
                                  (value) => refreshData(),
                                );
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\"${snapQuotes.data[index].quotes}\"",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          wordSpacing: 1,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      "- ${snapQuotes.data[index].author}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          wordSpacing: 1,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        QuotesScreen.newImage =
                                            snapImages.data[index].image;
                                        QuotesScreen.newId =
                                            snapImages.data[index].id;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ThemeScreen();
                                        })).then((value) {
                                          setState(() {
                                            dbi.updateImageById(
                                              oldId: snapImages.data[index].id,
                                              newId: QuotesScreen.newId,
                                              oldImage:
                                                  snapImages.data[index].image,
                                              newImage: QuotesScreen.newImage,
                                            );
                                          });
                                        });
                                        refreshData();
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.images,
                                        color: Colors.amber,
                                        size: 25,
                                      )),
                                  PopupMenuButton(
                                    offset: Offset(0, 50),
                                    onSelected: (popUpOption selectedOption) {
                                      String clipBoardText =
                                          "\"${snapQuotes.data[index].quotes}\"\n- ${snapQuotes.data[index].author}";
                                      setState(() {
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
                                      });
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
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return SaveAndShare(
                                              image:
                                                  snapImages.data[index].image,
                                              author:
                                                  snapQuotes.data[index].author,
                                              quotes:
                                                  snapQuotes.data[index].quotes,
                                            );
                                          }),
                                        );
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.shareAlt,
                                        size: 25,
                                        color: Colors.redAccent,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return SaveAndShare(
                                              image:
                                                  snapImages.data[index].image,
                                              author:
                                                  snapQuotes.data[index].author,
                                              quotes:
                                                  snapQuotes.data[index].quotes,
                                            );
                                          }),
                                        );
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.download,
                                        size: 25,
                                        color: Colors.green,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        int res1 = 0;
                                        int res2 = 1;
                                        int favourite =
                                            snapQuotes.data[index].addFavourite;
                                        if (favourite == 0) {
                                          res1 = await dbh.addToFavourite(
                                              id: snapQuotes.data[index].id);
                                          setState(() {
                                            iconFavourite =
                                                FontAwesomeIcons.solidStar;
                                            refreshData();
                                          });
                                        } else {
                                          res2 = await dbh.removeToFavourite(
                                              id: snapQuotes.data[index].id);
                                          setState(() {
                                            iconFavourite =
                                                FontAwesomeIcons.star;
                                            refreshData();
                                          });
                                        }
                                      },
                                      icon: FaIcon(
                                        (snapQuotes.data[index].addFavourite ==
                                                1)
                                            ? FontAwesomeIcons.solidStar
                                            : FontAwesomeIcons.star,
                                        color: Colors.blue,
                                        size: 25,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }

  refreshData() {
    setState(() {
      fetchQuotes = dbh.getDataByType(type: widget.type);
    });
  }
}

enum popUpOption {
  CopyToClipboard,
  Share,
}
