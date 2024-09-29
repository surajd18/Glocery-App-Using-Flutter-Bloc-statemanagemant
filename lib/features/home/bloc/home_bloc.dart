import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:glocery/data/glocery_data.dart';
import 'package:glocery/features/home/models/cart_items.dart';
import 'package:glocery/features/home/models/home_product_data_model.dart';
import 'package:glocery/features/home/models/wishlist_items.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomecartButtonNavigateEvent>(homecartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit)async {
    emit(HomeLoadingState());
    try{
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccesState(products: GroceryData.groceryProducts
    .map((e) => ProductDataModel(
      id: e['id'], 
      name: e['name'], 
      description: e['description'], 
      price: e['price'], 
      imageUrl: e['imageUrl']
      )).toList()
      ));
    }catch(e)
    {
      emit(HomeErrorState(e.toString()));
    }
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
    HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {

      print("Wishlist Product Clicked");

      wishlistItems.add(event.clickedProduct);
      emit(HomeProductWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
    HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {

      print("Cart Product Clicked");
      cartItems.add(event.clickedProduct);
      emit(HomeProductCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
    HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
      print("Wishlist Clicked");

      emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homecartButtonNavigateEvent(
    HomecartButtonNavigateEvent event, Emitter<HomeState> emit) {
      print("Cart Clicked");
      emit(HomeNavigateToCartPageActionState());
  }

  
}
