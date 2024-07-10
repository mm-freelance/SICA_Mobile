class JobProvider2Model {
  JobProvider2Model({
      this.memberJobSeeker,});

  JobProvider2Model.fromJson(dynamic json) {
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
      this.memberName, 
      this.skillIds, 
      this.postRequiredId, 
      this.mediumId, 
      this.grade, 
      this.requiredFrom, 
      this.requiredTill, 
      this.note, 
      this.jobProviderId,});

  MemberJobSeeker.fromJson(dynamic json) {
    membershipNo = json['membership_no'];
    memberId = json['member_id'];
    memberName = json['member_name'];
    if (json['skill_ids'] != null) {
      skillIds = [];
      json['skill_ids'].forEach((v) {
        skillIds?.add(SkillIds.fromJson(v));
      });
    }
    postRequiredId = json['post_required_id'];
    mediumId = json['format_name'];
    grade = json['grade'];
    requiredFrom = json['required_from'];
    requiredTill = json['required_till'];
    note = json['note'];
    jobProviderId = json['job_provider_id'];
  }
  String? membershipNo;
  int? memberId;
  String? memberName;
  List<SkillIds>? skillIds;
  String? postRequiredId;
  String? mediumId;
  String? grade;
  String? requiredFrom;
  String? requiredTill;
  String? note;
  int? jobProviderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['membership_no'] = membershipNo;
    map['member_id'] = memberId;
    map['member_name'] = memberName;
    if (skillIds != null) {
      map['skill_ids'] = skillIds?.map((v) => v.toJson()).toList();
    }
    map['post_required_id'] = postRequiredId;
    map['medium_id'] = mediumId;
    map['grade'] = grade;
    map['required_from'] = requiredFrom;
    map['required_till'] = requiredTill;
    map['note'] = note;
    map['job_provider_id'] = jobProviderId;
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