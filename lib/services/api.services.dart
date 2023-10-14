import 'package:dio/dio.dart';
import 'package:quran_app/Apis/api.dart';
import 'package:quran_app/models/ayah.dart';
import 'package:quran_app/models/juz.dart';
import 'package:quran_app/models/sura.dart';

class ApiServices {
  ApiServices._();
  final _dio = Dio();
  static final instance = ApiServices._();
  static Future<List<Sura>>? futureGetSurat;
  static Future<List<Juz>>? futureGetJuzs;
  static Future<List<Ayah>>? futureGetAyatBySura;
  void getAyatBySura(int id) {
    futureGetAyatBySura = _fetchAyatBySura(id);
  }

  void getJuzs() {
    futureGetJuzs = _fetchJuzs();
  }

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

  Future<List<Juz>> _fetchJuzs() async {
    try {
      var response = await _dio.get(Api.baseLink + Api.juzes);
      var data = response.data['juzs'];
      List<Juz> juzs = [];
      for (var element in data) {
        var ayatMapping = element['verse_mapping'];
        String firstAyahKey = ayatMapping.keys.first +
            ':' +
            ayatMapping.values.first.split('-')[0];
        String lastAyahKey =
            ayatMapping.keys.last + ':' + ayatMapping.values.last.split('-')[1];
        String firstAyah = await _fetchAyahByKey(firstAyahKey);
        String lastAyah = await _fetchAyahByKey(lastAyahKey);
        juzs.add(
          Juz(
            id: element['juz_number'],
            firstAyah: firstAyah,
            lastAyah: lastAyah,
          ),
        );
      }
      return juzs;
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }

  Future<String> _fetchAyahByKey(String key) async {
    var response =
        await _dio.get(Api.baseLink + Api.getSpecificAyahByKey + key);
    return response.data['verses'][0]['text_uthmani'];
  }

  Future<List<Ayah>> _fetchAyatBySura(int suraId) async {
    try {
      var response1 =
          await _dio.get('http://api.alquran.cloud/v1/surah/$suraId/ar.alafasy');
      var response2 = await _dio
          .get(Api.baseLink + Api.getTranslationOfSurah + suraId.toString());
      var data = response1.data!['data']['ayahs'];
      var translation = response2.data!['translations'];
      List<Ayah> ayat = [];
      int index = 0;
      for (var element in data) {
        ayat.add(
          Ayah.fromMap(element, translation[index]['text']),
        );
        index++;
      }
      return ayat;
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }
}
