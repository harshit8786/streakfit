import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exercise.dart';
import '../config.dart';

class ApiService {
  final String base = apiBase;

  dynamic _decodeBody(http.Response res) {
    if (res.body.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(res.body);
    } on FormatException {
      throw Exception('Unexpected server response (${res.statusCode})');
    }
  }

  Map<String, dynamic> _expectMap(http.Response res) {
    final decoded = _decodeBody(res);
    if (decoded is Map<String, dynamic>) {
      if (res.statusCode >= 400) {
        throw Exception(decoded['message'] ?? 'Request failed (${res.statusCode})');
      }
      return decoded;
    }

    throw Exception('Unexpected response format (${res.statusCode})');
  }

  List<dynamic> _expectList(http.Response res) {
    final decoded = _decodeBody(res);
    if (decoded is List) {
      return decoded;
    }

    if (decoded is Map<String, dynamic> && res.statusCode >= 400) {
      throw Exception(decoded['message'] ?? 'Request failed (${res.statusCode})');
    }

    throw Exception('Unexpected response format (${res.statusCode})');
  }

  Future<Map<String,dynamic>> login(String email, String password) async {
    final res = await http.post(Uri.parse('$base/api/auth/login'), headers: {'Content-Type':'application/json'}, body: jsonEncode({'email':email,'password':password}));
    return _expectMap(res);
  }

  Future<Map<String,dynamic>> register(String name, String email, String password) async {
    final res = await http.post(Uri.parse('$base/api/auth/register'), headers: {'Content-Type':'application/json'}, body: jsonEncode({'name':name,'email':email,'password':password}));
    return _expectMap(res);
  }

  Future<List<Exercise>> fetchExercisesByDay(String day) async {
    final res = await http.get(Uri.parse('$base/api/exercises/day/$day'));
    final List data = _expectList(res);
    return data.map((e) => Exercise.fromJson(e)).toList();
  }

  Future<List<Exercise>> fetchAll() async {
    final res = await http.get(Uri.parse('$base/api/exercises'));
    final List data = _expectList(res);
    return data.map((e) => Exercise.fromJson(e)).toList();
  }

  Future<Map<String,dynamic>> markComplete(String token, String exerciseId) async {
    final res = await http.post(Uri.parse('$base/api/exercises/complete'), headers: {'Content-Type':'application/json','Authorization':'Bearer $token'}, body: jsonEncode({'exerciseId': exerciseId}));
    return _expectMap(res);
  }
}
