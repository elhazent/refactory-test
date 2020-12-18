import 'package:flutter/material.dart';
import 'package:refactory_mobile/base/base-state.dart';
import 'package:refactory_mobile/model/course-model.dart';
import 'package:shimmer/shimmer.dart';

import 'course-presenter.dart';
import 'detailcourse/detail-course-page.dart';

class CoursePage extends BaseStatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends BaseState<CoursePage,CoursePresenter> implements CourseContract {

  List<CourseModel> dataCourse;
  bool progressCourse = false;

  @override
  void initMvp() {
    // TODO: implement initMvp
    super.initMvp();
    presenter = CoursePresenter();
    presenter.setView(this);
    presenter.getCourseList();
  }

  @override
  fetchCourseData(List<CourseModel> data) {
    setState(() {
      dataCourse = data;
    });
  }

  @override
  progressDataCourse(bool loading) {
    setState(() {
      progressCourse = loading;
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: progressCourse?Column(
            children: [
              Container(
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.3),
                          highlightColor: Colors.grey.withOpacity(0.5),
                          period: Duration(milliseconds: 2100),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.3),
                                highlightColor: Colors.grey.withOpacity(0.5),
                                period: Duration(milliseconds: 2100),
                                child: Container(
                                  width: 200,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                )
                            ),
                            SizedBox(height: 5,),
                            Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.3),
                                highlightColor: Colors.grey.withOpacity(0.5),
                                period: Duration(milliseconds: 2100),
                                child: Container(
                                  width: 280,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                )
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.3),
                                    highlightColor: Colors.grey.withOpacity(0.5),
                                    period: Duration(milliseconds: 2100),
                                    child: Container(
                                      width: 150,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                    )
                                ),
                                SizedBox(width: 10,),
                                Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.3),
                                    highlightColor: Colors.grey.withOpacity(0.5),
                                    period: Duration(milliseconds: 2100),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle
                                      ),
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,)
            ],
          ):ListView.builder(
            itemCount: dataCourse.length,
            itemBuilder: (context,position){
              return GestureDetector(
                onTap: (){
                  push(DetailCoursePage(dataCourse[position].title));
                },
                child: Column(
                  children: [
                    Container(
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5),),
                                child: Image.network(dataCourse[position].photoUrl,fit: BoxFit.cover,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                )
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataCourse[position].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    dataCourse[position].shortDescription,
                                    style: TextStyle(
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        dataCourse[position].user.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(dataCourse[position].user.photoUrl),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


}
