import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  String _photoURL = "";
  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  Future<void> updateUserProfile(String name) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
    }
  }

  Future<void> updatePhotoURL(String photoURL) async {
    User? user = _auth.currentUser;

    if (user != null) {
      await user.updatePhotoURL(photoURL);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          User? user = snapshot.data;
          if (user != null) {
            _nameController.text = user.displayName ?? '';
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.pink,
                leading: const SideMenuWidget(),
                title: const Text('User Dashboard'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(user.photoURL ??
                          'https://theprabhat.me/wp-content/uploads/2023/06/default-user-icon-8.jpg'),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Welcome, ${user.displayName}!',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Role: User',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      onPressed: () async {
                        // Open a dialog to update the user's name
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Update Name'),
                              content: TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your name',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    String name = _nameController.text.trim();
                                    await updateUserProfile(name);
                                    if (context.mounted) return;
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Update Name'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      onPressed: () {
                        // Open a dialog to update the user's photo URL
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Update Photo'),
                              content: TextField(
                                controller: TextEditingController(),
                                decoration: const InputDecoration(
                                  hintText: 'Enter photo URL',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _photoURL = value;
                                  });
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await updatePhotoURL(_photoURL);
                                    if (context.mounted) {
                                      return;
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Update Photo'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('User not found.');
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
