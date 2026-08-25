import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jane Doe CV',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CvScreen(),
      },
    );
  }
}

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curriculum Vitae'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildDesktopLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeader(context, isMobile: true),
        const SizedBox(height: 24),
        _buildSectionTitle('About Me', context),
        _buildAbout(),
        const SizedBox(height: 24),
        _buildSectionTitle('Experience', context),
        _buildExperience(),
        const SizedBox(height: 24),
        _buildSectionTitle('Education', context),
        _buildEducation(),
        const SizedBox(height: 24),
        _buildSectionTitle('Skills', context),
        _buildSkills(),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, isMobile: false),
                    const SizedBox(height: 32),
                    _buildSectionTitle('About Me', context),
                    _buildAbout(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Skills', context),
                    _buildSkills(),
                  ],
                ),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Experience', context),
                    _buildExperience(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Education', context),
                    _buildEducation(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: isMobile ? 60 : 80,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(Icons.person, size: isMobile ? 80 : 100, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 16),
        Text(
          'Jane Doe',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          'Senior Flutter Developer',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[700]),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: () => _launchUrl('mailto:jane.doe@example.com'),
              tooltip: 'Email',
            ),
            IconButton(
              icon: const Icon(Icons.link),
              onPressed: () => _launchUrl('https://linkedin.com'),
              tooltip: 'LinkedIn',
            ),
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: () => _launchUrl('https://github.com'),
              tooltip: 'GitHub',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Divider(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildAbout() {
    return const Text(
      'Passionate Software Engineer with 8+ years of experience in mobile and web development. '
      'Specialized in Flutter, creating high-performance, cross-platform applications. '
      'Strong advocate for clean code, automated testing, and agile methodologies.',
      style: TextStyle(fontSize: 16, height: 1.5),
    );
  }

  Widget _buildExperience() {
    return Column(
      children: [
        _buildExperienceItem(
          company: 'TechCorp Solutions',
          role: 'Lead Mobile Engineer',
          period: 'Jan 2021 - Present',
          description: 'Led a team of 5 developers to migrate legacy native apps to a unified Flutter codebase, reducing time-to-market by 40%. Implemented CI/CD pipelines and established testing standards.',
        ),
        const SizedBox(height: 16),
        _buildExperienceItem(
          company: 'Startup Inc.',
          role: 'Senior Software Developer',
          period: 'Mar 2018 - Dec 2020',
          description: 'Developed and launched 3 successful Flutter applications from scratch. Handled state management with Riverpod and integrated complex RESTful APIs.',
        ),
        const SizedBox(height: 16),
        _buildExperienceItem(
          company: 'WebDev Agency',
          role: 'Frontend Developer',
          period: 'Jun 2015 - Feb 2018',
          description: 'Built responsive web applications using React and Angular. Collaborated closely with designers to implement pixel-perfect UIs.',
        ),
      ],
    );
  }

  Widget _buildExperienceItem({
    required String company,
    required String role,
    required String period,
    required String description,
  }) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    role,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  period,
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              company,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducation() {
    return Column(
      children: [
        _buildEducationItem(
          degree: 'Master of Science in Computer Science',
          school: 'Tech University',
          year: '2015',
        ),
        const SizedBox(height: 12),
        _buildEducationItem(
          degree: 'Bachelor of Science in Software Engineering',
          school: 'State College',
          year: '2013',
        ),
      ],
    );
  }

  Widget _buildEducationItem({
    required String degree,
    required String school,
    required String year,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.school, color: Colors.teal),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(degree, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(school, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Text(year, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildSkills() {
    final skills = [
      'Flutter & Dart',
      'Firebase',
      'REST APIs',
      'Git & CI/CD',
      'Agile/Scrum',
      'Riverpod/Bloc',
      'UI/UX Design',
      'SQL & NoSQL',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((skill) {
        return Chip(
          label: Text(skill),
          backgroundColor: Colors.teal.withOpacity(0.1),
          side: BorderSide.none,
        );
      }).toList(),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
