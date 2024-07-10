class JobSeekerProviderMatchModel {
  JobSeekerProviderMatchModel({
      this.jobdetails,});

  JobSeekerProviderMatchModel.fromJson(dynamic json) {
    if (json['job details'] != null) {
      jobdetails = [];
      json['job details'].forEach((v) {
        jobdetails?.add(JobDetails.fromJson(v));
      });
    }
  }
  List<JobDetails>? jobdetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (jobdetails != null) {
      map['job details'] = jobdetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class JobDetails {
  JobDetails({
      this.jobProvider, 
      this.jobseeker,});

  JobDetails.fromJson(dynamic json) {
    jobProvider = json['job_provider'] != null ? JobProvider.fromJson(json['job_provider']) : null;
    if (json['job seeker'] != null) {
      jobseeker = [];
      json['job seeker'].forEach((v) {
        jobseeker?.add(JobSeeker.fromJson(v));
      });
    }
  }
  JobProvider? jobProvider;
  List<JobSeeker>? jobseeker;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (jobProvider != null) {
      map['job_provider'] = jobProvider?.toJson();
    }
    if (jobseeker != null) {
      map['job seeker'] = jobseeker?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class JobSeeker {
  JobSeeker({
      this.membershipNo, 
      this.memberId, 
      this.portifolioLink, 
      this.portifolioLink2, 
      this.memberName, 
      this.skillIds, 
      this.postApplyingId, 
      this.mediumId, 
      this.grade, 
      this.startDate, 
      this.tillDate, 
      this.note, 
      this.jobSeekerId, 
      this.percentage,});

  JobSeeker.fromJson(dynamic json) {
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
    mediumId = json['medium_id'];
    grade = json['grade'];
    startDate = json['start_date'];
    tillDate = json['till_date'];
    note = json['note'];
    jobSeekerId = json['job_seeker_id'];
    percentage = json['percentage'];
  }
  String? membershipNo;
  int? memberId;
  String? portifolioLink;
  String? portifolioLink2;
  String? memberName;
  List<SkillIds>? skillIds;
  String? postApplyingId;
  String? mediumId;
  String? grade;
  String? startDate;
  String? tillDate;
  String? note;
  int? jobSeekerId;
  int? percentage;

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
    map['medium_id'] = mediumId;
    map['grade'] = grade;
    map['start_date'] = startDate;
    map['till_date'] = tillDate;
    map['note'] = note;
    map['job_seeker_id'] = jobSeekerId;
    map['percentage'] = percentage;
    return map;
  }

}


class JobProvider {
  JobProvider({
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

  JobProvider.fromJson(dynamic json) {
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
    mediumId = json['medium_id'];
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