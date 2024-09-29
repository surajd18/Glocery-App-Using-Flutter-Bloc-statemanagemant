import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:glocery/features/home/models/cart_items.dart';
import 'package:glocery/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitial);
    on<CartRemoveFromCart>(cartRemoveFromCart);
  }



  FutureOr<void> cartInitial(CartInitialEvent event, Emitter<CartState> emit) {

    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCart(CartRemoveFromCart event, Emitter<CartState> emit) {

    cartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
  }
}
