import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key, required this.product});


  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {},
            child: const Text('Discard'),
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),
          SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: ()=> EditProductController.instance.editProduct(product),
                child: const Text('Edit Changes'),
              ))
        ],
      ),
    );
  }
}
