class ShootingUpdateModel {
  ShootingUpdateModel({
      this.memberShooting,});

  ShootingUpdateModel.fromJson(dynamic json) {
    if (json['Member Shooting'] != null) {
      memberShooting = [];
      json['Member Shooting'].forEach((v) {
        memberShooting?.add(MemberShooting.fromJson(v));
      });
    }
  }
  List<MemberShooting>? memberShooting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memberShooting != null) {
      map['Member Shooting'] = memberShooting?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MemberShooting {
  MemberShooting({
      this.date, 
      this.mobileNumber, 
      this.shootingTitleId, 
      this.memberName, 
      this.memberNumber, 
      this.grade, 
      this.dopName, 
      this.dopNumber, 
      this.dopMemberId, 
      this.designation, 
      this.projectTitle, 
      this.medium, 
      this.mediumId, 
      this.producer, 
      this.productionHouse, 
      this.productionExecutive, 
      this.productionExecutiveContactNo, 
      this.location, 
      this.outdoorUnitName, 
      this.notes, 
      this.state, 
      this.updateShooingId,});

  MemberShooting.fromJson(dynamic json) {
    date = json['date'].toString();
    mobileNumber = json['mobile_number'].toString();
    shootingTitleId = json['shooting_title_id'].toString();
    memberName = json['member_name'].toString();
    memberNumber = json['member_number'].toString();
    grade = json['grade'].toString();
    dopName = json['dop_name'].toString();
    dopNumber = json['dop_number'].toString();
    dopMemberId = json['dop_member_id'].toString();
    designation = json['designation'].toString();
    projectTitle = json['project_title'].toString();
    medium = json['medium'].toString();
    mediumId = json['medium_id'].toString();
    producer = json['producer'].toString();
    productionHouse = json['production_house'].toString();
    productionExecutive = json['production_executive'].toString();
    productionExecutiveContactNo = json['production_executive_contact_no'].toString();
    location = json['location'].toString();
    outdoorUnitName = json['outdoor_unit_name'].toString();
    notes = json['notes'].toString();
    state = json['state'].toString();
    updateShooingId = json['update_shooing_id'].toString();
  }
  String? date;
  String? mobileNumber;
  String? shootingTitleId;
  String? memberName;
  String? memberNumber;
  String? grade;
  String? dopName;
  String? dopNumber;
  String? dopMemberId;
  String? designation;
  String? projectTitle;
  String? medium;
  String? mediumId;
  String? producer;
  String? productionHouse;
  String? productionExecutive;
  String? productionExecutiveContactNo;
  String? location;
  String? outdoorUnitName;
  String? notes;
  String? state;
  String? updateShooingId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['mobile_number'] = mobileNumber;
    map['shooting_title_id'] = shootingTitleId;
    map['member_name'] = memberName;
    map['member_number'] = memberNumber;
    map['grade'] = grade;
    map['dop_name'] = dopName;
    map['dop_number'] = dopNumber;
    map['dop_member_id'] = dopMemberId;
    map['designation'] = designation;
    map['project_title'] = projectTitle;
    map['medium'] = medium;
    map['medium_id'] = mediumId;
    map['producer'] = producer;
    map['production_house'] = productionHouse;
    map['production_executive'] = productionExecutive;
    map['production_executive_contact_no'] = productionExecutiveContactNo;
    map['location'] = location;
    map['outdoor_unit_name'] = outdoorUnitName;
    map['notes'] = notes;
    map['state'] = state;
    map['update_shooing_id'] = updateShooingId;
    return map;
  }

}