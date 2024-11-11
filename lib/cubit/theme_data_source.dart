import 'package:dio/dio.dart';
import 'package:matching_pairs/api_client.dart';
import 'package:matching_pairs/cubit/theme_model.dart';

abstract class ThemeDataSource  {
  Future<ThemeModelResponse> getThemes();
}

class ThemeDataSourceImpl extends ThemeDataSource {
  @override
  Future<ThemeModelResponse> getThemes() async {
    try {
      final response = await ApiClient.shared.dio.get('/v0/b/concentrationgame-20753.appspot.com/o/themes.json?alt=media&token=6898245a-0586-4fed-b30e-5078faeba078');
      ThemeModelResponse themeModelResponse = ThemeModelResponse.fromJson(response.data);
      return themeModelResponse;
    } on DioException catch (failure) {
      rethrow;
    }
  }
}