class Otp {
  Otp({
    required this.status,
    required this.response,
    required this.requestId,
  });
  late final bool status;
  late final String? response;
  late final String? requestId;

  Otp.fromJson(Map<String, dynamic> json){
    status = json['status'];
    response = json['response'] as String;
    requestId = json['request_id'] as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response'] = response;
    _data['request_id'] = requestId;
    return _data;
  }
}