part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class ProductAddSuccess extends CartState {}

class ProductAddLoading extends CartState {}

class ProductAddFailes extends CartState {}

class ProductDeleteSuccess extends CartState {}

class ProductDeleteLoading extends CartState {}

class ProductDeletefailed extends CartState {}

class ProductUpdatefailed extends CartState {}

class ProductUpdateSucess extends CartState {}

class ProductUpdateLoading extends CartState {}

class ProductGetfailed extends CartState {}

class ProductGetSucess extends CartState {
  final List product;

  const ProductGetSucess({required this.product});
}

class ProductGetLoading extends CartState {}
