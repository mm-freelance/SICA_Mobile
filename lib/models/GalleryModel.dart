class GalleryModel {
  GalleryModel({
      this.galleryDetails,});

  GalleryModel.fromJson(dynamic json) {
    if (json['gallery_details'] != null) {
      galleryDetails = [];
      json['gallery_details'].forEach((v) {
        galleryDetails?.add(GalleryDetails.fromJson(v));
      });
    }
  }
  List<GalleryDetails>? galleryDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (galleryDetails != null) {
      map['gallery_details'] = galleryDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class GalleryDetails {
  GalleryDetails({
      this.name, 
      this.description, 
      this.imageUrl, 
      this.image, 
      this.date, 
      this.likeCount, 
      this.comment, 
      this.galleryId, 
      this.comments, 
      this.likes,});

  GalleryDetails.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    image = json['image'];
    date = json['date'];
    likeCount = json['like_count'];
    comment = json['comment'];
    galleryId = json['gallery_id'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes?.add(Likes.fromJson(v));
      });
    }
  }
  String? name;
  String? description;
  String? imageUrl;
  String? image;
  String? date;
  int? likeCount;
  int? comment;
  int? galleryId;
  List<Comments>? comments;
  List<Likes>? likes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['image_url'] = imageUrl;
    map['image'] = image;
    map['date'] = date;
    map['like_count'] = likeCount;
    map['comment'] = comment;
    map['gallery_id'] = galleryId;
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    if (likes != null) {
      map['likes'] = likes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Likes {
  Likes({
      this.memberName, 
      this.likeId, 
      this.memberImageUrl,});

  Likes.fromJson(dynamic json) {
    memberName = json['member_name'];
    likeId = json['like_id'];
    memberImageUrl = json['member_image_url'];
  }
  String? memberName;
  int? likeId;
  String? memberImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['member_name'] = memberName;
    map['like_id'] = likeId;
    map['member_image_url'] = memberImageUrl;
    return map;
  }

}

class Comments {
  Comments({
      this.memberName, 
      this.comment, 
      this.createDate, 
      this.memberNumber, 
      this.commentId, 
      this.memberImageUrl, 
      this.memberImage, 
      this.isMemberLike,});

  Comments.fromJson(dynamic json) {
    memberName = json['member_name'];
    comment = json['comment'];
    createDate = json['create_date'];
    memberNumber = json['member_number'];
    commentId = json['comment_id'];
    memberImageUrl = json['member_image_url'];
    memberImage = json['member_image'];
    isMemberLike = json['is_member_like'];
  }
  String? memberName;
  String? comment;
  String? createDate;
  String? memberNumber;
  int? commentId;
  String? memberImageUrl;
  String? memberImage;
  bool? isMemberLike;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['member_name'] = memberName;
    map['comment'] = comment;
    map['create_date'] = createDate;
    map['member_number'] = memberNumber;
    map['comment_id'] = commentId;
    map['member_image_url'] = memberImageUrl;
    map['member_image'] = memberImage;
    map['is_member_like'] = isMemberLike;
    return map;
  }

}