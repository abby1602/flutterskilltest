import 'dart:convert';

import 'package:flutter_skills_test/model/vehicle_api_result_model.dart';
import 'package:flutter_skills_test/model/vehicle_model.dart';
import 'package:flutter_skills_test/services/generic_service.dart';
import 'package:http/http.dart' as http;

class VehicleServices extends GenericService {
  static VehicleServices _instance = VehicleServices._();

  VehicleServices._();

  static Future<List<Cars>> fetchVehicles() async {
    //Your Code to fetch vehicles

    final response = await http.get('https://myfakeapi.com/api/cars/');

    if (response.statusCode == 200) {
      // print(response.body);
      List<Cars> cars = ApiResult.fromJson(json.decode(response.body)).cars;
      return cars;
    } else {
      throw Exception('Failed to load !!!');
    }
  }
}
