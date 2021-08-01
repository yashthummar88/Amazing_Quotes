import 'dart:math';

import 'package:amazing_quotes/helper/image_helper.dart';
import 'package:amazing_quotes/helper/quotes_helper.dart';
import 'package:amazing_quotes/models/image_model.dart';
import 'package:amazing_quotes/models/quotes_model.dart';
import 'package:amazing_quotes/screens/category_screen.dart';
import 'package:amazing_quotes/screens/favourite_screen.dart';
import 'package:amazing_quotes/screens/second_screen.dart';
import 'package:amazing_quotes/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();
  late Future<List<Quotes>> fetchQuotes;
  late Future<List<ImageModel>> fetchImages;
  @override
  void initState() {
    dbh.initDB();
    dbi.initDB();
    fetchQuotes = dbh.getAllData();
    fetchImages = dbi.getAllImages();
    super.initState();
  }

  int getRandomNumber({required int n}) {
    int number = random.nextInt(10);
    if (number == 0) {
      return 1;
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text(
          "Amazing Quotes",
          style: TextStyle(color: Colors.white, fontSize: 23, letterSpacing: 1),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return FavouriteScreen();
                  }),
                );
              },
              icon: Icon(
                Icons.star,
                size: 28,
              )),
        ],
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
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Column(
                        children: [
                          CarouselSlider(
                            items: [
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                              [getRandomNumber(n: 10), getRandomNumber(n: 35)],
                            ].map((e) {
                              return Builder(
                                builder: (context) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SecondScreen(
                                                imageId: e[1] + 1,
                                                quotesId: e[0] + 1);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            snapImages.data[e[1]].image,
                                          ),
                                          colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.4),
                                            BlendMode.darken,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                027,
                                        child: Text(
                                          "\"${snapQuotes.data[e[0]].quotes}\"",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              wordSpacing: 1,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 14 / 9,
                              viewportFraction: 0.9,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding:
                                EdgeInsets.only(top: 8, right: 10, left: 10),
                            height: MediaQuery.of(context).size.height * 0.350,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Most Popular",
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    getContainer(
                                      context: context,
                                      title: "Love Quotes",
                                      image: "assets/images/q1.jpg",
                                      type: "LOVE",
                                      name: "Love",
                                    ),
                                    getContainer(
                                      context: context,
                                      title: "Swami\nVivekananda Quotes",
                                      image: "assets/images/q2.jpg",
                                      type: "LOVE",
                                      name: "Swami Vivekananda",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    getContainer(
                                      context: context,
                                      title: "Albert Einstein Quotes",
                                      image: "assets/images/q3.jpg",
                                      type: "LOVE",
                                      name: "Albert Einstein",
                                    ),
                                    getContainer(
                                      context: context,
                                      title: "Motivational Quotes",
                                      image: "assets/images/q4.jpg",
                                      type: "LOVE",
                                      name: "Motivational",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 8, right: 10, left: 10),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Quotes by category",
                                      style: TextStyle(
                                          fontSize: 15,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(CategoryScreen.routes);
                                      },
                                      child: Text(
                                        "View All >",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    getContainer(
                                      context: context,
                                      title: "Attitude Quotes",
                                      image: "assets/images/q5.jpg",
                                      type: "ATTITUDE",
                                      name: "Attitude",
                                    ),
                                    getContainer(
                                      context: context,
                                      title: "Bravery Quotes",
                                      image: "assets/images/q6.jpg",
                                      type: "LOVE",
                                      name: "Bravery",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    getContainer(
                                      context: context,
                                      title: "Friendship Quotes",
                                      type: "LOVE",
                                      image: "assets/images/q7.jpg",
                                      name: "Friendship",
                                    ),
                                    getContainer(
                                      context: context,
                                      title: "Hope Quotes",
                                      image: "assets/images/q8.jpg",
                                      type: "LOVE",
                                      name: "Hope",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
