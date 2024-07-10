class PaymentResponse {
  PaymentResponse({
      this.paymentlink,});

  PaymentResponse.fromJson(dynamic json) {
    paymentlink = json['payment link'] != null ? PaymentLink.fromJson(json['payment link']) : null;
  }
  PaymentLink? paymentlink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paymentlink != null) {
      map['payment link'] = paymentlink?.toJson();
    }
    return map;
  }

}

class PaymentLink {
  PaymentLink({
      this.acceptPartial, 
      this.amount, 
      this.amountPaid, 
      this.callbackMethod, 
      this.callbackUrl, 
      this.cancelledAt, 
      this.createdAt, 
      this.currency, 
      this.customer, 
      this.description, 
      this.expireBy, 
      this.expiredAt, 
      this.firstMinPartialAmount, 
      this.id, 
      this.notes, 
      this.notify, 
      this.payments, 
      this.referenceId, 
      this.reminderEnable, 
      this.reminders, 
      this.shortUrl, 
      this.status, 
      this.updatedAt, 
      this.upiLink, 
      this.userId, 
      this.whatsappLink,});

  PaymentLink.fromJson(dynamic json) {
    acceptPartial = json['accept_partial'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    callbackMethod = json['callback_method'];
    callbackUrl = json['callback_url'];
    cancelledAt = json['cancelled_at'];
    createdAt = json['created_at'];
    currency = json['currency'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    description = json['description'];
    expireBy = json['expire_by'];
    expiredAt = json['expired_at'];
    firstMinPartialAmount = json['first_min_partial_amount'];
    id = json['id'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
    notify = json['notify'] != null ? Notify.fromJson(json['notify']) : null;
    payments = json['payments'];
    referenceId = json['reference_id'];
    reminderEnable = json['reminder_enable'];
    // if (json['reminders'] != null) {
    //   reminders = [];
    //   json['reminders'].forEach((v) {
    //     reminders?.add(Dynamic.fromJson(v));
    //   });
    // }
    shortUrl = json['short_url'];
    status = json['status'];
    updatedAt = json['updated_at'];
    upiLink = json['upi_link'];
    userId = json['user_id'];
    whatsappLink = json['whatsapp_link'];
  }
  bool? acceptPartial;
  int? amount;
  int? amountPaid;
  String? callbackMethod;
  String? callbackUrl;
  int? cancelledAt;
  int? createdAt;
  String? currency;
  Customer? customer;
  String? description;
  int? expireBy;
  int? expiredAt;
  int? firstMinPartialAmount;
  String? id;
  Notes? notes;
  Notify? notify;
  dynamic payments;
  String? referenceId;
  bool? reminderEnable;
  List<dynamic>? reminders;
  String? shortUrl;
  String? status;
  int? updatedAt;
  bool? upiLink;
  String? userId;
  bool? whatsappLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accept_partial'] = acceptPartial;
    map['amount'] = amount;
    map['amount_paid'] = amountPaid;
    map['callback_method'] = callbackMethod;
    map['callback_url'] = callbackUrl;
    map['cancelled_at'] = cancelledAt;
    map['created_at'] = createdAt;
    map['currency'] = currency;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    map['description'] = description;
    map['expire_by'] = expireBy;
    map['expired_at'] = expiredAt;
    map['first_min_partial_amount'] = firstMinPartialAmount;
    map['id'] = id;
    if (notes != null) {
      map['notes'] = notes?.toJson();
    }
    if (notify != null) {
      map['notify'] = notify?.toJson();
    }
    map['payments'] = payments;
    map['reference_id'] = referenceId;
    map['reminder_enable'] = reminderEnable;
    if (reminders != null) {
      map['reminders'] = reminders?.map((v) => v.toJson()).toList();
    }
    map['short_url'] = shortUrl;
    map['status'] = status;
    map['updated_at'] = updatedAt;
    map['upi_link'] = upiLink;
    map['user_id'] = userId;
    map['whatsapp_link'] = whatsappLink;
    return map;
  }

}

class Notify {
  Notify({
      this.email, 
      this.sms, 
      this.whatsapp,});

  Notify.fromJson(dynamic json) {
    email = json['email'];
    sms = json['sms'];
    whatsapp = json['whatsapp'];
  }
  bool? email;
  bool? sms;
  bool? whatsapp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['sms'] = sms;
    map['whatsapp'] = whatsapp;
    return map;
  }

}

class Notes {
  Notes({
      this.memberId, 
      this.policyName,});

  Notes.fromJson(dynamic json) {
    memberId = json['member_id'];
    policyName = json['policy_name'];
  }
  String? memberId;
  String? policyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['member_id'] = memberId;
    map['policy_name'] = policyName;
    return map;
  }

}

class Customer {
  Customer({
      this.contact, 
      this.email, 
      this.name,});

  Customer.fromJson(dynamic json) {
    contact = json['contact'];
    email = json['email'];
    name = json['name'];
  }
  String? contact;
  String? email;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contact'] = contact;
    map['email'] = email;
    map['name'] = name;
    return map;
  }

}