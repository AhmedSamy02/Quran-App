import 'package:dio/dio.dart';
import 'package:quran_app/Apis/api.dart';
import 'package:quran_app/models/sura.dart';

class ApiServices {
  ApiServices._();
  final _dio = Dio();
  static final instance = ApiServices._();
  static Future<List<Sura>>? futureGetSurat;
  void getSurat() {
    futureGetSurat = _fetchAllSurats();
  }

  Future<List<Sura>> _fetchAllSurats() async {
    try {
      var response = await _dio.get(Api.baseLink + Api.surat);
      var data = response.data['chapters'];
      List<Sura> surat = [];
      for (Map<String, dynamic> element in data) {
        surat.add(Sura.fromMap(element));
      }
      return surat;
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }
}
