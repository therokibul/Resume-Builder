import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_builder/features/resume/presentation/bloc/resume_event.dart';
import 'package:resume_builder/features/resume/presentation/bloc/resume_state.dart';


class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  ResumeBloc() : super(const ResumeState()) {
    on<UpdatePersonalDetails>(_onUpdatePersonalDetails);
    on<AddExperience>(_onAddExperience);
    on<AddEducation>(_onAddEducation);
    on<AddSkill>(_onAddSkill);
    on<RemoveExperience>(_onRemoveExperience);
    on<RemoveEducation>(_onRemoveEducation);
    on<RemoveSkill>(_onRemoveSkill);
  }

  void _onUpdatePersonalDetails(
      UpdatePersonalDetails event, Emitter<ResumeState> emit) {
    emit(state.copyWith(personalDetails: event.personalDetails));
  }

  void _onAddExperience(AddExperience event, Emitter<ResumeState> emit) {
    final updatedExperience = List<Experience>.from(state.experience)
      ..add(event.experience);
    emit(state.copyWith(experience: updatedExperience));
  }

  void _onAddEducation(AddEducation event, Emitter<ResumeState> emit) {
    final updatedEducation = List<Education>.from(state.education)
      ..add(event.education);
    emit(state.copyWith(education: updatedEducation));
  }

  void _onAddSkill(AddSkill event, Emitter<ResumeState> emit) {
    final updatedSkills = List<String>.from(state.skills)..add(event.skill);
    emit(state.copyWith(skills: updatedSkills));
  }

  void _onRemoveExperience(RemoveExperience event, Emitter<ResumeState> emit) {
    final updatedExperience = List<Experience>.from(state.experience)
      ..removeAt(event.index);
    emit(state.copyWith(experience: updatedExperience));
  }

  void _onRemoveEducation(RemoveEducation event, Emitter<ResumeState> emit) {
    final updatedEducation = List<Education>.from(state.education)
      ..removeAt(event.index);
    emit(state.copyWith(education: updatedEducation));
  }

  void _onRemoveSkill(RemoveSkill event, Emitter<ResumeState> emit) {
    final updatedSkills = List<String>.from(state.skills)
      ..removeAt(event.index);
    emit(state.copyWith(skills: updatedSkills));
  }
}
