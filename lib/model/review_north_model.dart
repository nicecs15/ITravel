class ReviewNorthModel {
  //field
  String? id;
  String? name;
  String? comment;
  double? rating;
  var now = DateTime.now();
  //method
  ReviewNorthModel(this.id, this.name, this.comment, this.rating, this.now);

  ReviewNorthModel.fromMap(Map<String, dynamic> map) {
    comment = map['comment'];
    rating = map['rating'];
    now = map['rating'];
  }
}
