import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:loftfin/services/log_service.dart';

import '../models/api_response.dart';

class ApiClient {
  final String baseUrl = FlavorConfig.instance.variables['BASE_URL'];
  final int timeOut = 10;

  Future<ApiResponse> getDataFromServer({
    required String url,
    required Map<String, String> header,
  }) async {
    dPrint('GET --------- $url');
    try {
      http.Response response = await http.get(
        Uri.parse(baseUrl + url),
        headers: header,
      );

      if (response.statusCode == 200) {
        return ApiResponse(false, '', response.body);
      } else {
        dPrint('statue code --- ${response.statusCode}');
        return ApiResponse(true, 'Error getting response from server', '');
      }
    } on SocketException {
      return ApiResponse(true, 'No internet connection', '');
    }
  }

  Future<ApiResponse> createRecordOnServer({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> header,
  }) async {
    dPrint('POST --------- ${baseUrl + url}');
    dPrint('body --------- $body');
    dPrint('header --------- $header');

    try {
      var bodyNew = json.encode(body);

      http.Response response = await http.post(Uri.parse(baseUrl + url),
          body: bodyNew, headers: header);
      if (response.statusCode == 200) {
        return ApiResponse(false, '', response.body);
      } else {
        dPrint('statue code ---1 ${response.statusCode}');
        return ApiResponse(true, 'Error getting response from server', '');
      }
    } on SocketException {
      return ApiResponse(true, 'No internet connection', '');
    }
  }

  Future<ApiResponse> updateRecordOnServer({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> header,
  }) async {
    dPrint('PUT --------- $url');
    try {
      var bodyNew = json.encode(body);

      http.Response response = await http.put(
        Uri.parse(baseUrl + url),
        body: bodyNew,
        headers: header,
      );

      if (response.statusCode == 200) {
        return ApiResponse(false, '', response.body);
      } else {
        dPrint('statue code ---2 ${response.statusCode}');
        return ApiResponse(true, 'Error getting response from server', '');
      }
    } on SocketException {
      return ApiResponse(true, 'No internet connection', '');
    }
  }

  Future<ApiResponse> deleteRecordFromServer({
    required String url,
    required Map<String, String> header,
  }) async {
    try {
      dPrint('DELETE --------- $url');

      http.Response response =
          await http.delete(Uri.parse(baseUrl + url), headers: header);
      if (response.statusCode == 200) {
        return ApiResponse(false, '', response.body);
      } else {
        dPrint('statue code ---2 ${response.statusCode}');
        return ApiResponse(true, 'Error getting response from server', '');
      }
      return ApiResponse(false, '', response.body);
    } on SocketException {
      return ApiResponse(true, 'No internet connection', '');
    }
  }
}
