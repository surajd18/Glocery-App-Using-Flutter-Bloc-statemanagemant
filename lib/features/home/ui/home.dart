import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glocery/features/cart/ui/cart.dart';
import 'package:glocery/features/home/ui/product_tile_widget.dart';
import 'package:glocery/features/wishlist/ui/wishlist.dart';

import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
  
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Wishlist()));
        }else if(state is HomeNavigateToWishlistPageActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Wishlisted")));
        }else if(state is HomeProductCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Carted")));
        }

      },
      builder: (context, state) {
       switch(state.runtimeType){
        case HomeLoadingState:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        case HomeLoadedSuccesState:
          final successState = state as HomeLoadedSuccesState;
           return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text("Glocerry Shop"),
            actions: [
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeWishlistButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomecartButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.shopping_bag_outlined))
            ],
          ),
          body: ListView.builder(
            itemCount: successState.products.length,
            itemBuilder: (context,index){
            return ProductTileWidget(
              homeBloc: homeBloc,
              productDataModel:successState.products[index] );
          }),
        );
        case HomeErrorState:
          final error =(state as HomeErrorState).Error;
          return  Center(
            child: Text(error),
          );
        default:
          return const SizedBox();
       }
      },
    );
  }
}


