import 'package:bloc/bloc.dart';
import 'package:datacube/application/cart/cart_bloc.dart';
import 'package:datacube/application/products/product_bloc.dart';
import 'package:datacube/domain/cart/cart_model.dart';
import 'package:datacube/infrastructure/product/poduct_implentation.dart';
import 'package:datacube/presentation/home/home_screen.dart';
import 'package:datacube/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
   await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(CartAdapter());
  // Opening the box
  await Hive.openBox('cartBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(
            productImplentation: ProductImplentation(),
          ),
        ),
        BlocProvider(create: (context) => CartBloc(),)
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen()),
    );
  }
}
