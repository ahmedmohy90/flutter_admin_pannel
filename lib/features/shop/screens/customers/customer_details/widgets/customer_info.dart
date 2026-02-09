import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/authentication/models/user_model.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          // Personal Info Card
          Row(
            children: [
              TRoundedImage(
                padding: 0,
                backgroundColor: TColors.primaryBackground,
                image: customer.profilePicture!.isNotEmpty
                    ? customer.profilePicture
                    : TImages.user,
                imageType: customer.profilePicture!.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.fullName,
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      customer.email!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          // Address Card
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Username'),
              ),
              const Text(':'),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                child:
                    Text(customer.userName!, style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Country'),
              ),
              const Text(':'),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                child: Text('Egypt',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('phone number'),
              ),
              const Text(':'),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                child: Text(customer.phoneNumber!,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          const Divider(),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          // Additional Details
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Orde',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('7 days ago, #[36d54]'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Avarage Order Value',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('\$352'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registered',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(customer.createAt.toString()),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Marketing',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('Subscribed'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
