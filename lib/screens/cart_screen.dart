import 'package:flutter/material.dart';
import 'package:product_list_task/config/theme/app_colors.dart';
import 'package:product_list_task/config/theme/app_text_style.dart';
import 'package:product_list_task/constants/app_const_text.dart';
import 'package:product_list_task/provider/product_list_viewmodel.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstString.cart,
          style: AppTextStyle.black22Bold,
        ),
      ),
      body: Consumer<ProductListProvider>(
        builder: (context, cart, child) {
          return cart.items.isEmpty
              ? Center(
                  child: Text(
                    AppConstString.emptyCart,
                    style: AppTextStyle.black16Bold,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cart.items.length,
                          itemBuilder: (context, index) {
                            final product = cart.items.keys.elementAt(index);
                            final quantity = cart.items[product]!;
                            return Card(
                              child: ListTile(
                                leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(product.image ?? '')),
                                title: Text(
                                  product.title ?? '',
                                  style: AppTextStyle.black16Bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$${product.price!.toStringAsFixed(2)}',
                                      style: AppTextStyle.black14w500,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            cart.remove(product);
                                          },
                                        ),
                                        Text(quantity.toString()),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            cart.add(product);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    cart.remove(product);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          color: AppColors.grey.shade300,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppConstString.totalItem} ${cart.items.length}',
                                    style: AppTextStyle.black14Normal,
                                  ),
                                  Text(
                                    '\$${cart.totalPrice.toStringAsFixed(2)}',
                                    style: AppTextStyle.black16Bold,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.white,
                                backgroundColor: AppColors.btnColor,
                                textStyle: AppTextStyle.black12Normal
                                    .copyWith(color: AppColors.white),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                AppConstString.placeOrder,
                                style: AppTextStyle.black16Bold.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
