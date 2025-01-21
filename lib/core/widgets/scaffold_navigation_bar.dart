import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavigationBar extends StatelessWidget {
  const ScaffoldNavigationBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('navigation screens app bar'),),
        body: navigationShell,
        bottomNavigationBar: CustomNavigationBar(
          onSelectionChanged: (int selection) {
            _goBranch(selection);
          },
        ));
  }
}

class CustomNavigationBar extends StatefulWidget {
  final Function(int selection) onSelectionChanged;

  const CustomNavigationBar({super.key, required this.onSelectionChanged});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavigationBarItem(
                label: 'סל הזמנה',
                iconData: Icons.shopping_cart,
                isSelected: selectedIndex == 0,
                onTap: () {
                  itemSelected(0);
                },
              ),
              NavigationBarItem(
                label: 'הזמנות',
                iconData: Icons.save,
                isSelected: selectedIndex == 1,
                onTap: () {
                  itemSelected(1);
                },
              ),
              Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 48,
              ),
              NavigationBarItem(
                label: 'העסק שלי',
                iconData: Icons.adjust_rounded,
                isSelected: selectedIndex == 2,
                onTap: () {
                  itemSelected(2);
                },
              ),
              NavigationBarItem(
                label: 'בית',
                iconData: Icons.home,
                isSelected: selectedIndex == 3,
                onTap: () {
                  itemSelected(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemSelected(int selected) {
    setState(() {
      selectedIndex = selected;
      widget.onSelectionChanged(selected);
    });
  }
}

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
