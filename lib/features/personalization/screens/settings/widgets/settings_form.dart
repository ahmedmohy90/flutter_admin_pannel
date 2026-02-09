import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.md, vertical: TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'App Settings',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('App Name'),
                        hintText: 'App Name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Tax Rate (%)'),
                              hintText: 'Tax %',
                              prefixIcon: Icon(Iconsax.tag),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Shipping Cost (\$)'),
                              hintText: 'Shipping Cost',
                              prefixIcon: Icon(Iconsax.ship),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Free Shipping Threshold'),
                              hintText: 'Free Shipping After',
                              prefixIcon: Icon(Iconsax.ship),
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Update App Settings')),
              )
            ],
          ),
        )
      ],
    );
  }
}
