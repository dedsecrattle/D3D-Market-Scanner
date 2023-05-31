import 'package:d3d_market_scanner_app/home.dart';
import 'package:d3d_market_scanner_app/side-menu/menu_item.dart';
import 'package:d3d_market_scanner_app/side-menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  MenuItem currItem = MenuItems.home;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      showShadow: true,
      menuScreen: SideMenu(
          currentItem: currItem,
          onSelectedItem: (item) {
            setState(() => currItem = item);
          }),
      mainScreen: const Home(),
      menuBackgroundColor: Colors.pink,
    );
  }
}
