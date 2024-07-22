import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/logo.png', height: 50),
      backgroundColor: Colors.amber[800],
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Handle notification action
            print("Notification button pressed");
          },
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            // Handle logout action
            Provider.of<AuthProvider>(context, listen: false).signOut(context);
          },
        ),
      ],
    );
  }
}
