import 'package:bloc/bloc.dart';
import 'package:flutter_posresto_app/data/models/response/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/product_quantity.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddItem>((event, emit) {
      var currentState = state as _Loaded;
      List<ProductQuantity> items = [...currentState.items];
      var index = items.indexWhere((element) => element.product.id == event.product.id);
      emit(_Loading());
      if (index != -1) {
        items[index] = ProductQuantity(product: event.product, quantity: items[index].quantity + 1);
      } else {
        items.add(ProductQuantity(product: event.product, quantity: 1));
      }
      emit(_Loaded(items));
    });

    on<_RemoveItem>((event, emit) {
      var currentState = state as _Loaded;
      List<ProductQuantity> items = [...currentState.items];
      var index = 
          items.indexWhere((element) => element.product.id == event.product.id);
      emit(_Loading());   
      if (index != -1) {
        if (items[index].quantity > 1) {
            items[index] = ProductQuantity(
          product: event.product, quantity: items[index].quantity -1);
        } else {
          items.removeAt(index);
        }
      }
      emit(_Loaded(items));
    });

    on<_Started>((event, emit) {
      emit(const _Loaded([]));
    });
  }
}
