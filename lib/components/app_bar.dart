import 'package:flutter/material.dart';

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
          icon: Icon(
          Icons.notifications,
          color: Colors.grey[200],
          size: 30,
          ),
          onPressed: () {
            // Handle notification action
            print("Notification button pressed");
          },
        ),
        
        SizedBox(width: 5),

        // IconButton(
        //   icon: Icon(Icons.exit_to_app),
        //   onPressed: () {
        //     // Handle logout action
        //     Provider.of<AuthProvider>(context, listen: false).signOut(context);
        //   },
        // ),
      ],
    );
  }
}
