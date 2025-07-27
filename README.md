# Flutter Resume Builder

A mobile application built with Flutter to help users create, manage, and export professional, ATS-friendly resumes in PDF format. The app features a clean, responsive user interface based on Material Design 3.

## Features

- **Personal Details:** Add and edit your name, contact information, and a professional summary.
- **Work Experience:** List your previous job roles, companies, durations, and descriptions.
- **Education:** Detail your academic qualifications, institutions, and graduation years.
- **Skills:** Showcase your technical and soft skills.
- **Responsive UI:** The interface is designed to work seamlessly across different screen sizes.
- **ATS-Friendly PDF Export:** Generate a clean, single-column PDF of your resume, optimized for Applicant Tracking Systems.
- **Live Preview:** Instantly preview how your resume will look before exporting.
- **State Management:** Utilizes the BLoC pattern for predictable and scalable state management.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have the Flutter SDK installed on your machine. For instructions on how to install Flutter, see the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/flutter_resume_builder.git](https://github.com/your-username/flutter_resume_builder.git)
    cd flutter_resume_builder
    ```

2.  **Install dependencies:**
    Run the following command to fetch all the required packages.
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    Connect a device or start an emulator, then run the app.
    ```bash
    flutter run
    ```

## Project Structure

The project follows a feature-first directory structure to keep the code organized and scalable.


flutter_resume_builder/
├── lib/
│   ├── features/
│   │   └── resume/
│   │       ├── lib/
│   │       │   └── pdf_generator.dart   # Logic for creating the PDF
│   │       └── presentation/
│   │           ├── bloc/                # BLoC files (bloc, event, state)
│   │           ├── pages/               # UI Screens (form, preview)
│   │           └── widgets/             # Reusable UI components
│   ├── main.dart                        # App entry point
├── pubspec.yaml                         # Project dependencies and assets
└── README.md                            # This file


## Key Dependencies

- **[flutter_bloc](https://pub.dev/packages/flutter_bloc):** For predictable state management.
- **[pdf](https://pub.dev/packages/pdf):** For creating the PDF document.
- **[printing](https://pub.dev/packages/printing):** For previewing and sharing the generated PDF.
- **[path_provider](https://pub.dev/packages/path_provider):** To find the correct local path to store files.
- **[open_file](https://pub.dev/packages/open_file):** To open the generated PDF file.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

