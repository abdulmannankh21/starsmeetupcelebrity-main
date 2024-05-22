class PoliciesModel {
  String id;
  String title;
  String description;
  int timestamp;

  PoliciesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': title,
      'answer': description,
      'timestamp': timestamp,
    };
  }

  factory PoliciesModel.fromMap(String id, Map<String, dynamic> map) {
    return PoliciesModel(
      id: id,
      title: map['question'],
      description: map['answer'],
      timestamp: map['timestamp'],
    );
  }
}
