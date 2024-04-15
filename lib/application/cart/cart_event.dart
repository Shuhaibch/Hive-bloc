part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final Cart product;

  const AddProduct({required this.product});
}

class UpdateCartProduct extends CartEvent {
  final Cart product;

  const UpdateCartProduct({required this.product});
}

class DeleteCart extends CartEvent {
  final Cart product;

  const DeleteCart({required this.product});
}

class FetchCart extends CartEvent {}
