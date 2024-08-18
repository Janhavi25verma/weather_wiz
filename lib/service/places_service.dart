import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../components/hidden.dart';

class PlacesService {

  Future<List<dynamic>> fetchPlaces(double lat, double lon, String placeType) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lon&radius=5000&type=$placeType&key=$googleApiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

        print("API RESPONSE: $data");

      return data['results'] as List<dynamic>;
    } else {
      throw Exception('Failed to load places');
    }
  }
}
