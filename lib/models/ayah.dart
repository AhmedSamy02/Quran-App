// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ayah {
  Ayah({
    required this.id,

    required this.text,
    required this.translatedText,
    required this.audioUrl,
  });
  int id;

  String text;
  String translatedText;
  String audioUrl;

  factory Ayah.fromMap(Map<String, dynamic> map, String translated) {
    return Ayah(
      id: map['numberInSurah'] as int,
      text: map['text'] as String,
      translatedText: translated,
      audioUrl: map['audio']as String
    );
  }

}
