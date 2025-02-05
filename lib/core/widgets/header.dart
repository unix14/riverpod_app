import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Header extends AppBar {
  final BuildContext context;
  final String? titleString;
  final String? subTitleString;
  final bool isCenterTitle;
  final int? unreadNotifications;
  final Function? onDrawerPressed;
  final Function? onBackPressed;
  final Function? onHeaderPressed;
  final Function? onTrailerPressed;

  Header(
      {super.key,
      required this.context,
      this.titleString,
      this.subTitleString,
      this.onDrawerPressed,
      this.onBackPressed,
      this.onHeaderPressed,
      this.onTrailerPressed,
      this.unreadNotifications,
      this.isCenterTitle = true,})
      : super(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
            ),
          ),
          primary: true,
          actions: [
            InkWell(
              onTap: () => onTrailerPressed != null ? onTrailerPressed() : null,
              child: notificationWidget(unreadNotifications),
            )
          ],
          title: InkWell(
            onTap: (){
              onHeaderPressed != null ? onHeaderPressed() : null;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titleString ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                subTitleString == null
                    ? const SizedBox.shrink()
                    : Text(
                        subTitleString,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
          elevation: 0.0,
          centerTitle: isCenterTitle,
          toolbarHeight:
              Platform.isIOS && MediaQuery.of(context).size.shortestSide <= 600
                  ? 40
                  : null,
          leading: IconButton(
                  icon: Icon(
                    onDrawerPressed == null ? Icons.arrow_back : Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if(onDrawerPressed != null) onDrawerPressed();
                    if(onBackPressed != null) onBackPressed();
                  },
                ),
        );
}

Widget notificationWidget(int? unreadNotifications) {
  return unreadNotifications == null
      ? Icon(Icons.star_border)
      : Stack(
    alignment: Alignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          size: 24,
          Icons.notifications_none_sharp,
          color: Colors.white,
        ),
      ),
      Positioned(
          right: 0,
          top: 0,
          child: Center(
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  unreadNotifications.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
              ),
            ),
          ))
    ],
  );
}
