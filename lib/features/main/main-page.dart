import 'package:flutter/material.dart';
import 'package:refactory_mobile/features/main/course/course-page.dart';
import 'package:refactory_mobile/features/main/home/home-page.dart';
import 'package:refactory_mobile/tools/webview-page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomePage(),
            CoursePage(),
            WebviewPage("Blog", "https://refactory.id/blog",isBlog: true,)
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.home
              ),
              text: "Home",
            ),
            Tab(
              icon: Icon(
                  Icons.menu_book
              ),
              text: "Course",
            ),
            Tab(
              icon: Icon(
                  Icons.article_outlined
              ),
              text: "Blog",
            ),
          ],
          labelColor: Colors.deepOrange,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
