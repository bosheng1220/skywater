import 'package:lpinyin/lpinyin.dart';

class PinyinConverter {
  static String toPinyin(String chinese) {
    // 轉為拼音並用空格分隔
    String pinyin = PinyinHelper.getPinyinE(chinese,
        separator: ' ', defPinyin: '', format: PinyinFormat.WITHOUT_TONE);

    // 首字母大寫 + 移除多餘空白
    return pinyin.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
}
