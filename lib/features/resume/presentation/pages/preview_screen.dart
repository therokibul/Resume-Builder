import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:printing/printing.dart';
import 'package:resume_builder/features/resume/lib/pdf_generator.dart';
import 'package:resume_builder/features/resume/presentation/bloc/resume_bloc.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resumeState = context.watch<ResumeBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: () async {
              final pdfBytes = await PdfGenerator.generate(resumeState);
              await Printing.sharePdf(bytes: pdfBytes, filename: 'resume.pdf');
            },
          )
        ],
      ),
      body: PdfPreview(
        build: (format) => PdfGenerator.generate(resumeState),
      ),
    );
  }
}
