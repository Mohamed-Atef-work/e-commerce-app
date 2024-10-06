import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/services/stripe/constants.dart';
import 'package:e_commerce_app/modules/user/use_case/check_out.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/user/domain/repository/payment.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/user/domain/params/delete_product_from_cart_params.dart';

part 'manage_cart_products_state.dart';

class ManageCartProductsCubit extends Cubit<ManageCartProductsState> {
  final CartDomainRepo _cartRepo;
  final CheckoutUseCase _checkout;

  ManageCartProductsCubit(
    this._cartRepo,
    this._checkout,
  ) : super(const ManageCartProductsState());

  void getCartProducts(String uId) async {
    if (state.needToReGet) {
      emit(state.copyWith(getCart: RequestState.loading));

      /// Handling UID  :) ..........
      final result = await _cartRepo.getCartProducts(uId);
      emit(
        result.fold(
          (l) =>
              state.copyWith(message: l.message, getCart: RequestState.error),
          (r) => state.copyWith(
            products: r,
            needToReGet: false,
            getCart: RequestState.success,
          ),
        ),
      );

      Future.delayed(const Duration(milliseconds: 30), () {
        emit(state.copyWith(getCart: RequestState.initial));
      });
    }
  }

  void deleteFromCart(DeleteFromCartParams params) async {
    emit(state.copyWith(deleteFromCart: RequestState.loading));
    final result = await _cartRepo.deleteFromCart(params);
    emit(
      result.fold(
        (l) => state.copyWith(
          message: l.message,
          deleteFromCart: RequestState.error,
        ),
        (r) => state.copyWith(
          deleteFromCart: RequestState.success,
          notExistedProducts: const [],
          message: AppStrings.deleted,
          needToReGet: true,
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 30), () {
      emit(state.copyWith(deleteFromCart: RequestState.initial));
    });
  }

  void checkout(UserEntity user) async {
    emit(state.copyWith(addOrder: RequestState.loading));

    final params = _addOrderParams(user);

    final result = await _checkout.call(params);

    emit(
      result.fold(
        (l) => state.copyWith(
          message: l.message,
          addOrder: RequestState.error,
          notExistedProducts: l.object,
        ),
        (r) => state.copyWith(
          needToReGet: true,
          products: const [],
          notExistedProducts: const [],
          addOrder: RequestState.success,
          message: AppStrings.yourOrderIsPlaced,
        ),
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 30),
      () => emit(state.copyWith(addOrder: RequestState.initial)),
    );
  }

  double _totalPrice() {
    double totalPrice = 0;
    for (int index = 0; index < state.products.length; index++) {
      totalPrice = totalPrice +
          state.products[index].quantity * state.products[index].product.price;
    }
    return totalPrice;
  }

  List<OrderItemModel> _makeItems() {
    return List.generate(
      state.products.length,
      (index) => OrderItemModel(
        product: state.products[index].product,
        quantity: state.products[index].quantity,
      ),
    );
  }

  void needToReGet() {
    emit(
      state.copyWith(
        needToReGet: true,
        notExistedProducts: const [],
      ),
    );
  }

  void quantityPlus(int index) {
    int lastQuantity = state.products[index].quantity;
    lastQuantity++;
    final item = CartItemEntity(
      quantity: lastQuantity,
      product: state.products[index].product,
    );
    List<CartItemEntity> products = state.products;
    products[index] = item;
    emit(state.copyWith(products: products));
  }

  void quantityMinus(int index) {
    if (state.products[index].quantity > 1) {
      int lastQuantity = state.products[index].quantity;
      lastQuantity--;
      final item = CartItemEntity(
        quantity: lastQuantity,
        product: state.products[index].product,
      );
      List<CartItemEntity> products = state.products;
      products[index] = item;
      emit(state.copyWith(products: products));
    }
  }

  CheckoutParams _addOrderParams(UserEntity user) {
    final totalPrice = _totalPrice();

    final items = _makeItems();

    final orderData = OrderDataModel(
      name: user.name,
      phone: user.phone!,
      address: user.address!,
      totalPrice: totalPrice,
      date: DateTime.now().toString(),
    );

    final orderParams = AddOrderParams(
      orderData: orderData,
      items: items,
      uId: user.id,
    );
    final payParams = PayParams(
        currency: 'USD',
        amount: totalPrice.toInt(),
        customerId: StripeConstants.customerId);

    final params = CheckoutParams(
      orderParams: orderParams,
      paymentParams: payParams,
    );
    return params;
  }
}
/*
 {
 "error":
 {
 "message":"Invalid currency: ughjsd. Stripe currently supports these currencies: usd, aed, afn, all, amd, ang, aoa, ars, aud, awg, azn, bam, bbd, bdt, bgn, bhd, bif, bmd, bnd, bob, brl, bsd, bwp, byn, bzd, cad, cdf, chf, clp, cny, cop, crc, cve, czk, djf, dkk, dop, dzd, egp, etb, eur, fjd, fkp, gbp, gel, gip, gmd, gnf, gtq, gyd, hkd, hnl, hrk, htg, huf, idr, ils, inr, isk, jmd, jod, jpy, kes, kgs, khr, kmf, krw, kwd, kyd, kzt, lak, lbp, lkr, lrd, lsl, mad, mdl, mga, mkd, mmk, mnt, mop, mur, mvr, mwk, mxn, myr, mzn, nad, ngn, nio, nok, npr, nzd, omr, pab, pen, pgk, php, pkr, pln, pyg, qar, ron, rsd, rub, rwf, sar, sbd, scr, sek, sgd, shp, sle, sos, srd, std, szl, thb, tjs, tnd, top, try, ttd, twd, tzs, uah, ugx, uyu, uzs, vnd, vuv, wst, xaf, xcd, xof, xpf, yer, zar, zmw, usdc, btn, ghs, eek, lvl, svc, vef, ltl, sll, mro",
 "param":"currency",
 "request_log_url":"https://dashboard.stripe.com/test/logs/req_a4i9PQ2MlIh5Qv?t=1728248846",
 "type":"invalid_request_error"
 }
 }
 */

//------------------------------------------------------

/*
{
"error":
{
"code":"resource_missing","doc_url":"https://stripe.com/docs/error-codes/resource-missing",
"message":"No such customer: 'StripeConstants.customerId'",
"param":"customer",
"request_log_url":"https://dashboard.stripe.com/test/logs/req_VmQmsmWC97qJsD?t=1728249083",
"type":"invalid_request_error"
}
}
*/
