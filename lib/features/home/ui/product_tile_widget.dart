// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:glocery/features/home/bloc/home_bloc.dart';

import 'package:glocery/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({
    Key? key,
    required this.productDataModel, 
    required this.homeBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black)
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              
              image: DecorationImage(
                fit: BoxFit.cover,
              image:
              NetworkImage(productDataModel.imageUrl)

              )
            ),

            
          ),
          const SizedBox(height: 20,),
          Text(productDataModel.name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          Text(productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$'+productDataModel.price.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

              Row(
                children: [
                   IconButton(
                  onPressed: () {
                    homeBloc.add(HomeProductWishlistButtonClickedEvent(
                      clickedProduct: productDataModel
                    ));
                  },
                  icon: const Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeProductCartButtonClickedEvent(
                      clickedProduct: productDataModel
                    ));
                  },
                  icon: const Icon(Icons.shopping_bag_outlined))
                ],
              )
            ],
          ),

        ],
      ),
     );
  }
}
