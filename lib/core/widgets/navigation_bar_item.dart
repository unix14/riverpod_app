import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isSelected;

  final Function() onTap;

  const NavigationBarItem(
      {super.key,
        required this.label,
        required this.iconData,
        required this.isSelected,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: Icon(
              iconData,
              color: isSelected ? Colors.lightGreenAccent : Colors.white,
            ),
          ),
          Center(
            child: Text(
              label,
              style: TextStyle(
                  color: isSelected ? Colors.lightGreenAccent : Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}