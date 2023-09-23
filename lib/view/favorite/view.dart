import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../widget/product/grid_product_view.dart';
import 'logic.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.1),
      appBar: AppBar(title: const Text("Favorite"),),
      body: Column(
        children: [

          const SizedBox(height: 20,),

          /// Latest Product
          StaggeredGridView.countBuilder(
            itemCount: 4,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            itemBuilder: (BuildContext context, int index) {
              return const ProductView();
            },
          ),
        ],
      ),
    );
  }
}
