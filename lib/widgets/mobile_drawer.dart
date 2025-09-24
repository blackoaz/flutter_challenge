import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/app_notifier.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<AppNotifier>(context);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('PIXABAY'),
          ),
          ListTile(
            title: const Text('Dashboard'),
            selected: appNotifier.selectedIndex == 0,
            onTap: () {
              appNotifier.setIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Gallery'),
            selected: appNotifier.selectedIndex == 1,
            onTap: () {
              appNotifier.setIndex(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            selected: appNotifier.selectedIndex == 2,
            onTap: () {
              appNotifier.setIndex(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: appNotifier.isDarkMode,
              onChanged: (value) => appNotifier.toggleTheme(),
            ),
            onTap: () => appNotifier.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
