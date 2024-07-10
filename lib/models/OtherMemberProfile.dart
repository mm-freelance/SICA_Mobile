class OtherMemberProfile {
  OtherMemberProfile({
      this.memberBasicDetails,});

  OtherMemberProfile.fromJson(dynamic json) {
    if (json['member_basic_details'] != null) {
      memberBasicDetails = [];
      json['member_basic_details'].forEach((v) {
        memberBasicDetails?.add(MemberBasicDetails.fromJson(v));
      });
    }
  }
  List<MemberBasicDetails>? memberBasicDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memberBasicDetails != null) {
      map['member_basic_details'] = memberBasicDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MemberBasicDetails {
  MemberBasicDetails({
      this.memberDetails, 
      this.works,});

  MemberBasicDetails.fromJson(dynamic json) {
    memberDetails = json['member_details'] != null ? MemberDetails.fromJson(json['member_details']) : null;
    if (json['works'] != null) {
      works = [];
      json['works'].forEach((v) {
        works?.add(ProjectWork.fromJson(v));
      });
    }
  }
  MemberDetails? memberDetails;
  List<dynamic>? works;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memberDetails != null) {
      map['member_details'] = memberDetails?.toJson();
    }
    if (works != null) {
      map['works'] = works?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MemberDetails {
  MemberDetails({
      this.name, 
      this.grade,
      this.designation, 
      this.membershipNo, 
      this.joiningDate, 
      this.skills, 
      this.medium, 
      this.portifolioLink, 
      this.notes, 
      this.mobileNumber,  this.email,
      this.experience, 
      this.facebookLink, 
      this.instagramLink, 
      this.date_of_birth,
      this.youtubeLink, 
      this.twitterLink, 
      this.linkedinLink, 
      this.image,});

  MemberDetails.fromJson(dynamic json) {
    name = json['name'];
    email=json['email'].toString();
    designation = json['designation'];
    membershipNo = json['membership_no'];
    joiningDate = json['joining_date'];
    skills = json['skills'];
    medium = json['medium'];
    portifolioLink = json['portifolio_link'];
    notes = json['notes'];
    mobileNumber = json['mobile_number'];
    experience = json['experience'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    youtubeLink = json['youtube_link'];
    twitterLink = json['twitter_link'];
    linkedinLink = json['linkedin_link'];
    image = json['image'];
    grade=json['grade'];
    date_of_birth=json["date_of_birth"];
  }
  String? name;
  String? grade;
  String? designation;
  String? membershipNo;
  String? joiningDate;
  String? skills;
  String? medium;
  String? portifolioLink;
  String? notes;
  String? mobileNumber;
  String? experience;
  String? facebookLink;
  String? instagramLink;
  String? youtubeLink;
  String? twitterLink;
  String? linkedinLink;
  String? image;
  String? email;
  String? date_of_birth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['designation'] = designation;
    map['membership_no'] = membershipNo;
    map['joining_date'] = joiningDate;
    map['skills'] = skills;
    map['medium'] = medium;
    map['portifolio_link'] = portifolioLink;
    map['notes'] = notes;
    map['mobile_number'] = mobileNumber;
    map['experience'] = experience; map['date_of_birth'] = date_of_birth;
    map['facebook_link'] = facebookLink;
    map['instagram_link'] = instagramLink;
    map['youtube_link'] = youtubeLink;
    map['twitter_link'] = twitterLink;
    map['linkedin_link'] = linkedinLink;
    map['image'] = image;
    map['grade']=grade; map['email']=email;
    return map;
  }

}
class ProjectWork {
  ProjectWork({
      this.projectName, 
      this.designation, 
      this.id,
      this.year,});

  ProjectWork.fromJson(dynamic json) {
    projectName = json['project_name'];
    designation = json['designation'];
    year = json['year'];
    id=json['id'];
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
    map['id']=id;
    return map;
  }

}