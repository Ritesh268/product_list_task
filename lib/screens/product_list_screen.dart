import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_list_task/base/base_view.dart';
import 'package:product_list_task/base/base_viewmodel.dart';
import 'package:product_list_task/config/theme/app_colors.dart';
import 'package:product_list_task/config/theme/app_text_style.dart';
import 'package:product_list_task/constants/app_const_text.dart';
import 'package:product_list_task/constants/assets_path.dart';
import 'package:product_list_task/constants/shimmer_loading.dart';
import 'package:product_list_task/model/product_list_model.dart';
import 'package:product_list_task/provider/product_list_viewmodel.dart';
import 'package:product_list_task/screens/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey.shade200,
      appBar: appBar(),
      body: BaseView<ProductListProvider>(
        onModelReady: (ProductListProvider productListProvider) async {
          Future.delayed(const Duration(microseconds: 1), () async {
            await productListProvider.getProductList();
          });
        },
        builder: (context, productListProvider, child) {
          return productListProvider.viewState == ViewState.busy
              ? const ShimmerLoading()
              : RefreshIndicator(
                  onRefresh: () async {
                    await productListProvider.getProductList();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productListProvider.listOfProduct.length,
                    itemBuilder: (context, index) {
                      final listData = productListProvider.listOfProduct[index];
                      return productsListWidget(listData, index);
                    },
                  ),
                );
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: AppColors.grey.shade200,
      title: Text(
        AppConstString.productList,
        style: AppTextStyle.black22Bold,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.short_text_sharp,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget productsListWidget(ProductListModel listData, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(item: listData),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, top: 10.0, right: 16.0, bottom: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    imageUrl: listData.image ?? '',
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AssetPath.noImageError,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          listData.title ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.black14Font600,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: 220,
                        child: Text(
                          listData.description ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.black12Normal,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '\$${listData.price.toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.black14Font600,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
