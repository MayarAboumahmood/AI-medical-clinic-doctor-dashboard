
class WalletHistoryModel {
  String date;
  WalletHistoryModel({
    required this.date,
  });

  factory WalletHistoryModel.fromMap(Map<String, dynamic> map) {
    return WalletHistoryModel(
      date: map['date'] as String,
    );
  }
}
