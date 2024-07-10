class DopApprovalModel {
  DopApprovalModel({
      this.memberShootingPendingDopApproval,});

  DopApprovalModel.fromJson(dynamic json) {
    if (json['Member Shooting Pending Dop Approval'] != null) {
      memberShootingPendingDopApproval = [];
      json['Member Shooting Pending Dop Approval'].forEach((v) {
        memberShootingPendingDopApproval?.add(MemberShootingPendingDopApproval.fromJson(v));
      });
    }
  }
  List<MemberShootingPendingDopApproval>? memberShootingPendingDopApproval;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memberShootingPendingDopApproval != null) {
      map['Member Shooting Pending Dop Approval'] = memberShootingPendingDopApproval?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MemberShootingPendingDopApproval {
  MemberShootingPendingDopApproval({
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

  MemberShootingPendingDopApproval.fromJson(dynamic json) {
    date = json['date'];
    mobileNumber = json['mobile_number'];
    shootingTitleId = json['shooting_title_id'];
    memberName = json['member_name'];
    memberNumber = json['member_number'];
    grade = json['grade'];
    dopName = json['dop_name'];
    dopNumber = json['dop_number'];
    dopMemberId = json['dop_member_id'];
    designation = json['designation'];
    projectTitle = json['project_title'];
    medium = json['medium'];
    mediumId = json['medium_id'];
    producer = json['producer'];
    productionHouse = json['production_house'];
    productionExecutive = json['production_executive'];
    productionExecutiveContactNo = json['production_executive_contact_no'];
    location = json['location'];
    outdoorUnitName = json['outdoor_unit_name'];
    notes = json['notes'];
    state = json['state'];
    updateShooingId = json['update_shooing_id'];
  }
  String? date;
  String? mobileNumber;
  int? shootingTitleId;
  String? memberName;
  String? memberNumber;
  String? grade;
  String? dopName;
  String? dopNumber;
  int? dopMemberId;
  String? designation;
  String? projectTitle;
  String? medium;
  int? mediumId;
  String? producer;
  String? productionHouse;
  String? productionExecutive;
  String? productionExecutiveContactNo;
  String? location;
  String? outdoorUnitName;
  String? notes;
  String? state;
  int? updateShooingId;

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