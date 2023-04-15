import 'dart:convert';
import 'Dog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final dogProvider = FutureProvider<String>((ref) async {
  final dogService = DogService();
  return dogService.getDogImage();
});

class DogService {
  Future<String> getDogImage() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load dog image');
    }
  }
}
