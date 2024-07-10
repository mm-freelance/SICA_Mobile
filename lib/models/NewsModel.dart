


class NewsModel {
  NewsModel({
      this.newsdata,});

  NewsModel.fromJson(dynamic json) {
    if (json['Sica News Vals'] != null) {
      newsdata = [];
      json['Sica News Vals'].forEach((v) {
        newsdata?.add(NewsData.fromJson(v));
      });
    }
  }
  List<NewsData>? newsdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (newsdata != null) {
      map['Sica News Vals'] = newsdata?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class NewsData {
  NewsData({
      this.title, 
      this.date, 
      this.views, 
      this.link, this.description,
      this.image,});

  NewsData.fromJson(dynamic json) {
    title = json['title'];
    date = json['date'];
    views = json['views'];
    link = json['link'];
    image = json['image_url'];
    description=json['description'];
  }
  String? title;
  String? description;
  String? date;
  int? views;
  String? link;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['date'] = date;
    map['views'] = views;
    
    map['description']  =description;
    map['link'] = link;
    map['image'] = image;
    return map;
  }

}