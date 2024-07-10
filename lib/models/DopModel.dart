class DopModel {
  DopModel({
      this.shootingDOPDetails,});

  DopModel.fromJson(dynamic json) {
    if (json['Shooting DOP Details'] != null) {
      shootingDOPDetails = [];
      json['Shooting DOP Details'].forEach((v) {
        shootingDOPDetails?.add(ShootingDopDetails.fromJson(v));
      });
    }
  }
  List<ShootingDopDetails>? shootingDOPDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shootingDOPDetails != null) {
      map['Shooting DOP Details'] = shootingDOPDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ShootingDopDetails {
  ShootingDopDetails({
      this.shootingDop, 
      this.addedMembers,});

  ShootingDopDetails.fromJson(dynamic json) {
    shootingDop = json['Shooting_dop'] != [] ? ShootingDop.fromJson(json['Shooting_dop']) : null;
    addedMembers = json['Added Members'].isNotEmpty ? AddedMembers.fromJson(json['Added Members']) : null;
  }
  ShootingDop? shootingDop;
  AddedMembers? addedMembers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shootingDop != null) {
      map['Shooting_dop'] = shootingDop?.toJson();
    }
    if (addedMembers != null) {
      map['Added Members'] = addedMembers?.toJson();
    }
    return map;
  }

}

class AddedMembers {
  AddedMembers({
      this.name, 
      this.mobileNumber, 
      this.shootingId, 
      this.memberNumber, 
      this.memberId, 
      this.memberRoleTpe,});

  AddedMembers.fromJson(dynamic json) {
    name = json['name'].toString();
    mobileNumber = json['mobile_number'].toString();
    shootingId = json['shooting_id'].toString();
    memberNumber = json['member_number'].toString();
    memberId = json['member_id'].toString();
    memberRoleTpe = json['member_role_tpe'].toString();
  }
  String? name;
  String? mobileNumber;
  String? shootingId;
  String? memberNumber;
  String? memberId;
  String? memberRoleTpe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['mobile_number'] = mobileNumber;
    map['shooting_id'] = shootingId;
    map['member_number'] = memberNumber;
    map['member_id'] = memberId;
    map['member_role_tpe'] = memberRoleTpe;
    return map;
  }

}

class ShootingDop {
  ShootingDop({
      this.mobileNumber, 
      this.memberId, 
      this.memberName, 
      this.memberNumber, 
      this.grade, 
      this.formatId, 
      this.formatName, 
      this.mediumId, 
      this.medium, 
      this.scheduleStart, 
      this.scheduleEnd, 
      this.date, 
      this.shootingTitleId, 
      this.projectTitle, 
      this.producer, 
      this.productionHouse, 
      this.productionExecutive, 
      this.productionExecutiveContactNo, 
      this.location, 
      this.outdoorLinkDetails,});

  ShootingDop.fromJson(dynamic json) {
    mobileNumber = json['mobile_number'];
    memberId = json['member_id'].toString();
    memberName = json['member_name'];
    memberNumber = json['member_number'];
    grade = json['grade'];
    formatId = json['format_id'].toString();
    formatName = json['format_name'];
    mediumId = json['medium_id'].toString();
    medium = json['medium'];
    scheduleStart = json['schedule_start'];
    scheduleEnd = json['schedule_end'];
    date = json['date'];
    shootingTitleId = json['shooting_title_id'].toString();
    projectTitle = json['project_title'];
    producer = json['producer'];
    productionHouse = json['production_house'];
    productionExecutive = json['production_executive'];
    productionExecutiveContactNo = json['production_executive_contact_no'];
    location = json['location'].toString();
    outdoorLinkDetails = json['outdoor_link_details'];
  }
  String? mobileNumber;
  String? memberId;
  String? memberName;
  String? memberNumber;
  String? grade;
  String? formatId;
  String? formatName;
  String? mediumId;
  String? medium;
  String? scheduleStart;
  String? scheduleEnd;
  String? date;
  String? shootingTitleId;
  String? projectTitle;
  String? producer;
  String? productionHouse;
  String? productionExecutive;
  String? productionExecutiveContactNo;
  String? location;
  String? outdoorLinkDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['member_id'] = memberId;
    map['member_name'] = memberName;
    map['member_number'] = memberNumber;
    map['grade'] = grade;
    map['format_id'] = formatId;
    map['format_name'] = formatName;
    map['medium_id'] = mediumId;
    map['medium'] = medium;
    map['schedule_start'] = scheduleStart;
    map['schedule_end'] = scheduleEnd;
    map['date'] = date;
    map['shooting_title_id'] = shootingTitleId;
    map['project_title'] = projectTitle;
    map['producer'] = producer;
    map['production_house'] = productionHouse;
    map['production_executive'] = productionExecutive;
    map['production_executive_contact_no'] = productionExecutiveContactNo;
    map['location'] = location;
    map['outdoor_link_details'] = outdoorLinkDetails;
    return map;
  }

}