// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sura {
  Sura({
    required this.id,
    required this.revelationPlace,
    required this.englishName,
    required this.arabicName,
    required this.translatedName,
    required this.versesCount,
  });

  int id;
  String revelationPlace;
  String englishName;
  String arabicName;
  String translatedName;
  int versesCount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'revelationPlace': revelationPlace,
      'englishName': englishName,
      'arabicName': arabicName,
      'versesCount': versesCount,
    };
  }

  factory Sura.fromMap(Map<String, dynamic> map) {
    return Sura(
      id: map['id'] as int,
      revelationPlace: map['revelation_place'] as String,
      englishName: map['name_simple'] as String,
      arabicName: map['name_arabic'] as String,
      versesCount: map['verses_count'] as int,
      translatedName: map['translated_name']['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sura.fromJson(String source) =>
      Sura.fromMap(json.decode(source) as Map<String, dynamic>);
}
