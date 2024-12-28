import 'package:flutter/material.dart';
import 'package:ui/pages/homepage.dart';
import 'package:ui/pages/moodspage.dart';
import 'package:ui/pages/newentrypage.dart';
import 'package:ui/pages/userpage.dart';

import 'package:ui/widgets/diary_entry_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Main(title: 'Flutter Demo Home Page'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.title});


  final String title;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(currentPageIndex: currentPageIndex),
      
      bottomNavigationBar: NavigationBar(
        
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },

        destinations: const<Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_box_rounded), label: 'Add'),
          NavigationDestination(icon: Icon(Icons.mood), label: 'Moods'),
        ]
      ), 
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required int currentPageIndex,
  }) : _currentPageIndex = currentPageIndex;

  final int _currentPageIndex;

  @override
  Widget build(BuildContext context) {
    switch (_currentPageIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const Newentrypage();
      case 2:
        return MoodsPage();
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }
}
