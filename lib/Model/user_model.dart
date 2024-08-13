class User {
  final int id;
  final String name;
  final String? email;
  final String? mobile;
  final String? mobileVerifiedAt;
  final String? emailVerifiedAt;
  final String? otp;
  final String status;
  final String role;
  final String serviceProviderType;
  final int? trailPeriodTime;
  final String createdAt;
  final String updatedAt;
  final String createdAtHuman;
  final String? avatar;
  final String? cover;
  final bool freeServiceAvailable;
  final dynamic trailPeriodEndTime;  // Change to dynamic
  final String? providerAssessDate;
  final List<String> mobiles;
  final Map<String, dynamic> metaData;

  User({
    required this.id,
    required this.name,
    this.email,
    this.mobile,
    this.mobileVerifiedAt,
    this.emailVerifiedAt,
    this.otp,
    required this.status,
    required this.role,
    required this.serviceProviderType,
    required this.trailPeriodTime,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtHuman,
    required this.avatar,
    this.cover,
    required this.freeServiceAvailable,
    this.trailPeriodEndTime,
    this.providerAssessDate,
    required this.mobiles,
    required this.metaData,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile']?.toString(),
      mobileVerifiedAt: json['mobile_verified_at'],
      emailVerifiedAt: json['email_verified_at'],
      otp: json['otp']?.toString(),
      status: json['status'],
      role: json['role'],
      serviceProviderType: json['service_provider_type'],
      trailPeriodTime: json['trail_period_time'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtHuman: json['created_at_human'],
      avatar: json['avatar'],
      cover: json['cover'],
      freeServiceAvailable: json['free_service_available'] ?? false,
      trailPeriodEndTime: json['trail_period_end_time'],
      providerAssessDate: json['provider_asses_date'],
      mobiles: List<String>.from(json['mobiles'] ?? []),
      metaData: json['meta_data'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'mobile_verified_at': mobileVerifiedAt,
      'email_verified_at': emailVerifiedAt,
      'otp': otp,
      'status': status,
      'role': role,
      'service_provider_type': serviceProviderType,
      'trail_period_time': trailPeriodTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_human': createdAtHuman,
      'avatar': avatar,
      'cover': cover,
      'free_service_available': freeServiceAvailable,
      'trail_period_end_time': trailPeriodEndTime,
      'provider_asses_date': providerAssessDate,
      'mobiles': mobiles,
      'meta_data': metaData,
    };
  }
}