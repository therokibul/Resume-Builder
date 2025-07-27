import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_builder/features/resume/presentation/bloc/resume_state.dart';

class PdfGenerator {
  static Future<Uint8List> generate(ResumeState resume) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            _buildHeader(resume.personalDetails),
            pw.SizedBox(height: 20),
            if (resume.personalDetails.summary.isNotEmpty)
              _buildSection('Summary',
                  pw.Text(resume.personalDetails.summary, textAlign: pw.TextAlign.justify)),
            if (resume.experience.isNotEmpty)
              _buildSection(
                  'Experience',
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: resume.experience
                        .map((exp) => _buildExperience(exp))
                        .toList(),
                  )),
            if (resume.education.isNotEmpty)
              _buildSection(
                  'Education',
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: resume.education
                        .map((edu) => _buildEducation(edu))
                        .toList(),
                  )),
            if (resume.skills.isNotEmpty)
              _buildSection(
                  'Skills',
                  pw.Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children:
                        resume.skills.map((skill) => pw.Text(skill)).toList(),
                  )),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(PersonalDetails details) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(details.name,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24)),
        pw.SizedBox(height: 5),
        pw.Text(details.email),
        pw.Text(details.phone),
        pw.Text(details.address),
      ],
    );
  }

  static pw.Widget _buildSection(String title, pw.Widget content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 10),
        pw.Text(title,
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
                decoration: pw.TextDecoration.underline)),
        pw.SizedBox(height: 10),
        content,
        pw.SizedBox(height: 10),
      ],
    );
  }

  static pw.Widget _buildExperience(Experience exp) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(exp.jobTitle,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text('${exp.startDate} - ${exp.endDate}'),
          ],
        ),
        pw.Text(exp.company,
            style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
        pw.SizedBox(height: 5),
        pw.Text(exp.description, textAlign: pw.TextAlign.justify),
        pw.SizedBox(height: 10),
      ],
    );
  }

  static pw.Widget _buildEducation(Education edu) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(edu.degree,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(edu.year),
          ],
        ),
        pw.Text(edu.institution),
        pw.SizedBox(height: 10),
      ],
    );
  }
}
