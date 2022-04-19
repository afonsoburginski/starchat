//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'dart:io';
import 'package:starchat/Configs/Enum.dart';
import 'package:starchat/Configs/app_constants.dart';
import 'package:starchat/Services/localization/language_constants.dart';
import 'package:starchat/Screens/chat_screen/utils/downloadMedia.dart';
import 'package:starchat/Utils/open_settings.dart';
import 'package:starchat/Utils/save.dart';
import 'package:starchat/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoViewWrapper extends StatelessWidget {
  PhotoViewWrapper(
      {this.imageProvider,
      this.message,
      this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      required this.tag});

  final String tag;
  final String? message;

  final ImageProvider? imageProvider;
  final Widget? loadingChild;
  final Decoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  final GlobalKey<ScaffoldState> _scaffoldd = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoaderr =
      new GlobalKey<State>(debugLabel: 'qqgfggqesqeqsseaadqeqe');
  @override
  Widget build(BuildContext context) {
    return starchat.getNTPWrappedWidget(Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldd,
        appBar: AppBar(
          elevation: DESIGN_TYPE == Themetype.messenger ? 0.4 : 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: starchatWhite,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "dfs32231t834",
          backgroundColor: starchatLightGreen,
          onPressed: Platform.isIOS || Platform.isAndroid
              ? () {
                  launch(message!);
                }
              : () async {
                  starchat
                      .checkAndRequestPermission(Permission.storage)
                      .then((res) async {
                    if (res) {
                      Save.saveToDisk(imageProvider, tag);
                      await downloadFile(
                        context: _scaffoldd.currentContext!,
                        fileName:
                            '${DateTime.now().millisecondsSinceEpoch}.png',
                        isonlyview: false,
                        keyloader: _keyLoaderr,
                        uri: message,
                      );
                    } else {
                      starchat.showRationale(getTranslated(context, 'pms'));
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => OpenSettings()));
                    }
                  });
                },
          child: Icon(
            Icons.file_download,
          ),
        ),
        body: Container(
            color: Colors.black,
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: PhotoView(
              loadingBuilder: (BuildContext context, var image) {
                return loadingChild ??
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(starchatBlue),
                        ),
                      ),
                    );
              },
              imageProvider: imageProvider,
              backgroundDecoration: backgroundDecoration as BoxDecoration?,
              minScale: minScale,
              maxScale: maxScale,
            ))));
  }
}
