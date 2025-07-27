import 'package:equatable/equatable.dart';

import 'package:resume_builder/features/resume/presentation/bloc/resume_state.dart';

abstract class ResumeEvent extends Equatable {
  const ResumeEvent();

  @override
  List<Object> get props => [];
}

class UpdatePersonalDetails extends ResumeEvent {
  final PersonalDetails personalDetails;

  const UpdatePersonalDetails(this.personalDetails);

  @override
  List<Object> get props => [personalDetails];
}

class AddExperience extends ResumeEvent {
  final Experience experience;

  const AddExperience(this.experience);

  @override
  List<Object> get props => [experience];
}

class AddEducation extends ResumeEvent {
  final Education education;

  const AddEducation(this.education);

  @override
  List<Object> get props => [education];
}

class AddSkill extends ResumeEvent {
  final String skill;

  const AddSkill(this.skill);

  @override
  List<Object> get props => [skill];
}

class RemoveExperience extends ResumeEvent {
  final int index;

  const RemoveExperience(this.index);

  @override
  List<Object> get props => [index];
}

class RemoveEducation extends ResumeEvent {
  final int index;

  const RemoveEducation(this.index);

  @override
  List<Object> get props => [index];
}

class RemoveSkill extends ResumeEvent {
  final int index;

  const RemoveSkill(this.index);

  @override
  List<Object> get props => [index];
}
