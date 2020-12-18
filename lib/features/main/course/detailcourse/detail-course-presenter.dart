import 'package:refactory_mobile/base/base-presenter.dart';
import 'package:refactory_mobile/base/base-repository.dart';
import 'package:refactory_mobile/model/detail-course-model.dart';

abstract class DetailCourseContract extends BaseContract{
  progressDataDetailCourse(bool loading);
  fetchDetailCourseData(DetailCourseModel data);

}

class DetailCoursePresenter extends BasePresenter<DetailCourseContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  getDetailCourse()async{
    view.progressDataDetailCourse(true);
    repo.fetch('DetailCourse.json', RequestType.get).then((response) async {
      DetailCourseModel detailCourseResponse = DetailCourseModel.fromJson(response);
      view.progressDataDetailCourse(false);
      view.fetchDetailCourseData(detailCourseResponse);
    }).catchError((error) {
      print('ALUMNI : ${error.toString()}');
      view.progressDataDetailCourse(false);
    });
  }
}