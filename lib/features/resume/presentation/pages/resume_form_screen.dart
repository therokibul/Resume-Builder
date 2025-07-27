import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_builder/features/resume/presentation/bloc/resume_bloc.dart';
import 'package:resume_builder/features/resume/presentation/bloc/resume_event.dart';
import 'package:resume_builder/features/resume/presentation/bloc/resume_state.dart';
import 'package:resume_builder/features/resume/presentation/pages/preview_screen.dart';
import 'package:resume_builder/features/resume/presentation/widgets/section_widget.dart';


class ResumeFormScreen extends StatefulWidget {
  const ResumeFormScreen({Key? key}) : super(key: key);

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _summaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final resumeState = context.read<ResumeBloc>().state;
    _nameController.text = resumeState.personalDetails.name;
    _emailController.text = resumeState.personalDetails.email;
    _phoneController.text = resumeState.personalDetails.phone;
    _addressController.text = resumeState.personalDetails.address;
    _summaryController.text = resumeState.personalDetails.summary;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  void _updatePersonalDetails() {
    context.read<ResumeBloc>().add(
          UpdatePersonalDetails(
            PersonalDetails(
              name: _nameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              address: _addressController.text,
              summary: _summaryController.text,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _updatePersonalDetails();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PreviewScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ResumeBloc, ResumeState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPersonalDetailsSection(),
                  const SizedBox(height: 24),
                  SectionWidget<Experience>(
                    title: 'Work Experience',
                    items: state.experience,
                    itemBuilder: (context, experience, index) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(experience.jobTitle),
                        subtitle: Text(experience.company),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<ResumeBloc>()
                                .add(RemoveExperience(index));
                          },
                        ),
                      ),
                    ),
                    onAdd: () => _addExperienceDialog(context),
                  ),
                  const SizedBox(height: 24),
                  SectionWidget<Education>(
                    title: 'Education',
                    items: state.education,
                    itemBuilder: (context, education, index) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(education.degree),
                        subtitle: Text(education.institution),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<ResumeBloc>()
                                .add(RemoveEducation(index));
                          },
                        ),
                      ),
                    ),
                    onAdd: () => _addEducationDialog(context),
                  ),
                  const SizedBox(height: 24),
                  _buildSkillsSection(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Personal Details',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
              onChanged: (_) => _updatePersonalDetails(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
              onChanged: (_) => _updatePersonalDetails(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
              onChanged: (_) => _updatePersonalDetails(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (_) => _updatePersonalDetails(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _summaryController,
              decoration: const InputDecoration(labelText: 'Summary'),
              maxLines: 4,
              onChanged: (_) => _updatePersonalDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(ResumeState state) {
    final skillController = TextEditingController();
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Skills', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: state.skills.asMap().entries.map((entry) {
                int idx = entry.key;
                String skill = entry.value;
                return Chip(
                  label: Text(skill),
                  onDeleted: () {
                    context.read<ResumeBloc>().add(RemoveSkill(idx));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: skillController,
                    decoration:
                        const InputDecoration(labelText: 'Add a skill'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (skillController.text.isNotEmpty) {
                      context
                          .read<ResumeBloc>()
                          .add(AddSkill(skillController.text));
                      skillController.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addExperienceDialog(BuildContext context) async {
    final jobTitleController = TextEditingController();
    final companyController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    final descriptionController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                    controller: jobTitleController,
                    decoration: const InputDecoration(labelText: 'Job Title')),
                TextField(
                    controller: companyController,
                    decoration: const InputDecoration(labelText: 'Company')),
                TextField(
                    controller: startDateController,
                    decoration: const InputDecoration(labelText: 'Start Date')),
                TextField(
                    controller: endDateController,
                    decoration: const InputDecoration(labelText: 'End Date')),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                context.read<ResumeBloc>().add(AddExperience(
                      Experience(
                        jobTitle: jobTitleController.text,
                        company: companyController.text,
                        startDate: startDateController.text,
                        endDate: endDateController.text,
                        description: descriptionController.text,
                      ),
                    ));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addEducationDialog(BuildContext context) async {
    final degreeController = TextEditingController();
    final institutionController = TextEditingController();
    final yearController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add Education'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                    controller: degreeController,
                    decoration: const InputDecoration(labelText: 'Degree')),
                TextField(
                    controller: institutionController,
                    decoration: const InputDecoration(labelText: 'Institution')),
                TextField(
                    controller: yearController,
                    decoration:
                        const InputDecoration(labelText: 'Year of Completion')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                context.read<ResumeBloc>().add(AddEducation(
                      Education(
                        degree: degreeController.text,
                        institution: institutionController.text,
                        year: yearController.text,
                      ),
                    ));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
