class PollModel {
  final String id;
  String titleEn;
  String titleUr;
  String subTitleEn;
  String subTitleUr;
  int duration;
  final List options;
  final DateTime? endTime;

  PollModel({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.subTitleEn,
    required this.subTitleUr,
    required this.duration,
    required this.options,
    this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title_en': titleEn,
      'title_ur': titleUr,
      'sub_title_en': subTitleEn,
      'sub_title_ur': subTitleUr,
      'duration': duration,
      'options': options,
    };
  }

  factory PollModel.fromMap(Map<String, dynamic> map) {
    return PollModel(
        id: map['_id'],
        titleEn: map['title_en'],
        titleUr: map['title_ur'],
        subTitleEn: map['sub_title_en'],
        subTitleUr: map['sub_title_ur'],
        duration: 0,
        options: map['options'],
        endTime: DateTime.fromMillisecondsSinceEpoch(
                int.parse(map['duration'].toString()),
                isUtc: true)
            .toLocal());
  }
}
