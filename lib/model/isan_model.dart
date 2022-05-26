class IsanModel {
  // Field
  String? name, province, detail, img;

  // Method
  IsanModel(this.name, this.province, this.detail, this.img);

  IsanModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    province = map['province'];
    detail = map['detail'];
    img = map['img'];
  }
}
