import 'package:flutter/material.dart';
import 'package:hamdiappps/screen/post.dart';
import 'package:hamdiappps/screen/navigasi.dart';
import 'package:hamdiappps/screen/chart.dart';
import 'package:hamdiappps/screen/signin.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildMainContent(),
          ChatPage(),
          NewPostPage(),
          Signin(),
        ],
      ),
      bottomNavigationBar: Navigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileSection(),
          StatsSection(),
          GallerySection(),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/user.jpg'),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Bio: Ini adalah bio pengguna.'),
            ],
          ),
        ],
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text('120',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Followers'),
            ],
          ),
          Column(
            children: [
              Text('80',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Following'),
            ],
          ),
          Column(
            children: [
              Text('50',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Posts'),
            ],
          ),
        ],
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  final List<String> images = [
    'assets/images/gbr1.jpg',
    'assets/images/gbr2.jpg',
    'assets/images/gbr3.jpg',
    'assets/images/gbr4.jpg',
    'assets/images/gbr5.jpg',
    'assets/images/gbr6.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gallery',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
