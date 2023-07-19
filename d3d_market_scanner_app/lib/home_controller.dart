import 'package:d3d_market_scanner_app/home.dart';
import 'package:d3d_market_scanner_app/pages/about_page.dart';
import 'package:d3d_market_scanner_app/pages/chart_page.dart';
import 'package:d3d_market_scanner_app/pages/cot_report.dart';
import 'package:d3d_market_scanner_app/pages/forex_news.dart';
import 'package:d3d_market_scanner_app/pages/retail_sentiment.dart';
import 'package:d3d_market_scanner_app/pages/summary_page.dart';
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
      case MenuItems.cot:
        return const CotReport();
      case MenuItems.news:
        return const ForexNews();
      case MenuItems.userDashboard:
        return const DashboardPage();
      case MenuItems.summary:
        return const SummaryPage();
      case MenuItems.chart:
        return const ChartPage();
      case MenuItems.retail:
        return const RetailSentiments();
      default:
        return const Home();
    }
  }
}
