import 'package:equatable/equatable.dart';

class ResumeState extends Equatable {
  final PersonalDetails personalDetails;
  final List<Experience> experience;
  final List<Education> education;
  final List<String> skills;

  const ResumeState({
    this.personalDetails = const PersonalDetails(),
    this.experience = const [],
    this.education = const [],
    this.skills = const [],
  });

  ResumeState copyWith({
    PersonalDetails? personalDetails,
    List<Experience>? experience,
    List<Education>? education,
    List<String>? skills,
  }) {
    return ResumeState(
      personalDetails: personalDetails ?? this.personalDetails,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      skills: skills ?? this.skills,
    );
  }

  @override
  List<Object> get props => [personalDetails, experience, education, skills];
}

class PersonalDetails extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String summary;

  const PersonalDetails({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.summary = '',
  });

  PersonalDetails copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? summary,
  }) {
    return PersonalDetails(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      summary: summary ?? this.summary,
    );
  }

  @override
  List<Object> get props => [name, email, phone, address, summary];
}

class Experience extends Equatable {
  final String jobTitle;
  final String company;
  final String startDate;
  final String endDate;
  final String description;

  const Experience({
    this.jobTitle = '',
    this.company = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
  });

  @override
  List<Object> get props => [
    jobTitle,
    company,
    startDate,
    endDate,
    description,
  ];
}

class Education extends Equatable {
  final String degree;
  final String institution;
  final String year;

  const Education({this.degree = '', this.institution = '', this.year = ''});

  @override
  List<Object> get props => [degree, institution, year];
}
