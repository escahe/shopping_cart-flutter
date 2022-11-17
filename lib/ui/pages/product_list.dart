import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/product.dart';
import '../Widgets/banner.dart';
import '../controllers/shopping_controller.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    ShoppingController shoppingController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [const CustomBanner(50), customAppBar()],
            ),
            // aquí debemos rodear el widget Expanded en un Obx para
            // observar los cambios en la lista de entries del shoppingController
            Obx(
              () => Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: shoppingController.entries.length,
                    itemBuilder: (context, index) {
                      return _row(shoppingController.entries[index], index);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _row(Product product, int index) {
    return _card(product);
  }

  Widget _card(Product product) {
    ShoppingController shoppingController = Get.find();

    return Card(
      margin: const EdgeInsets.all(4.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(product.name),
        Text('\$${product.price}'),
        Column(
          children: [
            const Text('Quantity'),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // aquí debemos llamar al método del controlador que
                      // incrementa el número de unidades del producto
                      // pasandole el product.id
                      shoppingController.agregarProducto(product.id);
                    },
                    icon: const Icon(Icons.arrow_upward),
                    iconSize: 15,
                    tooltip: "increase quantity",
                  ),
                  Text('${product.quantity}'),
                  IconButton(
                    onPressed: () {
                      // aquí debemos llamar al método del controlador que
                      // disminuye el número de unidades del producto
                      // pasandole el product.id
                      shoppingController.quitarProducto(product.id);
                    },
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 15,
                    tooltip: "decrease quantity",
                  )
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
