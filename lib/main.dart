import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'blocs/app_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, appNotifier, child) {
        return MaterialApp(
          title: 'PIXABAY',
          theme: ThemeData.light(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
          ),
          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue.shade800, brightness: Brightness.dark),
          ),
          themeMode: appNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}