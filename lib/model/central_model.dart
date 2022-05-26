class CentralModel {
  // Field
  String? name, province, detail, img;

  // Method
  CentralModel(this.name, this.province, this.detail, this.img);

  CentralModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    province = map['province'];
    detail = map['detail'];
    img = map['img'];
  }
}
