import 'dart:convert'; // This is needed if you're parsing JSON from a string.

class WalletHistoryModel {
  String date;
  int id;
  String amount;
  String status;
  int specialistId;
  WithdrawSpecialistTransaction? withdrawSpecialistTransaction;

  WalletHistoryModel({
    required this.date,
    required this.id,
    required this.amount,
    required this.status,
    required this.specialistId,
    this.withdrawSpecialistTransaction,
  });

  factory WalletHistoryModel.fromMap(Map<String, dynamic> map) {
    return WalletHistoryModel(
      date: map['date'] as String,
      id: map['id'],
      amount: map['amount'].toString(),
      status: map['status'] != null
          ? (map['status'] ? 'done' : 'rejected')
          : 'Pending',
      specialistId: map['specialistId'],
      withdrawSpecialistTransaction:
          map['withdrawSpecialistTransaction'] != null
              ? WithdrawSpecialistTransaction.fromMap(
                  map['withdrawSpecialistTransaction'])
              : null,
    );
  }
}

class WithdrawSpecialistTransaction {
  int id;
  String amount;
  String date;
  WithdrawSpecialistApprovement? withdrawSpecialistApprovement;

  WithdrawSpecialistTransaction({
    required this.id,
    required this.amount,
    required this.date,
    this.withdrawSpecialistApprovement,
  });

  factory WithdrawSpecialistTransaction.fromMap(Map<String, dynamic> map) {
    return WithdrawSpecialistTransaction(
      id: map['id'],
      amount: map['amount'].toString(),
      date: map['date'] as String,
      withdrawSpecialistApprovement:
          map['withdrawSpecialistApprovement'] != null
              ? WithdrawSpecialistApprovement.fromMap(
                  map['withdrawSpecialistApprovement'])
              : null,
    );
  }
}

class WithdrawSpecialistApprovement {
  int id;
  String description;
  String url;

  WithdrawSpecialistApprovement({
    required this.id,
    required this.description,
    required this.url,
  });

  factory WithdrawSpecialistApprovement.fromMap(Map<String, dynamic> map) {
    return WithdrawSpecialistApprovement(
      id: map['id'],
      description: map['description'] as String,
      url: map['url'] as String,
    );
  }
}

// Example function to parse the JSON response
List<WalletHistoryModel> parseWalletHistory(String jsonResponse) {
  // Decode the JSON string into a Map
  final Map<String, dynamic> dataMap = jsonDecode(jsonResponse);

  // Extract the list of requests
  final List<dynamic> requestsList = dataMap['data']['requests'];

  // Map each request in the list to a WalletHistoryModel
  return requestsList
      .map((item) => WalletHistoryModel.fromMap(item as Map<String, dynamic>))
      .toList();
}
