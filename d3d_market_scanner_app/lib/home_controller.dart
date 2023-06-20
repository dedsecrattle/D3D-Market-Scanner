import 'package:d3d_market_scanner_app/home.dart';
import 'package:d3d_market_scanner_app/pages/about_page.dart';
import 'package:d3d_market_scanner_app/pages/help_page.dart';
import 'package:d3d_market_scanner_app/pages/user_dashboard.dart';
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
      menuScreen: Builder(builder: (context) {
        return SideMenu(
            currentItem: currItem,
            onSelectedItem: (item) {
              setState(() => currItem = item);
              ZoomDrawer.of(context)!.close();
            });
      }),
      mainScreen: getScreen(),
      menuBackgroundColor: Colors.pink,
    );
  }

  Widget getScreen() {
    switch (currItem) {
      case MenuItems.home:
        return const Home();
      case MenuItems.about:
        return const AboutPage();
      case MenuItems.help:
        return const HelpPage();
      case MenuItems.cot:
        return const Home();
      case MenuItems.userDashboard:
        return const DashboardPage();
      default:
        return const Home();
    }
  }
}
