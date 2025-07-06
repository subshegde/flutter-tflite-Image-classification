import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite_examples/presentation/pages/home/home.dart';
import 'package:flutter_tflite_examples/presentation/pages/image_classification/mango_leaf_disease_detection/tFLite_classifier_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMainShell extends StatefulWidget {
  const HomeMainShell({super.key});

  @override
  State<HomeMainShell> createState() => _HomeMainShellState();
}

class _HomeMainShellState extends State<HomeMainShell> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    TFLiteClassifierPage(),
    Center(child: Text('Profile Page')),
  ];

  Future<void> _handlePop(bool didPop) async {
    if (didPop) return;
    if (currentIndex > 0) {
      setState(() => currentIndex = 0);
    } else {
      final shouldExit = await showModalBottomSheet<bool>(
        isDismissible: false,
        enableDrag: false,
        elevation: 2,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 190,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Are you sure you want to exit?',
                        style: GoogleFonts.poppins(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Center(
                          child: Text(
                            'NO',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Center(
                          child: Text(
                            'YES',
                            style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        SystemNavigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _handlePop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: pages[currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          selectedItemColor: Colors.green.shade700,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco_outlined),
              activeIcon: Icon(Icons.eco),
              label: 'Mango',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
