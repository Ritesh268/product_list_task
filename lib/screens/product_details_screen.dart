import 'package:flutter/material.dart';
import 'package:product_list_task/config/theme/app_colors.dart';
import 'package:product_list_task/config/theme/app_text_style.dart';
import 'package:product_list_task/constants/app_const_text.dart';
import 'package:product_list_task/constants/app_sizes.dart';
import 'package:product_list_task/model/product_list_model.dart';
import 'package:product_list_task/provider/product_list_viewmodel.dart';
import 'package:product_list_task/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductListModel item;
  const ProductDetailsScreen({super.key, required this.item});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItemCount = context.watch<ProductListProvider>().cartItemCount;
    return Scaffold(
      appBar: appBar(cartItemCount),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(5.0),
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: imageWidget(widget.item.image ?? ''),
                  ),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  productDetailsWidget(),
                ],
              ),
            ),
          ),
          addToCartButton(),
        ],
      ),
    );
  }

  AppBar appBar(int cartItemCount) {
    return AppBar(
        title: Text(
          AppConstString.productDetails,
          style: AppTextStyle.black22Bold,
        ),
        actions: [
          Stack(children: <Widget>[
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),
            Positioned(
              right: 0,
              top: 0,
              child: cartItemCount > 0
                  ? Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppColors.btnColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        '$cartItemCount',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),
            )
          ])
        ]);
  }

  Widget imageWidget(String item) {
    return Image.network(
      item,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  Widget productDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.item.title ?? '',
          style: AppTextStyle.black14Font600,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          '\$${widget.item.price.toString()}',
          style: AppTextStyle.black14Font600,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          AppConstString.productDetails,
          textAlign: TextAlign.center,
          style: AppTextStyle.black16Bold,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          widget.item.description ?? '',
          style: AppTextStyle.black14Normal,
        ),
      ],
    );
  }

  Widget addToCartButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        color: Colors.white.withOpacity(0.9),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.btnColor,
            textStyle:
                AppTextStyle.black12Normal.copyWith(color: AppColors.white),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Provider.of<ProductListProvider>(context, listen: false)
                .add(widget.item);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppConstString.addedToCart,
                  style: AppTextStyle.black14W500.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            );
          },
          child: Text(
            AppConstString.addToCart,
            style: AppTextStyle.black16Bold.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
