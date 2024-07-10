class EventModel {
  EventModel({
    this.eventDetails,
  });

  EventModel.fromJson(dynamic json) {
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
    this.is_member_booked,
    this.note,
    this.imagesUrl,
  });

  EventDetails.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
    coachName = json['coach_name'].toString();
    amount = json['amount'];
    eventId = json['event_id'];
    imageUrl = json['image_url'].toString();
    eventLink = json['event_link'].toString();
    isCompleted = json['is_completed'] ?? false;
    venue = json['venue'].toString();
    time = json['time'].toString();
    map = json['map'].toString();
    programPresenters = json['program_presenters'].toString();
    presisedBy = json['presised_by'].toString();
    chiefGuest = json['chief_guest'].toString();
    note = json['note'].toString();
    is_member_booked = json['is_member_booked']?? false;
   imagesUrl = json['images_url'] != null ? json['images_url'].cast<String>() : [];
  }
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? coachName;
  double? amount;
  int? eventId;
  String? imageUrl;
  String? eventLink;
  bool? isCompleted;
  String? venue;
   List<String>? imagesUrl;
  String? time;
  String? map;
  String? programPresenters;
  String? presisedBy;
  String? chiefGuest;
  String? note;

  bool? is_member_booked;

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
    map['is_member_booked'] = is_member_booked;
    map['time'] = time;
    map['map'] = map;
    map['program_presenters'] = programPresenters;
    map['presised_by'] = presisedBy;
    map['chief_guest'] = chiefGuest;
    map['note'] = note;
    map['images_url'] = imagesUrl;
    return map;
  }
}
