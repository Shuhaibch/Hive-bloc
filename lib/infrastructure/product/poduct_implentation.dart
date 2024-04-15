import 'dart:convert';

import 'package:datacube/domain/products/products_model.dart';
import 'package:http/http.dart' as http;

class ProductImplentation {
  Future getProductDetails() async {
    try {
      var responce =
          await http.get(Uri.parse('https://dummyjson.com/products'));
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        final Products product = Products.fromJson(jsonDecode(responce.body));
        return {"status": true, "data": product};
      } else {
        return {"status": false, "data": "failed while fetching"};
      }
    } catch (e) {
      print(e);
     return {"status": false, "data": "failed while fetching"
     };
    }
  }
}
