import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlert{
  final String title;
  final String message;

  PlatformAlert(this.title,this.message);

  void show(BuildContext context){
  final platform = Theme.of(context).platform;

  if(platform == TargetPlatform.iOS){
    _buildCupertinoAlert(context);
  }
  else{
    _buildMaterialAlert(context);
  }
}

void _buildMaterialAlert(BuildContext context){
  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Close'))
        ],
      );
    },);
}

void _buildCupertinoAlert(BuildContext context){
  showCupertinoDialog(
  context: context, 
  builder: (context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoButton(child: Text("close"), onPressed: () => Navigator.of(context).pop(),)
      ],
    );
  },);
}
}

