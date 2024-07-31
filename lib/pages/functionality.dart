import 'package:flutter/material.dart';
import '../assessment/UI/assessment_status_page.dart';

import '../ContactExpert.dart';
import '../assessment/UI/expert_system.dart';

class Functionality extends StatefulWidget {
  const Functionality({super.key});

  @override
  State<Functionality> createState() => _functionalityState();
}

// ignore: camel_case_types
class _functionalityState extends State<Functionality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GridItem(
              title: 'Self Assessment',
              icon: Icons.assessment,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExpertSystemApp()),
                );
              },
            ),
            GridItem(
              title: 'Contact Experts',
              icon: Icons.contact_phone,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ContactExpertPage()),
                );
              },
            ),
            GridItem(
              title: 'View Status',
              icon: Icons.visibility,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AssessmentStatusPage()),
                );
              },
            ),
            GridItem(
              title: 'Get Suggestions',
              icon: Icons.lightbulb,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  GetSuggestionsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const GridItem({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}




class Specialist {
  final String name;
  final String title;
  final String description;
  final String imagePath;

  Specialist({
    required this.name,
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class SpecialistDetailPage extends StatelessWidget {
  final Specialist specialist;

  const SpecialistDetailPage({super.key, required this.specialist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(specialist.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(specialist.imagePath),
            ),
            const SizedBox(height: 16),
            Text(
              specialist.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              specialist.title,
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              specialist.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}



class GetSuggestionsPage extends StatelessWidget {
  GetSuggestionsPage({Key? key}) : super(key: key);

  final List<Disease> mentalHealthDiseases = [
    Disease(name: 'Depression', levels: ['Severe', 'Moderate', 'Mild']),
    Disease(name: 'Anxiety Disorders', levels: ['Severe', 'Moderate', 'Mild']),
    Disease(name: 'Bipolar Disorder', levels: ['Severe', 'Moderate', 'Mild']),
    Disease(name: 'Schizophrenia', levels: ['Severe', 'Moderate', 'Mild']),
    // Add more mental health diseases as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Suggestions'),
      ),
      body: ListView.builder(
        itemCount: mentalHealthDiseases.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                mentalHealthDiseases[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiseaseDetailPage(disease: mentalHealthDiseases[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


class Disease {
  final String name;
  final List<String> levels;

  Disease({required this.name, required this.levels});
}

class DiseaseDetailPage extends StatelessWidget {
  final Disease disease;

  DiseaseDetailPage({required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disease.name),
      ),
      body: ListView.builder(
        itemCount: disease.levels.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                '${disease.levels[index]} Level',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuggestionPage(disease: disease, level: disease.levels[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SuggestionPage extends StatelessWidget {
  final Disease disease;
  final String level;

  SuggestionPage({required this.disease, required this.level});

  final Map<String, Map<String, String>> suggestions = {
    'Depression': {
      'Severe': 'Severe-level suggestion for Depression: Seek immediate professional help. Consider hospitalization if necessary for intensive treatment and stabilization. Focus on safety, including removing access to means of self-harm. Participate in structured therapy programs such as Cognitive Behavioral Therapy (CBT) or Dialectical Behavior Therapy (DBT), and consider medication options under the guidance of a psychiatrist. Build a strong support network and involve family and friends in the treatment process. Prioritize self-care activities, including regular sleep, balanced nutrition, and physical activity. Practice mindfulness and relaxation techniques. Stay connected with mental health professionals for ongoing support and monitoring of symptoms.',
      'Moderate': 'Moderate-level suggestion for Depression: Seek professional help from a therapist or psychiatrist. Engage in therapy sessions, such as CBT or interpersonal therapy, to address underlying issues and develop coping strategies. Consider medication options, including antidepressants, if recommended by a healthcare provider. Establish a daily routine and set achievable goals to maintain structure and motivation. Stay connected with supportive friends and family members. Practice self-care activities such as regular exercise, healthy eating, and adequate sleep. Incorporate relaxation techniques like deep breathing or meditation into your daily routine. Monitor your mood and seek help if symptoms worsen or become overwhelming.',
      'Mild': 'Mild-level suggestion for Depression: Practice self-care activities to promote emotional well-being, including regular physical activity, healthy eating, and adequate sleep. Engage in enjoyable activities and hobbies to boost mood and reduce stress. Connect with supportive friends and family members for social support. Consider participating in support groups or peer counseling sessions to share experiences and coping strategies. Monitor your mood and seek professional help if symptoms persist or interfere with daily functioning. Explore therapy options such as counseling or cognitive-behavioral techniques to address negative thought patterns and develop effective coping skills. Remember that seeking help is a sign of strength, and you deserve support and assistance in managing your mental health.',
    },
    'Anxiety Disorders': {
      'Severe': 'Severe-level suggestion for Anxiety Disorders: Seek immediate professional help from a psychiatrist or therapist. Consider hospitalization if symptoms are overwhelming or pose a risk to your safety. Participate in intensive therapy programs such as Cognitive Behavioral Therapy (CBT) or exposure therapy to address underlying fears and triggers. Explore medication options such as anti-anxiety medications or antidepressants under the guidance of a healthcare provider. Practice relaxation techniques such as deep breathing, progressive muscle relaxation, or mindfulness meditation to manage acute symptoms. Establish a strong support network and involve loved ones in your treatment journey. Prioritize self-care activities including adequate sleep, regular exercise, and healthy nutrition. Create a safety plan for managing anxiety attacks or crises, and seek help immediately if symptoms worsen or become unmanageable.',
      'Moderate': 'Moderate-level suggestion for Anxiety Disorders: Seek professional help from a therapist or counselor specializing in anxiety management. Engage in therapy sessions focused on developing coping strategies and challenging irrational thoughts or beliefs. Consider medication options such as selective serotonin reuptake inhibitors (SSRIs) or benzodiazepines if recommended by a healthcare provider. Practice relaxation techniques such as deep breathing exercises, progressive muscle relaxation, or guided imagery to reduce anxiety symptoms. Establish a routine that includes regular exercise, balanced nutrition, and adequate sleep to support overall well-being. Stay connected with supportive friends and family members for emotional support and encouragement. Explore self-help resources such as books, online forums, or support groups for additional coping strategies and reassurance. Monitor your symptoms and seek help if anxiety interferes with daily functioning or quality of life.',
      'Mild': "Mild-level suggestion for Anxiety Disorders: Practice self-help techniques to manage mild anxiety symptoms. Utilize relaxation techniques such as deep breathing exercises, mindfulness meditation, or yoga to promote relaxation and stress reduction. Establish a daily routine that includes regular exercise, healthy meals, and adequate sleep to support overall well-being. Challenge negative thoughts or beliefs through cognitive-behavioral techniques such as thought restructuring or reframing. Engage in enjoyable activities and hobbies to distract from anxious thoughts and promote positive emotions. Connect with supportive friends and family members for social support and encouragement. Consider seeking therapy or counseling if symptoms persist or interfere with daily functioning. Explore self-help resources such as books, online articles, or mobile apps for additional coping strategies and support. Remember that it's okay to ask for help and that treatment options are available to support your mental health.",
    },
    'Bipolar Disorder': {
      'Severe': 'Severe-level suggestion for Bipolar Disorder: Seek immediate professional help from a psychiatrist or mental health specialist. Hospitalization may be necessary if there is a risk of harm to oneself or others. Participate in intensive treatment programs, including medication management with mood stabilizers, antipsychotics, or antidepressants as prescribed by a healthcare provider. Engage in regular therapy sessions, such as Cognitive Behavioral Therapy (CBT) or Dialectical Behavior Therapy (DBT), to develop coping strategies and manage symptoms. Establish a structured daily routine with regular sleep, exercise, and healthy eating habits. Create a crisis plan with your healthcare provider to manage manic or depressive episodes. Involve family and close friends in your treatment plan for support and monitoring. Avoid alcohol, drugs, and other substances that can trigger mood swings. Monitor mood changes and communicate regularly with your healthcare provider to adjust treatment as needed.',
      'Moderate': 'Moderate-level suggestion for Bipolar Disorder: Seek ongoing treatment from a psychiatrist or therapist specializing in mood disorders. Adhere to a medication regimen as prescribed, including mood stabilizers or other medications. Engage in regular therapy sessions to identify triggers, manage stress, and develop healthy coping mechanisms. Maintain a consistent daily routine with regular sleep, physical activity, and balanced nutrition. Use mood tracking tools to monitor changes and identify patterns. Practice stress-reduction techniques such as mindfulness, meditation, or yoga to manage symptoms. Build a strong support network of friends, family, or support groups to provide emotional support and encouragement. Avoid substances that can exacerbate mood swings, such as alcohol and recreational drugs. Communicate openly with your healthcare provider about any changes in symptoms or concerns with treatment.',
      'Mild': 'Mild-level suggestion for Bipolar Disorder: Continue with regular appointments with a healthcare provider to monitor mood and adjust treatment as necessary. Adhere to a prescribed medication regimen to maintain mood stability. Participate in regular therapy sessions to reinforce coping strategies and maintain mental health. Establish a healthy daily routine, including regular sleep patterns, physical exercise, and balanced nutrition. Practice mindfulness, meditation, or other relaxation techniques to manage stress and prevent mood fluctuations. Engage in enjoyable activities and hobbies to promote positive emotions and mental well-being. Build and maintain a strong support system of friends, family, or peer support groups. Monitor mood and symptoms regularly to detect early signs of mood changes and seek prompt intervention if needed. Stay informed about Bipolar Disorder and treatment options through educational resources and support networks.'
    },
    'Schizophrenia': {
      'Severe': 'Severe-level suggestion for Schizophrenia: Seek immediate professional help from a psychiatrist or mental health specialist. Hospitalization may be necessary if there is a risk of harm to oneself or others. Engage in an intensive treatment plan that includes antipsychotic medications to manage symptoms. Participate in regular therapy sessions, such as Cognitive Behavioral Therapy (CBT), to develop coping strategies and manage symptoms. Establish a structured daily routine with regular sleep, exercise, and healthy eating habits. Create a crisis plan with your healthcare provider to manage acute episodes. Involve family and close friends in your treatment plan for support and monitoring. Avoid alcohol, drugs, and other substances that can exacerbate symptoms. Monitor symptoms and communicate regularly with your healthcare provider to adjust treatment as needed.',
      'Moderate': 'Moderate-level suggestion for Schizophrenia: Continue treatment with a psychiatrist or therapist specializing in schizophrenia. Adhere to a prescribed medication regimen, including antipsychotic medications. Engage in regular therapy sessions to identify triggers, manage stress, and develop healthy coping mechanisms. Maintain a consistent daily routine with regular sleep, physical activity, and balanced nutrition. Practice stress-reduction techniques such as mindfulness, meditation, or yoga to manage symptoms. Build a strong support network of friends, family, or support groups to provide emotional support and encouragement. Avoid substances that can worsen symptoms, such as alcohol and recreational drugs. Communicate openly with your healthcare provider about any changes in symptoms or concerns with treatment.',
      'Mild': 'Mild-level suggestion for Schizophrenia: Continue with regular appointments with a healthcare provider to monitor symptoms and adjust treatment as necessary. Adhere to a prescribed medication regimen to manage symptoms effectively. Participate in regular therapy sessions to reinforce coping strategies and maintain mental health. Establish a healthy daily routine, including regular sleep patterns, physical exercise, and balanced nutrition. Practice mindfulness, meditation, or other relaxation techniques to manage stress and prevent symptom exacerbation. Engage in enjoyable activities and hobbies to promote positive emotions and mental well-being. Build and maintain a strong support system of friends, family, or peer support groups. Monitor symptoms regularly to detect early signs of changes and seek prompt intervention if needed. Stay informed about schizophrenia and treatment options through educational resources and support networks.'
    },
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$level Level Suggestion for ${disease.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              suggestions[disease.name]?[level] ?? 'No suggestion available',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}