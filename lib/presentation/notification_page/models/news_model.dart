class LeaveData {
  int id;
  int userId;
  String type;
  String content;
  DateTime created_at;
 


  LeaveData({
    required this.id,
    required this.userId,
    required this.type,
    required this.created_at,
    required this.content,
    
  });

  // Factory method to create a LeaveData instance from JSON
  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      created_at: DateTime.parse(json['created_at']),
      
      content: json['content'],
      
    );
  }
}
