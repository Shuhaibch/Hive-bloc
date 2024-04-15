import 'package:bloc/bloc.dart';
import 'package:datacube/domain/products/products_model.dart';
import 'package:datacube/infrastructure/product/poduct_implentation.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductImplentation _productImplentation;
  ProductBloc({required ProductImplentation productImplentation})
      : _productImplentation = productImplentation,
        super(ProductInitial()) {
    on<FetchAllProductEvent>((event, emit) async {
      emit(FetchProductLoading());
      try {
        final product = await _productImplentation.getProductDetails();
        if (product["status"] == true) {
          emit(FetchProductSuccess(product: product["data"]));
        }
      } catch (e) {
        print(e);
        emit(FetchProductFailed());
      }
    });
  }
}
