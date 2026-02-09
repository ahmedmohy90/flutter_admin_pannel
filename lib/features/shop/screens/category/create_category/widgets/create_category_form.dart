import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/image_uploader.dart';
import 'package:admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../../../controllers/category/create_category_controller.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createCategoryController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());

    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: createCategoryController.formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: TSizes.sm,
            ),
            Text('Create New Caegory',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TextFormField(
              controller: createCategoryController.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.category),
                  hintText: 'Category Name'),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            // categories dropdown
            Obx(
              () => categoryController.isLoading.value
                  ? const TShimmerEffect(width: double.infinity, height: 55)
                  : DropdownButtonFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.bezier),
                          hintText: 'Parent Category',
                          labelText: 'Parent Category'),
                      onChanged: (newValue) => createCategoryController
                          .selectedParent.value = newValue!,
                      items: categoryController.allItems
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(category.name.capitalize.toString()),
                                  ],
                                ),
                              ))
                          .toList()),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
            Obx(
              () => TImageUploader(
                width: 80,
                height: 80,
                image: createCategoryController.imageURL.value.isNotEmpty
                    ? createCategoryController.imageURL.value
                    : TImages.defaultImage,
                imageType: createCategoryController.imageURL.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => createCategoryController.pickImage(),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              () => CheckboxMenuButton(
                value: createCategoryController.isFeatured.value,
                onChanged: (value) =>
                    createCategoryController.isFeatured.value = value ?? false,
                child: const Text('Featured'),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => createCategoryController.createCategory(),
                child: const Text('Create'),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
          ],
        ),
      ),
    );
  }
}
