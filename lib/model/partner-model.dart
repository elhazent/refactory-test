class PartnerModel {
  String imagePath;

  PartnerModel({this.imagePath});

  PartnerModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    return data;
  }
}