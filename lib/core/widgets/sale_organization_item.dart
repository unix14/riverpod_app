import 'package:flutter/material.dart';

class SaleOrganizationItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool isCartExist;

  const SaleOrganizationItem(
      {super.key,
      required this.iconPath,
      required this.title,
      this.isCartExist = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 72,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Icon(
                    Icons.accessibility,
                  )),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                Text(isCartExist ? 'קיים סל פתוח' : '',
                    style: TextStyle(color: Colors.green)),
              ],
            )),
        !isCartExist
            ? SizedBox()
            : Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: const EdgeInsets.all(3.0),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
      ],
    );
  }
}
