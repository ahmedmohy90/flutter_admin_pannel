import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/common/widgets/responsive/responsive_design.dart';
import 'package:admin_pannel/routes/app_routes.dart';
import 'package:admin_pannel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils/bindings/general_bindings.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final Uri _productUri =
      Uri.parse('https://codingwitht.com/ecommerce-app-with-admin-panel/');

  Future<void> _openProductPage() async {
    // On web this will open a new tab automatically
    if (!await launchUrl(_productUri, webOnlyWindowName: '_blank')) {
      debugPrint('Could not launch $_productUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: TRoutes.dashboard,
      initialBinding: GeneralBindings(),
      getPages: TAppRoutes.pages,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        ),
      ),
      // home: const FirstScreen()
      // Scaffold(
      //   backgroundColor: TColors.primary,
      //   body: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 32.0),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           const Text(
      //             '🎉 Starter Kit Ready! 🎉\n\n'
      //             'Your project structure is set up and running. Happy coding!',
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 20,
      //               height: 1.5,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //           const SizedBox(height: 40),
      //           MouseRegion(
      //             cursor: SystemMouseCursors.click,
      //             child: GestureDetector(
      //               onTap: _openProductPage,
      //               child: Container(
      //                 padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(8),
      //                 ),
      //                 child: const Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     Icon(Icons.shopping_cart_outlined, color: TColors.primary),
      //                     SizedBox(width: 8),
      //                     Text(
      //                       'Get the Full E-Commerce App',
      //                       style: TextStyle(
      //                         color: TColors.primary,
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
        mobile: MobileScreen(),
        tablet: TabletScreen(),
        desktop: DesktopScreen());
  }
}

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  TRoundedContainer(
                    height: 450,
                    backgroundColor: Colors.blue.withOpacity(0.2),
                    child: const Center(
                      child: Text('Box 1'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TRoundedContainer(
                    height: 215,
                    backgroundColor: Colors.orange.withOpacity(0.2),
                    child: const Center(
                      child: Text('Box 2'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                      child: TRoundedContainer(
                        height: 215,
                        backgroundColor: Colors.red.withOpacity(0.2),
                        child: const Center(
                          child: Text('Box 3'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TRoundedContainer(
                        height: 215,
                        backgroundColor: Colors.green.withOpacity(0.2),
                        child: const Center(
                          child: Text('Box 4'),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(children: [
          Expanded(
            flex: 2,
            child: TRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.red.withOpacity(0.2),
              child: const Center(
                child: Text('Box 5'),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.red.withOpacity(0.2),
              child: const Center(
                child: Text('Box 6'),
              ),
            ),
          ),
        ])
      ],
    );
  }
}

class TabletScreen extends StatelessWidget {
  const TabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  TRoundedContainer(
                    height: 450,
                    backgroundColor: Colors.blue.withOpacity(0.2),
                    child: const Center(
                      child: Text('Box 1'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TRoundedContainer(
                    height: 215,
                    backgroundColor: Colors.orange.withOpacity(0.2),
                    child: const Center(
                      child: Text('Box 2'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                      child: TRoundedContainer(
                        height: 215,
                        backgroundColor: Colors.red.withOpacity(0.2),
                        child: const Center(
                          child: Text('Box 3'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TRoundedContainer(
                        height: 215,
                        backgroundColor: Colors.green.withOpacity(0.2),
                        child: const Center(
                          child: Text('Box 4'),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(mainAxisSize: MainAxisSize.min, children: [
          TRoundedContainer(
            height: 190,
            width: double.infinity,
            backgroundColor: Colors.red.withOpacity(0.2),
            child: const Center(
              child: Text('Box 5'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TRoundedContainer(
            height: 190,
            width: double.infinity,
            backgroundColor: Colors.red.withOpacity(0.2),
            child: const Center(
              child: Text('Box 6'),
            ),
          ),
        ])
      ],
    );
  }
}

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          height: 450,
          width: double.infinity,
          backgroundColor: Colors.blue.withOpacity(0.2),
          child: const Center(
            child: Text('Box 1'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TRoundedContainer(
          height: 215,
          width: double.infinity,
          backgroundColor: Colors.orange.withOpacity(0.2),
          child: const Center(
            child: Text('Box 2'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TRoundedContainer(
          height: 215,
          width: double.infinity,
          backgroundColor: Colors.red.withOpacity(0.2),
          child: const Center(
            child: Text('Box 3'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TRoundedContainer(
          height: 215,
          width: double.infinity,
          backgroundColor: Colors.green.withOpacity(0.2),
          child: const Center(
            child: Text('Box 4'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TRoundedContainer(
          height: 190,
          width: double.infinity,
          backgroundColor: Colors.red.withOpacity(0.2),
          child: const Center(
            child: Text('Box 5'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TRoundedContainer(
          height: 190,
          width: double.infinity,
          backgroundColor: Colors.red.withOpacity(0.2),
          child: const Center(
            child: Text('Box 6'),
          ),
        ),
      ],
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              'Simple Navigation: Default Flutter Navigation vs Getx Navigation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SecondScreen()));
                },
                child: Text('Default Navigation'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const SecondScreen()),
                child: Text('Getx Navigation'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            const Divider(),
            const Text(
              'Named Navigation:  Flutter Navigation vs Getx Navigation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/second-screen'),
                child: Text('Default Navigation'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/second-screen'),
                child: Text('Getx Navigation'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            const Divider(),
            const Text(
              'Pass Data between screens - GetX',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/second-screen/9390',
                    arguments: 'Getx is fun with Cmt!'),
                child: Text('Pass Data in url'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                    '/second-screen?device=phone&id=1231&name=isak'),
                child: Text('Pass Data in arguments'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                    '/second-screen?device=phone&id=1231&name=isak',
                    arguments: 'Getx is fun with Cmt!'),
                child: Text('Pass Data in URL with arguments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        Get.arguments == null
            ? const SizedBox.shrink()
            : Text(Get.arguments.toString()),
        Get.parameters['device'] == null
            ? const SizedBox.shrink()
            : Text(Get.parameters['device'].toString()),
        Get.parameters['id'] == null
            ? const SizedBox.shrink()
            : Text(Get.parameters['id'].toString()),
        Get.parameters['name'] == null
            ? const SizedBox.shrink()
            : Text(Get.parameters['name'].toString()),
      ])),
    );
  }
}
