import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool loading = false;
  ApiService api = ApiService();

  UserModel? get user => _user;

  Future<void> loadFromStorage() async {
    final p = await SharedPreferences.getInstance();
    final token = p.getString('token');
    if (token != null) {
      _user = UserModel(id: p.getString('id') ?? '', name: p.getString('name') ?? '', email: p.getString('email') ?? '', token: token);
      notifyListeners();
    }
  }

  Future<String?> login(String email, String password) async {
    loading = true; notifyListeners();
    try {
      final r = await api.login(email, password);
      if (r.containsKey('token')) {
        _user = UserModel(id: r['user']['id'], name: r['user']['name'], email: r['user']['email'], token: r['token']);
        final p = await SharedPreferences.getInstance();
        await p.setString('token', _user!.token);
        await p.setString('id', _user!.id);
        await p.setString('name', _user!.name);
        await p.setString('email', _user!.email);
        loading = false; notifyListeners();
        return null;
      }
      loading = false; notifyListeners();
      return r['message'] ?? 'Login failed';
    } catch (e) { loading = false; notifyListeners(); return e.toString(); }
  }

  Future<String?> register(String name, String email, String password) async {
    loading = true; notifyListeners();
    try {
      final r = await api.register(name, email, password);
      if (r.containsKey('token')) {
        _user = UserModel(id: r['user']['id'], name: r['user']['name'], email: r['user']['email'], token: r['token']);
        final p = await SharedPreferences.getInstance();
        await p.setString('token', _user!.token);
        await p.setString('id', _user!.id);
        await p.setString('name', _user!.name);
        await p.setString('email', _user!.email);
        loading = false; notifyListeners();
        return null;
      }
      loading = false; notifyListeners();
      return r['message'] ?? 'Register failed';
    } catch (e) { loading = false; notifyListeners(); return e.toString(); }
  }

  Future<void> logout() async {
    _user = null; notifyListeners();
    final p = await SharedPreferences.getInstance(); await p.clear();
  }
}