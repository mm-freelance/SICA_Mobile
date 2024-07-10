class BlogsModel {
  BlogsModel({
      this.sicaBlogsVals,});

  BlogsModel.fromJson(dynamic json) {
    if (json['Sica Blog Vals'] != null) {
      sicaBlogsVals = [];
      json['Sica Blog Vals'].forEach((v) {
        sicaBlogsVals?.add(SicaBlogsVals.fromJson(v));
      });
    }
  }
  List<SicaBlogsVals>? sicaBlogsVals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sicaBlogsVals != null) {
      map['Sica Blog Vals'] = sicaBlogsVals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SicaBlogsVals {
  SicaBlogsVals({
      this.title, 
      this.date, 
      this.views, 
      this.link, this.description,
      this.image,});

  SicaBlogsVals.fromJson(dynamic json) {
    title = json['title'];
    date = json['date'];
    views = json['views'];
    link = json['link'];
    image = json['image_url']; description=json['description'];
  }
  String? title;
  String? date;
  int? views;
  String? link;
  String? description;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['date'] = date;
    map['views'] = views;
map['description']=description;
    map['link'] = link;
    map['image_url'] = image;
    return map;
  }

}