import 'dart:io';

import 'package:crud_moura_flutter_app/ios/cupertino-app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'android/material-app.dart';

void main() => runApp(
  Platform.isIOS ? MyCuppertinoApp() : MyMaterialApp()
);

