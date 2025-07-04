import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:demo_first/core/constants/app_strings.dart';
import 'package:demo_first/core/widgets/app_text.dart';
import 'package:demo_first/features/home/data/models/product_res_model.dart';
import 'package:demo_first/features/home/presentation/pages/home_page.dart';
import 'package:demo_first/features/setting/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/theme_injector.dart';
import '../../../../core/routes/route_paths.dart';
import '../../domain/di/dashboard_injector.dart';



final dashboardIndexProvider = StateProvider<int>((ref) => 0);

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final List<Widget> _pages =  [
    HomePage(),
    // CheckoutPage(),
    SettingPage(),
  ];




  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(dashboardIndexProvider);

    final state = ref.watch(dashViewModelProvider);
    final vm = ref.read(dashViewModelProvider.notifier);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.colorPrimary,
      //   title: Text(_getTitle(currentIndex)),
      // ),
      floatingActionButton: state.cartProductList.isNotEmpty?cartFloatingActionButton(state.cartProductList):SizedBox(),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => ref.read(dashboardIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.textHome),
          // BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: AppStrings.textCart),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: AppStrings.textProfile),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return AppStrings.textHome;
      case 1:
        return AppStrings.textCart;
      case 2:
        return AppStrings.textProfile;
      default:
        return '';
    }
  }

 Widget cartFloatingActionButton(List<ProductResModel> cartProductList) {
    return GestureDetector(
      onTap: (){
        context.push(RoutePaths.checkout);
      },
      child: Container(
        key: cartKey,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(color: AppColors.colorPrimaryDark,borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:AppColors.colorPrimary, )
              ),
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(cartProductList[cartProductList.length-1].imageUrl??'',
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,

                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText('View Item',style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.colorWhite,fontSize: 12),),
                AppText('${cartProductList.length}',style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.colorWhite,fontSize: 12),),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color:AppColors.colorPrimary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.keyboard_arrow_right_outlined))
          ],),),
    );
  }
}
