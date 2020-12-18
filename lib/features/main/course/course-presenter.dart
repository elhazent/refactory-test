import 'package:refactory_mobile/base/base-presenter.dart';
import 'package:refactory_mobile/base/base-repository.dart';
import 'package:refactory_mobile/model/course-model.dart';

abstract class CourseContract extends BaseContract{
  progressDataCourse(bool loading);
  fetchCourseData(List<CourseModel> data);
}

class CoursePresenter extends BasePresenter<CourseContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  getCourseList()async{
    view.progressDataCourse(true);
    repo.fetch('Course.json', RequestType.get).then((response) async {
      List<CourseModel> alumniResponse = (response as List).map((e) => CourseModel.fromJson(e)).toList();
      view.progressDataCourse(false);
      view.fetchCourseData(alumniResponse);
    }).catchError((error) {
      print('ALUMNI : ${error.toString()}');
      view.progressDataCourse(false);
    });
  }

}