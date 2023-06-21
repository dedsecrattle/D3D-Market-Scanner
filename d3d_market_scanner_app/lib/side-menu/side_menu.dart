import 'package:d3d_market_scanner_app/side-menu/menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const home = MenuItem(Icons.home, 'Home');
  static const cot = MenuItem(Icons.currency_exchange, 'COT Report');
  static const about = MenuItem(Icons.info, 'About Us');
  static const help = MenuItem(Icons.help, 'Help');
  static const userDashboard = MenuItem(Icons.person, 'Profile');
  static const summary = MenuItem(Icons.document_scanner, 'Market Summary');

  static const all = <MenuItem>{home, summary, userDashboard, cot, about, help};
}

class SideMenu extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const SideMenu(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.pink,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(
              flex: 1,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton.icon(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.pink,
                ),
                label: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.pink),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              ),
            ))
          ],
        )),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) {
    return ListTileTheme(
      selectedColor: Colors.white,
      child: ListTile(
        selectedTileColor: Colors.black26,
        minLeadingWidth: 20,
        selected: currentItem == item,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => onSelectedItem(item),
      ),
    );
  }
}
