class TechModel {
  TechModel({
      this.techtalkVals,});

  TechModel.fromJson(dynamic json) {
    if (json['Tech talk Vals'] != null) {
      techtalkVals = [];
      json['Tech talk Vals'].forEach((v) {
        techtalkVals?.add(TechTalkVals.fromJson(v));
      });
    }
  }
  List<TechTalkVals>? techtalkVals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (techtalkVals != null) {
      map['Tech talk Vals'] = techtalkVals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TechTalkVals {
  TechTalkVals({
      this.title, 
      this.date, 
      this.views, 
      this.link, this.description,
      this.image,});

  TechTalkVals.fromJson(dynamic json) {
    title = json['title'];
    date = json['date'];
    views = json['views'];
    link = json['link'];
    image = json['image']; description=json['description'];
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
    map['image'] = image;
    return map;
  }

}