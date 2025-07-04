import 'package:demo_first/core/constants/app_colors.dart';
import 'package:demo_first/core/constants/app_strings.dart';
import 'package:demo_first/core/widgets/app_button.dart';
import 'package:demo_first/features/dashboard/domain/di/dashboard_injector.dart';
import 'package:demo_first/features/home/domain/di/home_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../home/data/models/product_res_model.dart';
import '../../domain/di/product_detail_injector.dart';


class ProductDetailPage extends ConsumerStatefulWidget {
  final ProductResModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {


  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = ref.read(productDetailViewModelProvider.notifier);
      vm.getProductDetail(widget.product);
    });
  }
  @override
  Widget build(BuildContext context) {
    final state=ref.watch(productDetailViewModelProvider);
    final vm=ref.watch(productDetailViewModelProvider.notifier);
    final homeVM=ref.watch(homeViewModelProvider.notifier);
    final dashVM=ref.watch(dashViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: AppText(state.productData?.name ?? 'Product Detail',style:Theme.of(context).textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    state.productData?.imageUrl??'',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container( height: 250,
                      width: double.infinity,color: AppColors.colorGrey,),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Product Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  state.productData?.name ?? 'Unknown Product',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 20,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color:AppColors.colorPrimary,
                    borderRadius: BorderRadius.circular(5),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          dashVM.decreaseQuantity(state.productData?.name??'',ref);
                          vm.updateDecreaseQuantity(homeVM,ref);
                        },
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Container(
                              height: 1.5,
                              width: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      AppText("${state.productData?.quantity ?? 0}",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            if(state.productData!=null){
                              dashVM.increaseQuantity(state.productData?.name??'');
                              vm.updateIncreaseQuantity(homeVM,ref);
                            }

                          },
                          child: Icon(Icons.add,color: AppColors.colorWhite,size: 20,)),
                    ],
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10),

            // Rating
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 5),
                AppText(
                  state.productData?.rating != null ? state.productData?.rating!.toStringAsFixed(1)??'' : 'N/A',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Description
            AppText(
              state.productData?.description ?? 'No description available.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: AppText(
                "\$${state.productData?.price}",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
             AppButton(state.productData?.isCart==true?AppStrings.textRemoveFromCart:AppStrings.textAddToCart,
               onTap: (){
               if(state.productData!=null){
                 homeVM.addRemoveCart(state.productData!, ref);
               }

               vm.updateCartStatus();

               },
             )


          ],
        ),
      ),
    );
  }
}
