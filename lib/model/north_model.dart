class NorthModel {
  // Field
  String? name, province, detail, img;

  // Method
  NorthModel(this.name, this.province, this.detail, this.img);

  NorthModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    province = map['province'];
    detail = map['detail'];
    img = map['img'];
  }
}
