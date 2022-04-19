//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'package:starchat/Configs/Enum.dart';
import 'package:starchat/Configs/app_constants.dart';
import 'package:starchat/Screens/calling_screen/pickup_layout.dart';
import 'package:starchat/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl(
      {Key? key,
      required this.url,
      required this.title,
      required this.isregistered})
      : super(key: key);

  final String? url;
  final String title;
  final bool isregistered;

  @override
  Widget build(BuildContext context) {
    return isregistered == false
        ? Scaffold(
            appBar: AppBar(
              elevation: DESIGN_TYPE == Themetype.messenger ? 0.4 : 1,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  size: 30,
                  color: DESIGN_TYPE == Themetype.whatsapp
                      ? starchatWhite
                      : starchatBlack,
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                    color: DESIGN_TYPE == Themetype.whatsapp
                        ? starchatWhite
                        : starchatBlack,
                    fontSize: 18),
              ),
              backgroundColor: DESIGN_TYPE == Themetype.whatsapp
                  ? starchatDeepGreen
                  : starchatWhite,
            ),
            body: const PDF().cachedFromUrl(
              url!,
              placeholder: (double progress) =>
                  Center(child: Text('$progress %')),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            ),
          )
        : PickupLayout(
            scaffold: starchat.getNTPWrappedWidget(Scaffold(
            appBar: AppBar(
              elevation: DESIGN_TYPE == Themetype.messenger ? 0.4 : 1,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  size: 30,
                  color: DESIGN_TYPE == Themetype.whatsapp
                      ? starchatWhite
                      : starchatBlack,
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                    color: DESIGN_TYPE == Themetype.whatsapp
                        ? starchatWhite
                        : starchatBlack,
                    fontSize: 18),
              ),
              backgroundColor: DESIGN_TYPE == Themetype.whatsapp
                  ? starchatDeepGreen
                  : starchatWhite,
            ),
            body: const PDF().cachedFromUrl(
              url!,
              placeholder: (double progress) =>
                  Center(child: Text('$progress %')),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            ),
          )));
  }
}
