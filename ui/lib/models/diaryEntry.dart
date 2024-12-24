class Diaryentry {
  final String title;
  final String entry;
  final String mood;
  final String date;
  List<dynamic> tags;

  Diaryentry({
    required this.title,
    required this.entry,
    required this.mood,
    required this.date,
    this.tags = const []
  });

  factory Diaryentry.fromJson(Map<String, dynamic> json){
    try{
      return Diaryentry(
        title: json['title'] as String, 
        entry: json['entry'] as String, 
        mood: json['mood'] as String, 
        date: json['date'] as String,
        tags: json['tags']  as List<dynamic>? ?? [], 
      );
    }catch (e){
      throw FormatException('failed to load entry: $e');
    }

  }


}

