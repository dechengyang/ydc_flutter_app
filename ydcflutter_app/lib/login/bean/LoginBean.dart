class LoginBean{

  final String code;
  final String message;
  final String token;

  LoginBean(this.code, this.message,this.token);

  LoginBean.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message= json['message'],
        token= json['token'];

  Map<String, dynamic> toJson() =>
      {
        'code': code,
        'message': message,
        'token':token,
      };
}
