import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_list_task/model/product_list_model.dart';
import 'package:product_list_task/utils/api_path.dart';

class ApiCollection {
  static Future<List<ProductListModel>> dashboardListApi({
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.baseUrl),
        headers: {
          'Content-Type': ApiConstants.contentjson,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => ProductListModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
