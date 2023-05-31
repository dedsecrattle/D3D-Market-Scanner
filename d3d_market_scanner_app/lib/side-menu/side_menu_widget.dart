import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => ZoomDrawer.of(context)!.toggle(),
        icon: const Icon(Icons.menu));
  }
}
