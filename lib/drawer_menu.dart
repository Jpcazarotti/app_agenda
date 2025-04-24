import 'package:app_agenda/home_page.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff20c065),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: const Image(
                    image: AssetImage('assets/ContactHub_logo.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Card(
            color: const Color(0xFF0E161B),
            shadowColor: Colors.white54,
            elevation: 0.5,
            child: ListTile(
              leading: const Icon(
                Icons.people_outline_rounded,
                size: 26,
                color: Colors.white,
              ),
              title: const Text(
                'Contacts',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
            ),
          ),
          Card(
            color: const Color(0xFF0E161B),
            shadowColor: Colors.white54,
            elevation: 0.5,
            child: ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              title: const Text(
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
            ),
          ),
          Card(
            color: const Color(0xFF0E161B),
            shadowColor: Colors.white54,
            elevation: 0.5,
            child: ListTile(
              leading: const Icon(
                Icons.privacy_tip_outlined,
                color: Colors.white,
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
            ),
          ),
          const Divider(
            color: Colors.white24,
            thickness: 1,
          ),
          Card(
            color: const Color(0xFF0E161B),
            shadowColor: Colors.white54,
            elevation: 0.5,
            child: ListTile(
              leading: Icon(
                Icons.delete_forever_rounded,
                size: 26,
                color: Colors.redAccent[700],
              ),
              title: Text(
                'Delete All Contacts',
                style: TextStyle(
                  color: Colors.redAccent[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
