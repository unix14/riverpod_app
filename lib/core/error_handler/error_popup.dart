import 'package:flutter/material.dart';

class ErrorPopup {

  static void open(BuildContext context, String title, String description,
      {bool isCancelable = false,
      Function? onOk,
      Function? onCancel,
      String okText = 'OK',
      String cancelText = 'Cancel'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            if (isCancelable)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
                },
                child: Text(cancelText),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onOk != null) onOk();
              },
              child: Text(okText),
            ),
          ],
        );
      },
    );
  }
}
