class ProjectTitle {
  ProjectTitle({
      this.shootingAllDetails, 
      this.title,});

  ProjectTitle.fromJson(dynamic json) {
    if (json['shooting_all_details'] != null) {
      shootingAllDetails = [];
      json['shooting_all_details'].forEach((v) {
        shootingAllDetails?.add(ShootingAllDetailsProject.fromJson(v));
      });
    }
    title = json['title'];
  }
  List<ShootingAllDetailsProject>? shootingAllDetails;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shootingAllDetails != null) {
      map['shooting_all_details'] = shootingAllDetails?.map((v) => v.toJson()).toList();
    }
    map['title'] = title;
    return map;
  }

}

class ShootingAllDetailsProject {
  ShootingAllDetailsProject({
      this.shootingDetails,});

  ShootingAllDetailsProject.fromJson(dynamic json) {
    shootingDetails = json['shooting_details'] != null ? ShootingDetails.fromJson(json['shooting_details']) : null;
  }
  ShootingDetails? shootingDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shootingDetails != null) {
      map['shooting_details'] = shootingDetails?.toJson();
    }
    return map;
  }

}

class ShootingDetails {
  ShootingDetails({
      this.mobileNumber, 
      this.memberId, 
      this.shootingId, 
      this.memberName, 
      this.memberNumber, 
      this.designation, 
      this.projectTitle, 
      this.mediumId, 
      this.mediumName, 
      this.startDate, 
      this.endDate, 
      this.notes,});

  ShootingDetails.fromJson(dynamic json) {
    mobileNumber = json['mobile_number'];
    memberId = json['member_id'];
    shootingId = json['shooting_id'];
    memberName = json['member_name'];
    memberNumber = json['member_number'];
    designation = json['designation'];
    projectTitle = json['project_title'];
    mediumId = json['medium_id'];
    mediumName = json['medium_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    notes = json['notes'];
  }
  String? mobileNumber;
  int? memberId;
  int? shootingId;
  String? memberName;
  String? memberNumber;
  String? designation;
  String? projectTitle;
  int? mediumId;
  String? mediumName;
  String? startDate;
  String? endDate;
  String? notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['member_id'] = memberId;
    map['shooting_id'] = shootingId;
    map['member_name'] = memberName;
    map['member_number'] = memberNumber;
    map['designation'] = designation;
    map['project_title'] = projectTitle;
    map['medium_id'] = mediumId;
    map['medium_name'] = mediumName;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['notes'] = notes;
    return map;
  }

}