import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peo_veo/constants/constant.dart';

import '../widget/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx)
        {
           setState(() {
             pageIdx = idx;
           });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: buttonColor,
        backgroundColor: backgroundColour,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30, ), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30, ), label: 'Search'),
          BottomNavigationBarItem(icon: CustomIcon(), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message, size: 30, ), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2, size: 30, ), label: 'Profile'),
        ],
      ),
      body: Center(
        child: pages[pageIdx],
      ),
    );
  }
}
