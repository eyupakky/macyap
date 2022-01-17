class PaymentHistoryModel {
  bool? success;
  List<PaymentHistory>? paymentHistory;

  PaymentHistoryModel({this.success, this.paymentHistory});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      paymentHistory = <PaymentHistory>[];
      json['value'].forEach((v) {
        paymentHistory!.add(PaymentHistory.fromJson(v));
      });
    }
  }
}

class PaymentHistory {
  int? id;
  int? arti;
  String? description;
  double? cash;
  String? date;

  PaymentHistory({this.id, this.arti, this.description, this.cash, this.date});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arti = json['arti'];
    description = json['description'];
    cash = json['cash'];
    date = json['date'];
  }

}