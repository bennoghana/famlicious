import 'package:famlicious/manager/auth_manager.dart';
import 'package:famlicious/views/auth/login_view.dart';
import 'package:famlicious/views/chat/chat_view.dart';
import 'package:famlicious/views/favorites/favorite_view.dart';
import 'package:famlicious/views/profile/profile_view.dart';
import 'package:famlicious/views/timeline/timeline_view.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:firebase_auth/firebase_auth.dart';

//type in stl to create a stateless widget
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  List<Widget> _views = [
    TimeLine_View(),
    chat_view(),
    Favorite_view(),
    profile_view()
  ];
  @override
  void initState() {
    _firebaseAuth.signOut();
    isUserAuth();
    super.initState();
  }

  isUserAuth() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null)
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginView()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _firebaseAuth.currentUser == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Scaffold(
            body: IndexedStack(
              children: _views,
              index: _currentIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                selectedItemColor: Theme.of(context).iconTheme.color,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon((UniconsSolid.history)), label: "Timeline"),
                  BottomNavigationBarItem(
                      icon: Icon((UniconsSolid.comment_dots)), label: "Chat"),
                  BottomNavigationBarItem(
                      icon: Icon((UniconsSolid.favorite)), label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: Icon((UniconsSolid.user_md)), label: "Profile"),
                ]),
          );
  }
}
