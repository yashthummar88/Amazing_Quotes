import 'dart:io';
import 'dart:typed_data';
import 'package:amazing_quotes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class SaveShare extends StatefulWidget {
  final Uint8List bytes;
  SaveShare({required this.bytes});
  @override
  _SaveShareState createState() => _SaveShareState();
}

class _SaveShareState extends State<SaveShare> {
  bool isLoading = false;
  bool isDownloaded = false;
  String? path;
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
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.memory(widget.bytes),
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

                    // ignore: unnecessary_null_comparison
                    if (widget.bytes == null) return;
                    path = await saveImage(bytes: widget.bytes);
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

                    shareImage(bytes: widget.bytes);
                  },
                ),
                SizedBox(width: 20),
                Visibility(
                  visible: isDownloaded,
                  child: InkWell(
                    onTap: () async {
                      int location = WallpaperManager
                          .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
                      String result;
                      try {
                        result = await WallpaperManager.setWallpaperFromFile(
                            path, location);
                      } on PlatformException {
                        result = 'Failed to get wallpaper.';
                      }
                      print("Result := $result,$location");
                    },
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
    var result = await ImageGallerySaver.saveImage(bytes, name: name);
    if (result["filePath"] != null) {
      setState(() {
        isDownloaded = true;
      });
    }
    return result["filePath"];
  }
}
