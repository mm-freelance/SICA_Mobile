class D {
  D({
      this.eventDetails,});

  D.fromJson(dynamic json) {
    if (json['event_details'] != null) {
      eventDetails = [];
      json['event_details'].forEach((v) {
        eventDetails?.add(EventDetails.fromJson(v));
      });
    }
  }
  List<EventDetails>? eventDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (eventDetails != null) {
      map['event_details'] = eventDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class EventDetails {
  EventDetails({
      this.title, 
      this.description, 
      this.startDate, 
      this.endDate, 
      this.coachName, 
      this.amount, 
      this.eventId, 
      this.imageUrl, 
      this.eventLink, 
      this.isCompleted, 
      this.venue, 
      this.time, 
      this.map, 
      this.programPresenters, 
      this.presisedBy, 
      this.chiefGuest, 
      this.note, 
      this.imagesUrl, 
      this.bookingStatus, 
      this.isMemberBooked,});

  EventDetails.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    coachName = json['coach_name'];
    amount = json['amount'];
    eventId = json['event_id'];
    imageUrl = json['image_url'];
    eventLink = json['event_link'];
    isCompleted = json['is_completed'];
    venue = json['venue'];
    time = json['time'];
    map = json['map'];
    programPresenters = json['program_presenters'];
    presisedBy = json['presised_by'];
    chiefGuest = json['chief_guest'];
    note = json['note'];
    imagesUrl = json['images_url'] != null ? json['images_url'].cast<String>() : [];
    bookingStatus = json['booking_status'];
    isMemberBooked = json['is_member_booked'];
  }
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? coachName;
  int? amount;
  int? eventId;
  String? imageUrl;
  String? eventLink;
  bool? isCompleted;
  String? venue;
  String? time;
  String? map;
  String? programPresenters;
  String? presisedBy;
  String? chiefGuest;
  String? note;
  List<String>? imagesUrl;
  String? bookingStatus;
  bool? isMemberBooked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['coach_name'] = coachName;
    map['amount'] = amount;
    map['event_id'] = eventId;
    map['image_url'] = imageUrl;
    map['event_link'] = eventLink;
    map['is_completed'] = isCompleted;
    map['venue'] = venue;
    map['time'] = time;
    map['map'] = map;
    map['program_presenters'] = programPresenters;
    map['presised_by'] = presisedBy;
    map['chief_guest'] = chiefGuest;
    map['note'] = note;
    map['images_url'] = imagesUrl;
    map['booking_status'] = bookingStatus;
    map['is_member_booked'] = isMemberBooked;
    return map;
  }

}