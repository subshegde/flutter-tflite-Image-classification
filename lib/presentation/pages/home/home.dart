import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite_examples/common/constants/paths.dart';
import 'package:flutter_tflite_examples/presentation/pages/image_classification/mango_leaf_disease_detection/tFLite_classifier_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4CAF50),
                Color(0xFF81C784),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          child: const Icon(Icons.eco_outlined,
                              size: 40, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: FadeInDown(
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              'Mango Leaf Disease Detector',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: Text(
                          'Empowering Farmers with AI-Driven Disease Detection',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: _buildImageSlider(),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      runSpacing: 12,
                      spacing: 12,
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          child: _buildInfoCard(
                            title: 'Accurate Detection',
                            description:
                                'Use AI to identify mango leaf diseases like Gall Midge and Sooty Mould with high accuracy.',
                            icon: Icons.check_circle,
                            maxWidth: constraints.maxWidth,
                          ),
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          child: _buildInfoCard(
                            title: 'Expert Tips',
                            description:
                                'Get tailored advice and resources to manage and prevent mango tree diseases.',
                            icon: Icons.lightbulb,
                            maxWidth: constraints.maxWidth,
                          ),
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 700),
                          child: _buildInfoCard(
                            title: 'Contact Support',
                            description:
                                'Reach out to our team for assistance or feedback.',
                            icon: Icons.contact_support,
                            maxWidth: constraints.maxWidth,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    final List<String> imagePaths = List.generate(
      8,
      (index) => '${AssetPaths.slider}${index + 1}.jpg',
    );

    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: imagePaths.map((path) {
        return Builder(
          builder: (context) => ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              path,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.red),
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String description,
    required IconData icon,
    required double maxWidth,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 30, color: Colors.green[700]),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
