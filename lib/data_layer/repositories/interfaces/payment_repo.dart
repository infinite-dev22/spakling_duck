abstract class PaymentRepo {
  Future<dynamic> getAllPaymentAccounts(String token, int propertyId);
  Future<dynamic> getAllPaymentModes(String token, int propertyId);
  Future<dynamic> getAllPaymentSchedules(String token, int tenantUnitId, int propertyId);
  Future<dynamic> addPayment(String token, String paid, String amountDue,
      String date, int tenantUnitId, int accountId, int paymentModeId,
      int propertyId, List<String> paymentScheduleId);

}
