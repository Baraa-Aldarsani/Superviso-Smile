class SessionModel {
  final int id;
  final int evaluation;
  final String date;
  final String time;
  final String status;
  final String supervisorNote;
  final String studentNote;

  SessionModel({
    required this.id,
    required this.evaluation,
    required this.date,
    required this.time,
    required this.status,
    required this.supervisorNote,
    required this.studentNote,
  });
  factory SessionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SessionModel(
      id: json['id'],
      evaluation: (json['supervisor_evaluation'] != null)
          ? json['supervisor_evaluation']
          : 0,
      date: json['history'],
      time: json['timeSession'],
      status: json['status_of_session'],
      supervisorNote:
          (json['supervisor_notes'] != null) ? json['supervisor_notes'] : '',
      studentNote: (json['student_notes'] != null) ? json['student_notes'] : '',
    );
  }
}
