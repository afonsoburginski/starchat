//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'package:starchat/Configs/app_constants.dart';
import 'package:starchat/Services/localization/language_constants.dart';
import 'package:starchat/Utils/utils.dart';
import 'package:starchat/widgets/MyElevatedButton/MyElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenSettings extends StatefulWidget {
  @override
  State<OpenSettings> createState() => _OpenSettingsState();
}

class _OpenSettingsState extends State<OpenSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return starchat.getNTPWrappedWidget(Material(
        color: starchatDeepGreen,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                getTranslated(this.context, "settingsexplanation"),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                getTranslated(this.context, "settingssteps"),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: myElevatedButton(
                    color: starchatLightGreen,
                    onPressed: () {
                      openAppSettings();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(this.context, "openappsettings"),
                        style: TextStyle(color: starchatWhite),
                      ),
                    ))),
            SizedBox(height: 20),
            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 30.0),
            //     // ignore: deprecated_member_use
            //     child: RaisedButton(
            //         elevation: 0.5,
            //         color: Colors.green,
            //         textColor: starchatWhite,
            //         onPressed: () {
            //           Navigator.of(context).pop();
            //         },
            //         child: Text(
            //           'Go Back',
            //           style: TextStyle(color: starchatWhite),
            //         ))),
          ],
        ))));
  }
}
