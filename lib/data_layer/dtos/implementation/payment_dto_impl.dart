

import 'package:smart_rent/data_layer/models/payment/add_payment_response_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/payment_repo_impl.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/payment_repo.dart';

class PaymentDtoImpl {
  static Future<AddPaymentResponseModel> addPayment(
      String token, String paid, String amountDue,
      String date, int tenantUnitId, int accountId, int paymentModeId,
      int propertyId, List<String> paymentScheduleId, {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    PaymentRepo paymentRepo = PaymentRepoImpl();
    var result = await paymentRepo
        .addPayment( token, paid, amountDue, date, tenantUnitId, accountId, paymentModeId,
         propertyId,  paymentScheduleId)
        .then((response) => AddPaymentResponseModel.fromJson(response));

    return result;
  }
}
