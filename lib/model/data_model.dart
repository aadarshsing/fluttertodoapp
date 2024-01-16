class NoteData {
  final int? id;
  final String dateTime;
  final String title;
  final String description;

  const NoteData({required this.dateTime, required this.title,required this.description,this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime,
      'title': title,
      'description':description};
  }

  @override
  String toString() {
    return 'NoteData{id: $id, dateTime:$dateTime, title:$title, description:$description}';
  }
}
