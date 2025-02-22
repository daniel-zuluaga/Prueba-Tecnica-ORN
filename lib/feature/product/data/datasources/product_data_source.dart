import 'dart:convert';

import 'package:prueba_tecnica_orn/core/config/helpers/api.dart';
import 'package:prueba_tecnica_orn/core/config/helpers/endpoints.dart';
import 'package:prueba_tecnica_orn/core/config/helpers/errors/invalid_data.dart';
import 'package:prueba_tecnica_orn/feature/product/data/models/product_model.dart';

class ProductDataSource {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await Api.get(Endpoints.allProducts);

      if (response.statusCode == 200) {
        final products = productModelFromMap(response.body);
        return products;
      } else {
        throw InvalidData(
            message: 'Hubo un problema al consultar los productos');
      }
    } catch (e) {
      throw InvalidData(message: 'Hubo un problema al consultar los productos');
    }
  }

  Future<ProductModel> fetchProductById({required String id}) async {
    try {
      final response = await Api.get("${Endpoints.allProducts}/$id");
      if (response.statusCode == 200) {
        return ProductModel.fromMap(jsonDecode(response.body));
      } else {
        throw InvalidData(
            message: 'Error al consultar este producto. Con el id: $id');
      }
    } catch (e) {
      throw InvalidData(
          message: 'Error al consultar este producto. Con el id: $id');
    }
  }
}
