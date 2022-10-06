class CompanyModel {
  String company_name;
  String email;
  String? password;
  int? phone_no;

  CompanyModel({
    required this.company_name,
    required this.email,
    this.password,
    this.phone_no,
  });
  
  factory CompanyModel.fromMap(Map<String, dynamic> json) => CompanyModel(
        company_name: json["company_name"],
        email: json["email"],
        password: json["password"],
        phone_no: json["phone_no"],
      );

  Map<String, dynamic> toMap() {
    return {
      'company_name': company_name,
      'email': email,
      'password': password,
      'phone_no': phone_no,
    };
  }
}

class UserModel {
  String company_id;
  String email_id;
  String? password; 
  int? phone_no;
  List<dynamic> ? holiday_id;

  UserModel(
      {required this.company_id,
      required this.email_id,
      this.password,
      this.phone_no,
      this.holiday_id});
  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      company_id: json["comapny_id"],
      email_id: json["email_id"],
      password: json["passwod"],
      phone_no: json["phone_no"],
      holiday_id: json["holiday_id"]);

  Map<String, dynamic> toMap() {
    return {
      'comapny_name': company_id,
      'email': email_id,
      'passwod': password,
      'phone_no': phone_no,
      'holiday_id': holiday_id,
    };
  }
}
