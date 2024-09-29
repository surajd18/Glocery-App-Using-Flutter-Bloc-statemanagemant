part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeLoadedSuccesState extends HomeState{

  final List<ProductDataModel> products;

  HomeLoadedSuccesState({
    required this.products
  });
}

class HomeErrorState extends HomeState{
  final String Error;

  HomeErrorState(this.Error);
  
}

class HomeNavigateToWishlistPageActionState extends HomeActionState{}

class HomeNavigateToCartPageActionState extends HomeActionState{}

class HomeProductWishlistedActionState extends HomeActionState{}

class HomeProductCartedActionState extends HomeActionState{}




