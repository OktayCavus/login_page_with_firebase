import 'package:flutter/material.dart';
import 'package:login_page_with_firebase/constant.dart';
import 'package:login_page_with_firebase/widgets/custom_app_bar.dart';

class TabBarController extends StatefulWidget {
  const TabBarController({super.key});

  @override
  State<TabBarController> createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  int currentIndexx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Social Clone'),
      ),
      bottomNavigationBar: customBottomNavBar(),
    );
  }

  BottomNavigationBar customBottomNavBar() {
    return BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndexx = value;
          });
        },
        currentIndex: currentIndexx,
        selectedItemColor: CustomColors.textButtonColor,
        type: BottomNavigationBarType.fixed,
        items: [
          _customBottomNavBarItem(Icons.home, 'Ana Sayfa'),
          _customBottomNavBarItem(Icons.search, 'Ara'),
          _customBottomNavBarItem(Icons.ondemand_video_outlined, 'Reels'),
          _customBottomNavBarItem(Icons.shopping_bag, 'Alisveris'),
          _customBottomNavBarItem(Icons.person, 'Profil'),
        ]);
  }

  BottomNavigationBarItem _customBottomNavBarItem(
          IconData iconData, String label) =>
      BottomNavigationBarItem(icon: Icon(iconData), label: label);
}
