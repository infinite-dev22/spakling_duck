abstract class PaymentRepo {
  Future<dynamic> getAllPaymentAccounts(String token, int propertyId);
  Future<dynamic> getAllPayments(String token, int propertyId);
  Future<dynamic> getPayments(String token);
  Future<dynamic> getAllPaymentModes(String token, int propertyId);
  Future<dynamic> getAllPaymentSchedules(String token, int tenantUnitId);
  Future<dynamic> addPayment(String token, String paid, String amountDue,
      String date, int tenantUnitId, int accountId, int paymentModeId,
      int propertyId, List<String> paymentScheduleId);

}
