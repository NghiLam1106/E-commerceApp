import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front_end/controller/address_controller.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/controller/order_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/constants.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/core/utils/calculate_sum_price.dart';
import 'package:front_end/model/address_model.dart';
import 'package:front_end/model/cart_model.dart';
import 'package:front_end/model/order_model.dart';
import 'package:front_end/presentation/screens/cart/widgets/cart_item.dart';
import 'package:front_end/presentation/screens/checkout/widgets/billing_address_section.dart';
import 'package:front_end/presentation/screens/checkout/widgets/billing_amount_section.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ProductController productController = ProductController();
  final CartController cartController = CartController();
  final AddressController addressController = AddressController();
  final OrderController orderController = OrderController();
  String price = '0';
  Map<String, dynamic>? paymentIntent;
  final user = FirebaseAuth.instance.currentUser;
  List<CartModel> cartList = [];
  String idAddress = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final data = await cartController.getUserCartFuture(user!.uid);
    final dataNotPaid = data.where((e) => e.paid == false).toList();
    setState(() {
      cartList = dataNotPaid;
    });
    final sumPrice = await calculateSumPrice(cartList: cartList);
    setState(() {
      price = sumPrice;
    });
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'currency': currency,
        'amount': (double.parse(amount).round()).toString(),
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
      rethrow; // Better to rethrow so the caller knows something went wrong
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
        (value) async {
          await Stripe.instance.confirmPaymentSheetPayment();

          final addressRef = addressController.createRefAddress(idAddress);
          final cartRef = <DocumentReference>[];
          for (var e in cartList) {
            final ref = cartController.createRefCart(e.id ?? "", user!.uid);
            cartRef.add(ref);
          }

          final order = OrderModel(
              userId: user!.uid,
              addressRef: addressRef,
              cartRef: cartRef,
              deleveryDate: Timestamp.now(),
              orderDate: Timestamp.now());
          await orderController.addOrder(order);
          await cartController.markCartsAsPaid(
              userId: user!.uid, cartList: cartList);
          context.go('/success');
        },
      );
      paymentIntent = null;
    } on StripeException catch (e) {
      log('Stripe Exception: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('General Exception: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> makePayment(String price) async {
    try {
      paymentIntent = await createPaymentIntent(price, "VND");
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: true,
          merchantDisplayName: 'Le Xuan Tuyen',
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'VN',
            currencyCode: 'VND',
            testEnv: true,
          ),
        ),
      );

      await displayPaymentSheet();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: ${e.toString()}')),
      );
    }
  }

  void snackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bạn chưa thêm địa chỉ nhận hàng.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppbarCustom(
        showBackArrow: true,
        title: Text(
          'Tổng quan đơn hàng',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              CartItems(showAddRemoveBtn: false),
              const SizedBox(height: AppSizes.spaceBtwSections),
              RoundedContainer(
                padding: const EdgeInsets.all(AppSizes.defaultSpace),
                showBorder: true,
                backgroundColor: dark ? AppColors.black : AppColors.white,
                child: Column(
                  children: [
                    // Pricing
                    BillingAmountSection(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    const Divider(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    const SizedBox(height: AppSizes.spaceBtwItems),

                    StreamBuilder<List<AddressModel>>(
                        stream: addressController
                            .getAddressIdsByUserIdStream(user!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          List<AddressModel> productsList = snapshot.data!;

                          List<AddressModel> activeAddresses = productsList
                              .where((e) => e.status == 'active')
                              .toList();

                          if (activeAddresses.isNotEmpty &&
                              idAddress != activeAddresses.first.id) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                idAddress = activeAddresses.first.id!;
                              });
                            });
                          }

                          if (activeAddresses.isEmpty) {
                            return Text("Bạn chưa thêm địa chỉ nhận hàng.");
                          }
                          return BillingAddressSection(
                            activeAddresses: activeAddresses,
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: ElevatedButton(
            onPressed:
                idAddress == '' ? () => snackbar() : () => makePayment(price),
            child: const Text('Thanh toán'),
          )),
    );
  }
}
