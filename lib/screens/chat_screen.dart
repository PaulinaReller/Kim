// Screens 1/2/3/4 Welcome
import 'package:flutter/material.dart';
import '../widgets/Kim_logo.dart';
import '../widgets/chat_window_1.dart';  
import '../widgets/beginner_footer.dart'; 
import 'login.dart'; 


// Text for all 4 pages 
final List<Map<String, String>> onboardingData = [
  {
    'header': 'Deine empathische Begleiterin KIM',
    'title': 'KIM',
    'body':
        'Ich erkundige mich nach deinem Befinden, erkläre dir wissenschaftliche Zusammenhänge leicht verständlich und gebe dir gezielte Empfehlungen. Ich bin da, um dich Schritt für Schritt auf deinem Weg für mehr Wohlbefinden zu unterstützen.',
  },
  {
    'header': 'Tracke deine Symptome und Behandlungen mit KIM und werde Teil eines lernenden Systems',
    'title': 'KIM',
    'body':
        'Mit deiner Zustimmung werte ich deine Daten anonymisiert aus. So wirst du Teil eines lernenden Systems, das dabei hilft, Endometriose besser zu verstehen, neue Therapieansätze zu entwickeln, und es dir ermöglicht, personalisierte Empfehlungen zu erhalten. ',
  },
  {
    'header': 'Erhalte personalisierte Empfehlungen aus der evidenzbasierten Komplementärmedizin',
    'title': 'KIM',
    'body':
        'Ich erkenne frühzeitig Muster in deinen Symptomen, schlage dir passende Maßnahmen vor und erkläre dir die wissenschaftliche Grundlage - klar und verständlich. ',
  },
  {
    'header': 'Wende komplementärmedizinische Therapien direkt an ',
    'title': 'KIM',
    'body':
        'Von Ernährung bis zu VR-gestützten Mentalübungen: Greife auf ein breites Spektrum individueller abgestimmter, evidenzbasierter Therapien zu. Optional kannst du auch geprüfte Produkte entdecken oder direkt Termine bei Spezialist:innen buchen. ',
  },
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardingData.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        final data = onboardingData[index];
                        
                        return _OnboardingPageContent(
                          header: data['header']!,
                          title: data['title']!,
                          body: data['body']!,
                          onClose: () => Navigator.of(context).pop(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  BeginnerFooter(
                    pageCount: onboardingData.length,
                    activeIndex: _currentPage, 
                    onBack: () {
                     
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    onForward: () {
                      if (_currentPage == onboardingData.length - 1) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _OnboardingPageContent extends StatelessWidget {
  const _OnboardingPageContent({
    required this.header,
    required this.title,
    required this.body,
    required this.onClose,
  });

  final String header;
  final String title;
  final String body;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          header,
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color: Colors.black),
        ),
        const SizedBox(height: 30),
        const PulsingLogo(),
        const SizedBox(height: 24),
        ChatWindow(
          title: title,
          body: body,
          onClose: onClose,
        ),
      ],
    );
  }
}