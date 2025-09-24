import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/app_notifier.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<AppNotifier>(context);
    final theme = Theme.of(context);
    return Container(
      width: 250,
      color: theme.colorScheme.surfaceVariant,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'App Pages',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.dashboard_rounded),
            title: const Text('Dashboard'),
            selected: appNotifier.selectedIndex == 0,
            onTap: () => appNotifier.setIndex(0),
            hoverColor: theme.colorScheme.primaryContainer,
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_rounded),
            title: const Text('Gallery'),
            selected: appNotifier.selectedIndex == 1,
            onTap: () => appNotifier.setIndex(1),
            hoverColor: theme.colorScheme.primaryContainer,
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Profile'),
            selected: appNotifier.selectedIndex == 2,
            onTap: () => appNotifier.setIndex(2),
            hoverColor: theme.colorScheme.primaryContainer,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: appNotifier.isDarkMode,
                  onChanged: (value) => appNotifier.toggleTheme(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class MobileDrawer extends StatelessWidget {
//   const MobileDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final appNotifier = Provider.of<AppNotifier>(context);
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary,
//             ),
//             child: const Text('Navigation'),
//           ),
//           ListTile(
//             title: const Text('Dashboard'),
//             selected: appNotifier.selectedIndex == 0,
//             onTap: () {
//               appNotifier.setIndex(0);
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: const Text('Gallery'),
//             selected: appNotifier.selectedIndex == 1,
//             onTap: () {
//               appNotifier.setIndex(1);
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: const Text('Profile'),
//             selected: appNotifier.selectedIndex == 2,
//             onTap: () {
//               appNotifier.setIndex(2);
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: const Text('Dark Mode'),
//             trailing: Switch(
//               value: appNotifier.isDarkMode,
//               onChanged: (value) => appNotifier.toggleTheme(),
//             ),
//             onTap: () => appNotifier.toggleTheme(),
//           ),
//         ],
//       ),
//     );
//   }
// }
