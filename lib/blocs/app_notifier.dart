import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pixabay_image.dart';
import '../utils/constants.dart';

class AppNotifier with ChangeNotifier {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  int get selectedIndex => _selectedIndex;
  bool get isDarkMode => _isDarkMode;

  List<PixabayImage> _trendingImages = [];
  bool _isTrendingLoading = false;
  String? _trendingError;

  List<PixabayImage> _searchResults = [];
  bool _isSearchLoading = false;
  String? _searchError;

  List<PixabayImage> get trendingImages => _trendingImages;
  bool get isTrendingLoading => _isTrendingLoading;
  String? get trendingError => _trendingError;

  List<PixabayImage> get searchResults => _searchResults;
  bool get isSearchLoading => _isSearchLoading;
  String? get searchError => _searchError;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> fetchTrendingImages() async {
    _isTrendingLoading = true;
    _trendingError = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=$kPixabayApiKey&q=popular&image_type=photo&per_page=20'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        _trendingImages = (data['hits'] as List)
            .map((item) => PixabayImage.fromJson(item))
            .toList();
      } else {
        _trendingError =
        'Failed to load trending images. Status: ${response.statusCode}';
      }
    } catch (e) {
      print(e);
      _trendingError = 'An error occurred while fetching data';
    } finally {
      _isTrendingLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchImages(String query) async {
    _isSearchLoading = true;
    _searchError = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=$kPixabayApiKey&q=$query&image_type=photo&per_page=20'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _searchResults = (data['hits'] as List)
            .map((item) => PixabayImage.fromJson(item))
            .toList();
      } else {
        _searchError =
        'Failed to load search results. Status: ${response.statusCode}';
      }
    } catch (e) {
      _searchError = 'An error occurred: $e';
    } finally {
      _isSearchLoading = false;
      notifyListeners();
    }
  }
}
