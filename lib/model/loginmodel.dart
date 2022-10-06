class User {
  String? company_id;
  String email_id;
  String holiday_id;
  String name;
  String passwod;
  String? phone;

  User(
      { this.company_id,
      required this.email_id,
      required this.holiday_id,
      required this.name,
      required this.passwod,
      this.phone});

  Map<String, dynamic> toMap() {
    return {
      'company_id': company_id,
      'email_id': email_id,
      'holiday_id': holiday_id,
      'name': name,
      'passwod': passwod,
    };
  }

  @override
  String toString() {
    return 'user(company_id:$company_id,email_id:$email_id,holiday_id:$holiday_id,passwod:$passwod)';
  }
}
