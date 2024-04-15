import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:datacube/domain/cart/cart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  late final Box box = Hive.box('cartBox');
  CartBloc() : super(CartInitial()) {
    on<AddProduct>((event, emit) async {
      // box = Hive.box('cartBox');
      await Hive.openBox('cartBox');

      try {
        emit(ProductAddLoading());
        if (box.containsKey(event.product.id)) {
          log(event.product.name.toString());
          // final int count = event.product.count;
          Cart cart = box.get(event.product.id);
          cart = cart.copyWith(count: cart.count + 1);
          await box.put(event.product.id, cart);
        } else {
          log('message');
          await box.put(event.product.id, event.product);
          log(event.product.toString());
        }

        emit(ProductAddSuccess());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(ProductAddFailes());
      }
    });
    on<DeleteCart>((event, emit) async {
      await Hive.openBox('cartBox');

      print(event.product.id.toString());
      // box = Hive.box('cartBox');
      try {
        emit(ProductDeleteLoading());

        await box.delete(event.product.id);
        emit(ProductDeleteSuccess());
      } catch (e) {
        print(e);
        emit(ProductDeletefailed());
      }
    });

    on<FetchCart>((event, emit) async {
      await Hive.openBox('cartBox');

      // box = Hive.box('cartBox');
      try {
        emit(ProductGetLoading());

        final List<dynamic> cart = box.values.toList();
        emit(ProductGetSucess(product: cart));
      } catch (e) {
        print(e);
        emit(ProductGetfailed());
      }
    });

    on<UpdateCartProduct>((event, emit) async {
      await Hive.openBox('cartBox');

      print(event.product.id.toString());
      // box = Hive.box('cartBox');

      try {
        emit(ProductUpdateLoading());
        if (event.product.count <= 0) {
          await box.delete(event.product.id);
        } else {
          await box.put(event.product.id, event.product);
        }
        emit(ProductUpdateSucess());
      } catch (e) {
        print(e);
        emit(ProductUpdatefailed());
      }
    });
  }
}
