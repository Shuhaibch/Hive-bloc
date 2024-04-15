import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ProductImageList(),
            SizedBox(
              height: 15,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Iphone 9 ",
                  style: TextStyle(fontSize: 20),
                ),
                Text("An apple mobile which is nothing like apples")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImageList extends StatelessWidget {
  const ProductImageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .25,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .23,
              width: MediaQuery.of(context).size.width * .8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(25, 25)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "https://cdn.dummyjson.com/product-images/1/1.jpg",
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
