import 'package:app_agenda/about_page.dart';
import 'package:app_agenda/config_page.dart';
import 'package:app_agenda/home_page.dart';
import 'package:app_agenda/policy_page.dart';
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
                color: Color(0xfff0ebe1),
              ),
              title: const Text(
                'Contatos',
                style: TextStyle(
                  color: Color(0xfff0ebe1),
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
          Card(
            color: const Color(0xFF0E161B),
            shadowColor: Colors.white54,
            elevation: 0.5,
            child: ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Color(0xfff0ebe1),
              ),
              title: const Text(
                'Sobre Nós',
                style: TextStyle(
                  color: Color(0xfff0ebe1),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
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
                color: Color(0xfff0ebe1),
              ),
              title: const Text(
                'Política de Privacidade',
                style: TextStyle(
                  color: Color(0xfff0ebe1),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PolicyPage(),
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
              leading: const Icon(
                Icons.settings_outlined,
                size: 25,
                color: Color(0xfff0ebe1),
              ),
              title: const Text(
                'Configurações',
                style: TextStyle(
                  color: Color(0xfff0ebe1),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfigPage(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
