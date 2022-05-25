class SouthModel {
  // Field
  String? name, province, detail, img;

  // Method
  SouthModel(this.name, this.province, this.detail, this.img);

  SouthModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    province = map['province'];
    detail = map['detail'];
    img = map['img'];
  }
}
