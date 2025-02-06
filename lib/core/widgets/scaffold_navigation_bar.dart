import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/core/providers/service_locator.dart';
import 'package:riverpod_app/core/widgets/header.dart';
import 'package:riverpod_app/core/widgets/sale_organization_item.dart';

import 'navigation_bar_item.dart';

class ScaffoldNavigationBar extends ConsumerWidget {
  const ScaffoldNavigationBar({
    super.key,
    required this.navigationShell,
    required this.onGoBack,
    required this.onGoBranch,
  });

  final StatefulNavigationShell navigationShell;
  final bool Function() onGoBack;
  final Function(int index) onGoBranch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: Header(
          subTitleString: '882494 ארומה רמת-השרון',
          titleString: 'הדר חדש ודנדש',
          context: context,
          onBackPressed: () {
            if(!onGoBack()){
              ref.read(navigationBarIndexProvider.notifier).state = 0;
            }
          },
        ),
        body: navigationShell,
        bottomNavigationBar: CustomNavigationBar(
            onSelectionChanged: (int selection) {
              ref.read(navigationBarIndexProvider.notifier).state = selection;
              onGoBranch(selection);
            }));
  }
}

class CustomNavigationBar extends ConsumerStatefulWidget {
  final Function(int selection) onSelectionChanged;

  const CustomNavigationBar({super.key, required this.onSelectionChanged});

  @override
  ConsumerState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
  // int selectedIndex = 0;

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
                label: 'בית',
                iconData: Icons.home,
                isSelected: ref.watch(navigationBarIndexProvider) == 0,
                onTap: () {
                  itemSelected(0);
                },
              ),
              NavigationBarItem(
                label: 'העסק שלי',
                iconData: Icons.adjust_rounded,
                isSelected: ref.watch(navigationBarIndexProvider) == 1,
                onTap: () {
                  itemSelected(1);
                },
              ),
              InkWell(
                onTap: () {
                  newOrderBottomSheet(context);
                },
                child: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              NavigationBarItem(
                label: 'הזמנות',
                iconData: Icons.save,
                isSelected: ref.watch(navigationBarIndexProvider) == 2,
                onTap: () {
                  itemSelected(2);
                },
              ),
              NavigationBarItem(
                label: 'סל הזמנה',
                iconData: Icons.shopping_cart,
                isSelected: ref.watch(navigationBarIndexProvider) == 3,
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

  Future<dynamic> newOrderBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 270,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.close_sharp,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'מה מזמינים היום?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SaleOrganizationItem(iconPath: 'iconPath', title: 'משקאות'),
                    SaleOrganizationItem(
                        iconPath: 'iconPath', title: 'חלב, סחוט ויין'),
                    SaleOrganizationItem(
                      iconPath: 'iconPath',
                      title: 'אלכוהול',
                      isCartExist: true,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  itemSelected(int selected) {
    setState(() {
      // selectedIndex = selected;
      widget.onSelectionChanged(selected);
    });
  }
}
