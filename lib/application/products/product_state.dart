part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class FetchProductSuccess extends ProductState {
  final Products product;

  const FetchProductSuccess({required this.product});
}

class FetchProductFailed extends ProductState {}

class FetchProductLoading extends ProductState {}
