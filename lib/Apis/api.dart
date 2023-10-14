class Api {
  Api._();
  static const baseLink = 'https://api.quran.com/api/v4/';
  static const surat = 'chapters/';
  static const ayatBySurat = 'quran/verses/uthmani?chapter_number=';
  static const juzes = 'juzs';
  static const allReaders = 'resources/recitations';
  static const getAitELKursi = 'quran/verses/uthmani?verse_key=2:255';
  static const getSpecificAyahByKey = 'quran/verses/uthmani?verse_key=';
  static const getTranslationOfSurah = 'quran/translations/131?chapter_number=';
}
