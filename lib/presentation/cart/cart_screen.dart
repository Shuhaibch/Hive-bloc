import 'dart:developer';

import 'package:datacube/application/cart/cart_bloc.dart';
import 'package:datacube/domain/cart/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state is ProductDeleteSuccess) {
                  context.read<CartBloc>().add(FetchCart());
                } else if (state is ProductUpdateSucess) {
                  context.read<CartBloc>().add(FetchCart());
                }
              },
              builder: (context, state) {
                if (state is ProductGetSucess) {
                  log(state.product.length.toString());
                  return ListView.builder(
                    itemCount: state.product.length,
                    itemBuilder: (context, index) {
                      final Cart prod = state.product[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(25, 25)),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(prod.name),
                                        Text(prod.count.toString()),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                             InkWell(
                                              onTap: () {
                                                 Cart cart = Cart(
                                                    name: prod.name,
                                                    image: prod.image,
                                                    count: prod.count - 1,
                                                    id: prod.id);
                                                context.read<CartBloc>().add(
                                                    UpdateCartProduct(
                                                        product: cart));
                                              },
                                              child: Icon(Icons.minimize)),
                                            InkWell(
                                              onTap: () {
                                                Cart cart = Cart(
                                                    name: prod.name,
                                                    image: prod.image,
                                                    count: prod.count + 1,
                                                    id: prod.id);
                                                context.read<CartBloc>().add(
                                                    UpdateCartProduct(
                                                        product: cart));
                                              },
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                            onTap: () {
                                              context.read<CartBloc>().add(
                                                  DeleteCart(product: prod));
                                            },
                                            child: Icon(Icons.delete)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ProductGetfailed) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                return Container(
                  width: 20,
                  height: 25,
                  child: CircularProgressIndicator(),
                );
              },
            )));
  }
}
