import 'dart:io';
import 'dart:typed_data';
import 'package:amazing_quotes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class SaveAndShare extends StatefulWidget {
  final String image;
  final String quotes;
  final String author;
  SaveAndShare({
    required this.image,
    required this.author,
    required this.quotes,
  });
  @override
  _SaveAndShareState createState() => _SaveAndShareState();
}

class _SaveAndShareState extends State<SaveAndShare> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  bool isDownloaded = false;
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
          "Shave and Share",
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: buildImage(),
            ),
            SizedBox(height: 20),
            Visibility(
                visible: isDownloaded,
                child: Text(
                  "Your picture is saved to Gallery!",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: getShaveShareButton(
                    title: "Save",
                    icon: Icons.download,
                    color: Color(0xfff4a261),
                  ),
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (isLoading) {
                      getSnackBar(
                          context: context,
                          text: "Please wait...",
                          size: 15,
                          width: 150);
                    }
                    final image = await screenshotController
                        .captureFromWidget(buildImage());
                    // ignore: unnecessary_null_comparison
                    if (image == null) return;
                    await saveImage(bytes: image);
                  },
                ),
                SizedBox(width: 20),
                InkWell(
                  child: getShaveShareButton(
                    title: "Share",
                    icon: Icons.share,
                    color: Color(0xff9d4edd).withOpacity(0.8),
                  ),
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (isLoading) {
                      getSnackBar(
                          context: context,
                          text: "Please wait loading apps to send...",
                          size: 13,
                          width: 250);
                    }
                    final image = await screenshotController
                        .captureFromWidget(buildImage());
                    shareImage(bytes: image);
                  },
                ),
                SizedBox(width: 20),
                Visibility(
                  visible: isDownloaded,
                  child: InkWell(
                    child: getShaveShareButton(
                        title: "View",
                        icon: Icons.collections,
                        color: Colors.lightBlueAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          image: AssetImage(widget.image),
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\"${widget.quotes}\"",
              textAlign: TextAlign.center,
              style:
                  TextStyle(wordSpacing: 1, fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 15),
            Text(
              "- ${widget.author}",
              textAlign: TextAlign.center,
              style:
                  TextStyle(wordSpacing: 1, fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future shareImage({required Uint8List bytes}) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
    setState(() {
      isLoading = false;
    });
  }

  Future<String> saveImage({required Uint8List bytes}) async {
    final status = await [Permission.storage].request();
    setState(() {
      isLoading = false;
    });
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = "Quotes_$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    if (result["filePath"] != null) {
      setState(() {
        isDownloaded = true;
      });
    }
    return result["filePath"];
  }
}
