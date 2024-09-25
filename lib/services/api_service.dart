
import 'package:dio/dio.dart';
import 'package:practice/model/jewellery_model.dart';

class ApiService {
  final String baseUrl = "https://ajcjewel.com:4000/api/global-gallery/";
  final String authorizationToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTcyNjEyNTUzNCwiZXhwIjoxNzU3NjYxNTM0fQ.WtYYgVWtxVQlbwoIKdd-HcUGGAKRKMIJayaRHzqjtRU"; 
  final Dio _dio;

  ApiService() : _dio = Dio() {
    _dio.options.headers['Authorization'] = authorizationToken;
  }

  Future<List<JewelleryModel>> fetchImages() async {
    try {
      final response = await _dio.post(
        "${baseUrl}list",
        data: {
          "statusArray": [1],
          "screenType": [],
          "responseFormat": [],
          "globalGalleryIds": [],
          "categoryIds": [],
          "docTypes": [],
          "types": [],
          "limit": 10,
          "skip": 0,
          "searchingText": ""
        },
      );

      if (response.statusCode == 201) {
        final data = response.data;
        if (data['message'] == 'success') {
          return (data['data']['list'] as List)
              .map((image) => JewelleryModel.fromJson(image))
              .toList();
        } else {
          throw Exception("API returned message: ${data['message']}");
        }
      } else {
        throw Exception("Failed to fetch images. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error or other Dio exception: ${e.toString()}");
    }
  }
}
