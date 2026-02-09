import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Column(
            children: [
              _buildVisibilityRadioButton(
                  ProductVisibility.published, 'Published'),
              _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityRadioButton(ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
        value: value,
        groupValue: ProductVisibility.published,
        onChanged: (value) {},
        child: Text(label));
  }
}
