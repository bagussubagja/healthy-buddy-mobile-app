import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/purchase_history_model/purchase_history_model.dart';
import 'package:healthy_buddy_mobile_app/services/purchase_history_services/purchase_history_services.dart';
import 'package:http/http.dart' as http;

class PurchaseHistoryClass extends ChangeNotifier {
  List<PurchaseHistoryModel>? purchaseHistory;
  bool isLoading = false;
  getPurchaseHistory({required BuildContext context, required String idUser}) async {
    isLoading = true;
    purchaseHistory = (await getPurchaseHistoryData(context: context, idUser: idUser));
    isLoading = false;
    notifyListeners();
  }

  Future<void> addFoodiesTransactionData(
      PurchaseHistoryModel body, BuildContext context) async {
    notifyListeners();
    http.Response? response = (await addFoodiesTransaction(body, context));
    if (response?.statusCode == 201) {
      debugPrint('Transaksi Berhasil');
    }
  }
}
