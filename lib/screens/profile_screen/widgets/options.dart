import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        OptionTile(title: 'Profile', icon: Icons.person),
        OptionTile(title: 'Notifications', icon: Icons.notifications),
        OptionTile(title: 'Settings', icon: Icons.settings),
        OptionTile(title: 'Privacy', icon: Icons.lock),
        OptionTile(title: 'Help & Support', icon: Icons.help),
        OptionTile(title: 'About Us', icon: Icons.info),
        OptionTile(title: 'Logout', icon: Icons.logout),
      ],
    );
  }
}

class OptionTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const OptionTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title tapped')),
        );
      },
    );
  }
}

