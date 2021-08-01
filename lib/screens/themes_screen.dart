import 'package:amazing_quotes/helper/image_helper.dart';
import 'package:amazing_quotes/screens/quotes_screen.dart';
import 'package:flutter/material.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late Future fetchImages;
  @override
  void initState() {
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
          "Choose Theme",
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
      ),
      body: FutureBuilder(
        future: fetchImages,
        builder: (context, AsyncSnapshot snapImages) {
          if (snapImages.hasError) {
            return Center(
              child: Text(snapImages.error.toString()),
            );
          } else if (snapImages.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 3 / 6,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapImages.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
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
                    ),
                    onTap: () {
                      setState(() {
                        QuotesScreen.newImage = snapImages.data[index].image;
                        QuotesScreen.newId = snapImages.data[index].id;
                        Navigator.of(context).pop();
                      });
                    },
                  );
                }),
          );
        },
      ),
    );
  }
}
