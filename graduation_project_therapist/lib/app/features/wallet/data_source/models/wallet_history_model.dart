class WalletHistoryModel {
  String date;
  int id;
  String amount;
  String status;
  int specialistId;
  WalletHistoryModel({
    required this.date,
    required this.id,
    required this.amount,
    required this.status,
    required this.specialistId,
  });

  factory WalletHistoryModel.fromMap(Map<String, dynamic> map) {
    return WalletHistoryModel(
      date: map['date'] as String,
      id: map['id'],
      amount: map['amount'].toString(),
      status: map['status'],
      specialistId: map['specialistId'],
    );
  }
}
