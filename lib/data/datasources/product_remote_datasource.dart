import 'package:dartz/dartz.dart';
import 'package:flutter_posresto_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_posresto_app/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

class ProductRemoteDatasource{

  Future<Either<String, ProductResponseModel>> getProducts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-products');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}'}
    );

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get products');
    }
  }
}