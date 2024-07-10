class ChildCommentModel {
  ChildCommentModel({
      this.discussionChildCommentDetails,});

  ChildCommentModel.fromJson(dynamic json) {
    if (json['discussion_child_comment_details'] != null) {
      discussionChildCommentDetails = [];
      json['discussion_child_comment_details'].forEach((v) {
        discussionChildCommentDetails?.add(DiscussionChildCommentDetails.fromJson(v));
      });
    }
  }
  List<DiscussionChildCommentDetails>? discussionChildCommentDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (discussionChildCommentDetails != null) {
      map['discussion_child_comment_details'] = discussionChildCommentDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DiscussionChildCommentDetails {
  DiscussionChildCommentDetails({
      this.profileImage, 
      this.comment, 
      this.commentCreateDate, 
      this.memberName, 
      this.membershipNo, 
      this.designation, 
      this.commentId, 
      this.childCommentId,});

  DiscussionChildCommentDetails.fromJson(dynamic json) {
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