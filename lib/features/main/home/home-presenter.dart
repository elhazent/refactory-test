import 'package:refactory_mobile/base/base-presenter.dart';
import 'package:refactory_mobile/base/base-repository.dart';
import 'package:refactory_mobile/model/alumni-model.dart';
import 'package:refactory_mobile/model/media-model.dart';
import 'package:refactory_mobile/model/partner-model.dart';

abstract class HomeContract extends BaseContract{
  fetchPartnerData(List<PartnerModel> data);
  fetchMediaData(List<MediaModel> data);
  fetchAlumniData(List<AlumniModel> data);
  progressDataPartner(bool loading);
  progressDataMedia(bool loading);
  progressDataAlumni(bool loading);

}

class HomePresenter extends BasePresenter<HomeContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }
  

  getPartnerList()async{
    view.progressDataPartner(true);
    repo.fetch('Partner.json', RequestType.get).then((response) async {
      List<PartnerModel> profileResponse = (response as List).map((e) => PartnerModel.fromJson(e)).toList();
      view.progressDataPartner(false);
      view.fetchPartnerData(profileResponse);
    }).catchError((error) {
      print('PARTNER : ${error.toString()}');
      view.progressDataPartner(false);
    });
  }

  getMediaList()async{
    view.progressDataMedia(true);
    repo.fetch('Media.json', RequestType.get).then((response) async {
      List<MediaModel> mediaResponse = (response as List).map((e) => MediaModel.fromJson(e)).toList();
      view.progressDataMedia(false);
      view.fetchMediaData(mediaResponse);
    }).catchError((error) {
      print('MEDIA : ${error.toString()}');
      view.progressDataMedia(false);
    });
  }

  getAlumniList()async{
    view.progressDataAlumni(true);
    repo.fetch('Alumni.json', RequestType.get).then((response) async {
      List<AlumniModel> alumniResponse = (response as List).map((e) => AlumniModel.fromJson(e)).toList();
      view.progressDataAlumni(false);
      view.fetchAlumniData(alumniResponse);
    }).catchError((error) {
      print('ALUMNI : ${error.toString()}');
      view.progressDataAlumni(false);
    });
  }
}