import 'package:flutter/material.dart';
import 'package:refactory_mobile/base/base-state.dart';
import 'package:refactory_mobile/features/main/course/detailcourse/detail-course-presenter.dart';
import 'package:refactory_mobile/model/detail-course-model.dart';
import 'package:refactory_mobile/tools/webview-page.dart';

import '../../../../constants.dart';

class DetailCoursePage extends BaseStatefulWidget {
  String title;
  DetailCoursePage(this.title);
  @override
  _DetailCoursePageState createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends BaseState<DetailCoursePage,DetailCoursePresenter> implements DetailCourseContract {

  DetailCourseModel dataDetailCourse;
  bool progressDetailCourse = false;

  @override
  void initMvp() {
    // TODO: implement initMvp
    super.initMvp();
    presenter = DetailCoursePresenter();
    presenter.setView(this);
    presenter.getDetailCourse();
  }

  @override
  fetchDetailCourseData(DetailCourseModel data) {
    setState(() {
      dataDetailCourse = data;
    });
  }

  @override
  progressDataDetailCourse(bool loading) {
    setState(() {
      progressDetailCourse = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: ListView.builder(
        itemCount: dataDetailCourse.materiCourse.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,position){
          return ExpansionTile(
            title: new Text(
                dataDetailCourse.materiCourse[position].section
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: dataDetailCourse.materiCourse[position].data.map((e) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Icon(Icons.ondemand_video),
                  ),
                  Container(
                    child: Text(
                      "${e.title}",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "(${e.timeIn})",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => WebviewPage(
                                e.title,
                                e.url,
                              )
                          )
                      );
                    },
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    elevation: 0,
                    hoverColor: Colors.white.withOpacity(0.5),
                    child: Text("Start"),
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }


}
