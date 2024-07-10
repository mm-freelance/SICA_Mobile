class MemberDetailModel {
  MemberDetailModel({
    this.memberBasicDetails,
    this.projectWork,this.discussionForum
  });

  MemberDetailModel.fromJson(dynamic json) {
    memberBasicDetails = json['member_basic_details'] != null
        ? MemberBasicDetails.fromJson(json['member_basic_details'])
        : null;
    if (json['project_work'] != null) {
      projectWork = [];
      json['project_work'].forEach((v) {
        projectWork?.add(ProjectWork.fromJson(v));
      });
    }
     if (json['discussion_forum'] != null) {
      discussionForum = [];
      json['discussion_forum'].forEach((v) {
        discussionForum?.add(DiscussionForum.fromJson(v));
      });
    }
  }
  MemberBasicDetails? memberBasicDetails;
  List<ProjectWork>? projectWork;
  List<DiscussionForum>? discussionForum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memberBasicDetails != null) {
      map['member_basic_details'] = memberBasicDetails?.toJson();
    }
    if (projectWork != null) {
      map['project_work'] = projectWork?.map((v) => v.toJson()).toList();
    }
    if (discussionForum != null) {
      map['discussion_forum'] = discussionForum?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProjectWork {
  ProjectWork({
    this.projectName,
    this.designation,
    this.id,
    this.year,
  });

  ProjectWork.fromJson(dynamic json) {
    projectName = json['project_name'];
    designation = json['designation'];
    year = json['year'];
    id = json['id'];
  }
  String? projectName;
  String? designation;
  String? year;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['project_name'] = projectName;
    map['designation'] = designation;
    map['year'] = year;
    map['id'] = id;
    return map;
  }
}

class MemberBasicDetails {
  MemberBasicDetails({
    this.name,
    this.designation,
    this.membershipNo,
    this.joiningDate,
    this.grade,
    this.skills,
    this.medium,
    this.portifolioLink,
    this.notes,
    this.mobileNumber,
    this.experience,
    this.facebookLink,
    this.instagramLink,
    this.youtubeLink,
    this.twitterLink,
    this.subscription_end_date,
    this.linkedinLink,
    this.contact_show,
    this.notes_show,
    this.paid_till,
    this.email
    ,this.state,
    this.image,
    this.imdb_link
  });

  MemberBasicDetails.fromJson(dynamic json) {
    name = json['name'].toString();
    grade=json['grade'].toString();
    designation = json['designation'].toString();
    membershipNo = json['membership_no'].toString();
    joiningDate = json['joining_date'].toString();
    skills = json['skills'].toString();
    medium = json['medium'].toString();
    portifolioLink = json['portifolio_link'].toString();
    notes = json['notes'].toString();
    mobileNumber = json['mobile_number'].toString();
    experience = json['experience'].toString();
    facebookLink = json['facebook_link'].toString();
    instagramLink = json['instagram_link'].toString();
    youtubeLink = json['youtube_link'].toString();
    twitterLink = json['twitter_link'].toString();
    linkedinLink = json['linkedin_link'].toString();
    image = json['image'].toString();
    date_of_birth = json['date_of_birth'].toString();
    subscription_end_date = json['subscription_end_date'].toString(); email = json['email'].toString();
    contact_show = json['contact_privacy'].toString();
    notes_show=json['notes_privacy'].toString();
    imdb_link=json['imdb_link'].toString();
    state=json['state'].toString();
    paid_till=json['paid_till'].toString();
  }
  String? name;
  String? designation;
  String? membershipNo;
  String? joiningDate;
  String? state;
  String? skills;
  String? medium;
  String? portifolioLink;
  String? subscription_end_date;
  String? date_of_birth;
  String? notes;
  String? paid_till;
  String? mobileNumber;
  String? experience;
  String? facebookLink;
  String? instagramLink;
  String? youtubeLink;
  String? twitterLink;
  String? linkedinLink;
  String? image;String? email;
  String? grade;
  String? contact_show;
  String? notes_show;
  String? imdb_link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
     map['name'] = name;
    map['grade']  =grade.toString();
    map['designation'] = designation;
    map['membership_no'] = membershipNo;
    map['joining_date'] = joiningDate;
    map['skills'] = skills;
    map['medium'] = medium;
    map['portifolio_link'] = portifolioLink;
    map['date_of_birth'] = date_of_birth;
    map['notes'] = notes;
    map['paid_till'] =paid_till;
    map['subscription_end_date'] = subscription_end_date;
    map['mobile_number'] = mobileNumber;
    map['experience'] = experience;
    map['facebook_link'] = facebookLink;
    map['instagram_link'] = instagramLink;
    map['youtube_link'] = youtubeLink;
    map['twitter_link'] = twitterLink;
    map['linkedin_link'] = linkedinLink;
   map['imdb_link'] =imdb_link;
    map['image'] = image; map['email'] = email;
    map['contact_show'] = contact_show;
   map['notes_show']  =notes_show;
    return map;
  }
}

class DiscussionForum {
  DiscussionForum({
      this.topic, 
      this.discussionComments,});

  DiscussionForum.fromJson(dynamic json) {
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    if (json['discussion_comments'] != null) {
      discussionComments = [];
      json['discussion_comments'].forEach((v) {
        discussionComments?.add(DiscussionComments.fromJson(v));
      });
    }
  }
  Topic? topic;
  List<DiscussionComments>? discussionComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (topic != null) {
      map['topic'] = topic?.toJson();
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
      this.designation, 
      this.commentId,});

  DiscussionComments.fromJson(dynamic json) {
    profileImage = json['profile_image'];
    comment = json['comment'].toString();
    commentCreateDate = json['comment_create_date'];
    memberName = json['member_name'].toString();
    designation = json['designation'].toString();
    commentId = json['comment_id'];
  }
  String? profileImage;
  String? comment;
  String? commentCreateDate;
  String? memberName;
  String? designation;
  int? commentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_image'] = profileImage;
    map['comment'] = comment;
    map['comment_create_date'] = commentCreateDate;
    map['member_name'] = memberName;
    map['designation'] = designation;
    map['comment_id'] = commentId;
    return map;
  }

}

class Topic {
  Topic({
      this.profile, 
      this.topic, 
      this.memberName, 
      this.categoryName, 
      this.categoryId, 
      this.discussionId, 
      this.createDate, 
      this.memberId, 
      this.designation,});

  Topic.fromJson(dynamic json) {
    profile = json['profile'];
    topic = json['topic'];
    memberName = json['member_name'];
    categoryName = json['category_name'].toString();
    categoryId = json['category_id']==false?0:json['category_id'];
    discussionId = json['discussion_id'];
    createDate = json['create_date'];
    memberId = json['member_id'];
    designation = json['designation'].toString();
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
    return map;
  }

}

