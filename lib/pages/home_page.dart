import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/app_notifier.dart';
import '../utils/constants.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/side_navigation.dart';
import 'dashboard_page.dart';
import 'gallery_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppNotifier>(context, listen: false).fetchTrendingImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kMobileBreakpoint) {
          return const Scaffold(
            body: Row(
              children: [
                SideNavigation(),
                Expanded(child: AppBody()),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('PIXABAY'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Provider.of<AppNotifier>(context).isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  onPressed: () {
                    Provider.of<AppNotifier>(context, listen: false).toggleTheme();
                  },
                ),
              ],
            ),
            drawer: const MobileDrawer(),
            body: const AppBody(),
          );
        }
      },
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<AppNotifier>(context);
    return IndexedStack(
      index: appNotifier.selectedIndex,
      children: const [
        DashboardPage(),
        GalleryPage(),
        ProfilePage(),
      ],
    );
  }
}
