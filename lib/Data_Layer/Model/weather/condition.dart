class Condition {
  String? text; // Text description of the weather condition.
  String? icon; // Icon representing the weather condition.
  int? code; // Numeric code representing the weather condition.

  Condition({this.text, this.icon, this.code});

  // Factory constructor to create a Condition object from a JSON map.
  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json['text'] as String?,
        icon: json['icon'] as String?,
        code: json['code'] as int?,
      );

  // Convert the Condition object to a JSON map.
  Map<String, dynamic> toJson() => {
        'text': text,
        'icon': icon,
        'code': code,
      };
}
