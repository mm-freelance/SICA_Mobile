class JobSeekeModel {
  JobSeekeModel({
      this.memberJobSeeker,});

  JobSeekeModel.fromJson(dynamic json) {
    if (json['Member Job Seeker'] != null) {
      memberJobSeeker = [];
      json['Member Job Seeker'].forEach((v) {
        memberJobSeeker?.add(MemberJobSeeker.fromJson(v));
      });
    }
  }
  List<MemberJobSeeker>? memberJobSeeker;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memberJobSeeker != null) {
      map['Member Job Seeker'] = memberJobSeeker?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MemberJobSeeker {
  MemberJobSeeker({
      this.membershipNo, 
      this.memberId, 
      this.portifolioLink, 
      this.portifolioLink2, 
      this.memberName, 
      this.skillIds, 
      this.postApplyingId, 
      this.mediumId, 
      this.grade, 
      this.mediumid,
      this.startDate, 
      this.tillDate, 
      this.note, 
      this.jobSeekerId,});

  MemberJobSeeker.fromJson(dynamic json) {
    membershipNo = json['membership_no'];
    memberId = json['member_id'];
    portifolioLink = json['portifolio_link'];
    portifolioLink2 = json['portifolio_link_2'];
    memberName = json['member_name'];
    if (json['skill_ids'] != null) {
      skillIds = [];
      json['skill_ids'].forEach((v) {
        skillIds?.add(SkillIds.fromJson(v));
      });
    }
    postApplyingId = json['post_applying_id'];
    mediumId = json['format_name'];
    mediumid=json['format_id'].toString();
    grade = json['grade'];
    startDate = json['start_date'];
    tillDate = json['till_date'];
    note = json['note'];
    jobSeekerId = json['job_seeker_id'];
  }
  String? membershipNo;
  int? memberId;
  String? portifolioLink;
  String? portifolioLink2;
  String? memberName;
  List<SkillIds>? skillIds;
  String? postApplyingId;
  String? mediumId;
   String? mediumid;
  String? grade;
  String? startDate;
  String? tillDate;
  String? note;
  int? jobSeekerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['membership_no'] = membershipNo;
    map['member_id'] = memberId;
    map['portifolio_link'] = portifolioLink;
    map['portifolio_link_2'] = portifolioLink2;
    map['member_name'] = memberName;
    if (skillIds != null) {
      map['skill_ids'] = skillIds?.map((v) => v.toJson()).toList();
    }
    map['post_applying_id'] = postApplyingId;
    map['medium'] = mediumId;
     map['medium_id'] = mediumid;
    map['grade'] = grade;
    map['start_date'] = startDate;
    map['till_date'] = tillDate;
    map['note'] = note;
    map['job_seeker_id'] = jobSeekerId;
    return map;
  }

}

class SkillIds {
  SkillIds({
      this.id, 
      this.name,});

  SkillIds.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}