import 'package:flutter/material.dart';
import 'package:riverpod_app/core/logger/logger.dart';

class ErrorPopup {
  static bool _isPopupOpen = false;

  static void open(BuildContext context, String title, String description,
      {bool isCancelable = false,
      Function? onOk,
      Function? onCancel,
      String okText = 'OK',
      String cancelText = 'Cancel'}) {
    if (_isPopupOpen) {
      Logger().info("Couldn't open an ErrorPopup since we already showing one. Close the currently opened ErrorPopup in order to see this one");
      return;
    }
    _isPopupOpen = true;
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
                  _isPopupOpen = false;
                  if (onCancel != null) onCancel();
                },
                child: Text(cancelText),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isPopupOpen = false;
                if (onOk != null) onOk();
              },
              child: Text(okText),
            ),
          ],
        );
      },
    ).then((_) {
      _isPopupOpen = false;
    });
  }
  //todo add different buttons layout vertical\horizontal
}
