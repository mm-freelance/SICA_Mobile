class TopicModel {
  TopicModel({
      this.discussionForumDetails,});

  TopicModel.fromJson(dynamic json) {
    if (json['discussion_forum_details'] != null) {
      discussionForumDetails = [];
      json['discussion_forum_details'].forEach((v) {
        discussionForumDetails?.add(DiscussionForumDetails.fromJson(v));
      });
    }
  }
  List<DiscussionForumDetails>? discussionForumDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (discussionForumDetails != null) {
      map['discussion_forum_details'] = discussionForumDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DiscussionForumDetails {
  DiscussionForumDetails({
      this.discussionDetails, 
      this.discussionComments,});

  DiscussionForumDetails.fromJson(dynamic json) {
    discussionDetails = json['discussion_details'] != null ? DiscussionDetails.fromJson(json['discussion_details']) : null;
    if (json['discussion_comments'] != null) {
      discussionComments = [];
      json['discussion_comments'].forEach((v) {
        discussionComments?.add(DiscussionComments.fromJson(v));
      });
    }
  }
  DiscussionDetails? discussionDetails;
  List<DiscussionComments>? discussionComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (discussionDetails != null) {
      map['discussion_details'] = discussionDetails?.toJson();
    }
    if (discussionComments != null) {
      map['discussion_comments'] = discussionComments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DiscussionComments {
  DiscussionComments({
      this.profileImage, 
      this.comment, 
      this.commentCreateDate, 
      this.memberName, 
      this.membershipNo, 
      this.image_url,
      this.designation, 
      this.commentId, 
      this.childDiscussionComments,});

  DiscussionComments.fromJson(dynamic json) {
    profileImage = json['profile_image'];
    comment = json['comment'];
    commentCreateDate = json['comment_create_date'];
    memberName = json['member_name'];
    membershipNo = json['membership_no'];
    designation = json['designation'];
    image_url= json['image_url'].toString();
    commentId = json['comment_id'];
    if (json['child_discussion_comments'] != null) {
      childDiscussionComments = [];
      json['child_discussion_comments'].forEach((v) {
        childDiscussionComments?.add(ChildDiscussionComments.fromJson(v));
      });
    }
  }
  String? profileImage;
  String? comment;
  String? commentCreateDate;
  String? memberName;
  String? membershipNo;
  String? designation;
  String? image_url;
  int? commentId;
  List<ChildDiscussionComments>? childDiscussionComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_image'] = profileImage;
    map['comment'] = comment;
    map['comment_create_date'] = commentCreateDate;
    map['member_name'] = memberName;
    map['image_url'] = image_url;
    map['membership_no'] = membershipNo;
    map['designation'] = designation;

    map['comment_id'] = commentId;
    if (childDiscussionComments != null) {
      map['child_discussion_comments'] = childDiscussionComments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ChildDiscussionComments {
  ChildDiscussionComments({
      this.profileImage, 
      this.comment, 
      this.commentCreateDate, 
      this.memberName, 
      this.membershipNo, 
      this.designation, 
      this.commentId, 
      this.childCommentId,});

  ChildDiscussionComments.fromJson(dynamic json) {
    profileImage = json['profile_image'];
    comment = json['comment'];
    commentCreateDate = json['comment_create_date'];
    memberName = json['member_name'];
    membershipNo = json['membership_no'];
    designation = json['designation'];
    commentId = json['comment_id'];
    childCommentId = json['child_comment_id'];
  }
  String? profileImage;
  String? comment;
  String? commentCreateDate;
  String? memberName;
  String? membershipNo;
  String? designation;
  int? commentId;
  int? childCommentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_image'] = profileImage;
    map['comment'] = comment;
    map['comment_create_date'] = commentCreateDate;
    map['member_name'] = memberName;
    map['membership_no'] = membershipNo;
    map['designation'] = designation;
    map['comment_id'] = commentId;
    map['child_comment_id'] = childCommentId;
    return map;
  }

}

class DiscussionDetails {
  DiscussionDetails({
      this.profile, 
      this.topic, 
      this.memberName, 
      this.categoryName, 
      this.categoryId, 
      this.discussionId, 
      this.createDate, 
      this.memberId, 
      this.designation, 
      this.lastMemberName, 
      this.lastTopicCreateDate, 
      this.lastCommitMemberImage,});

  DiscussionDetails.fromJson(dynamic json) {
    profile = json['profile'].toString();
    topic = json['topic'].toString();
    memberName = json['member_name'].toString();
    categoryName = json['category_name'].toString();
    categoryId = json['category_id'];
    discussionId = json['discussion_id'];
    createDate = json['create_date'].toString();
    memberId = json['member_id'];
    designation = json['designation'].toString();
    lastMemberName = json['last_member_name'].toString();
    lastTopicCreateDate = json['last_topic_create_date'].toString();
    lastCommitMemberImage = json['last_commit_member_image'].toString();
  }
  String? profile;
  String? topic;
  String? memberName;
  String? categoryName;
  int? categoryId;
  int? discussionId;
  String? createDate;
  int? memberId;
  String? designation;
  String? lastMemberName;
  String? lastTopicCreateDate;
  String? lastCommitMemberImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile'] = profile;
    map['topic'] = topic;
    map['member_name'] = memberName;
    map['category_name'] = categoryName;
    map['category_id'] = categoryId;
    map['discussion_id'] = discussionId;
    map['create_date'] = createDate;
    map['member_id'] = memberId;
    map['designation'] = designation;
    map['last_member_name'] = lastMemberName;
    map['last_topic_create_date'] = lastTopicCreateDate;
    map['last_commit_member_image'] = lastCommitMemberImage;
    return map;
  }

}