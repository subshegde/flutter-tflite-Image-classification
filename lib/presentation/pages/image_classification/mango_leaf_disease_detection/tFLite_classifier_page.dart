import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite_examples/common/constants/paths.dart';
import 'package:flutter_tflite_examples/common/helpers/bar_chart.dart';
import 'package:flutter_tflite_examples/common/helpers/disease_resources.dart';
import 'package:flutter_tflite_examples/common/helpers/typing_text_helper.dart';
import 'package:flutter_tflite_examples/domain/image_classification/mango_leaf_disease_detection/classifier_service.dart';
import 'package:flutter_tflite_examples/models/image_classification/mango_leaf_disease_detection/classification_result.dart';
import 'package:flutter_tflite_examples/presentation/widgets/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TFLiteClassifierPage extends StatefulWidget {
  const TFLiteClassifierPage({super.key});

  @override
  State<TFLiteClassifierPage> createState() => _TFLiteClassifierPageState();
}

class _TFLiteClassifierPageState extends State<TFLiteClassifierPage> {
  final ClassifierService _classifier = ClassifierService();
  File? _image;
  ClassificationResult? _result;
  final TypingTextHelper _typingHelper = TypingTextHelper();
  String? _fullText;

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _classifier.loadModel().then((_) => setState(() {}));
  }

  Future<void> _pickImageAndClassify() async {
    if (!_classifier.isModelLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Model is still loading, please wait...')),
      );
      return;
    }

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Capture with Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: source);
    if (imageFile == null) return;

    final image = File(imageFile.path);
    setState(() {
      _image = image;
      _result = null;
      _typingHelper.textNotifier.value = '';
      _fullText = null;
      _isProcessing = true;
    });

    final result = await _classifier.classifyImage(image);

    if (result != null) {
      if (result.confidence < 75.0) {
        setState(() {
          _result = ClassificationResult(
            label: "Not a mango leaf",
            confidence: 0.0,
            topResults: {
              "Healthy": 0.0,
              "Gall Midge": 0.0,
              "Sooty Mould": 0.0,
            },
          );
          _typingHelper.textNotifier.value =
              "The selected image doesn't appear to be a mango leaf.";
          _fullText = _typingHelper.textNotifier.value;
          _isProcessing = false;
        });
      } else {
        setState(() {
          _result = result;
          _isProcessing = false;
        });
        loadTextForLabel(result.label);
      }
    } else {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> loadTextForLabel(String label) async {
    final normalized = label.toLowerCase().trim();
    String path;

    switch (normalized) {
      case 'healthy':
        path = AssetPaths.healthyText;
        break;
      case 'gall midge':
        path = AssetPaths.gallMidgesText;
        break;
      case 'sooty mould':
        path = AssetPaths.scootyMouldText;
        break;
      default:
        _typingHelper.textNotifier.value = 'No information found for "$label".';
        _fullText = _typingHelper.textNotifier.value;
        return;
    }

    try {
      final text = await rootBundle.loadString(path);
      _fullText = text;
      _typingHelper.startTyping(text);
    } catch (e) {
      _typingHelper.textNotifier.value =
          'Error loading information for "$label". File might be missing.';
      _fullText = _typingHelper.textNotifier.value;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  void dispose() {
    _typingHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: const CustomAppBar(title: 'Mango Leaf Disease Classifier'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed:
                      _classifier.isModelLoaded ? _pickImageAndClassify : null,
                  icon: const Icon(Icons.photo_library_outlined, size: 18),
                  label: Text(
                    _classifier.isModelLoaded ? 'Pick Image' : 'Loading...',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 1,
                    minimumSize: const Size(120, 40),
                    visualDensity: VisualDensity.compact,
                    shadowColor: Colors.black12,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_image != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                getHeader(_result?.label ?? ''),
                const SizedBox(height: 10),
                getImages(_result?.label ?? ''),
              ],
              if (_isProcessing)
                const Center(
                      child: SizedBox(
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.black),
                            SizedBox(height: 16),
                            Text(
                              'Recognizing leaf disease...',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 24),
              if (_result != null)
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _result!.label,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Confidence: ${_result!.confidence.toStringAsFixed(2)}%",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: ConfidenceBarChart(
                            key: ValueKey(_result!.topResults),
                            topResults: _result!.topResults,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder<String>(
                          valueListenable: _typingHelper.textNotifier,
                          builder: (context, value, _) => AnimatedOpacity(
                            opacity: value.isNotEmpty ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 20),
                                if (_fullText != null &&
                                    value == _fullText) ...[
                                  Text(
                                    'Learn More',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildVideoSection(
                                    'Related Videos',
                                    getDiseaseLinks(_result!.label)['YouTube']!,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildLinksSection(
                                    'Related Articles',
                                    getDiseaseLinks(_result!.label)['Articles']!,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeader(String label){
    String header = '';
    final normalized = label.toLowerCase().trim();

    if(normalized == 'gall midge'){
      header = 'Gall midge causes blister-like swellings on mango leaves, leading to tissue damage';
    }else if(normalized == 'healthy'){
      header = 'A healthy mango leaf is vibrant green, smooth, and free from spots or deformities.';
    }else if(normalized == 'sooty mould'){
      header = 'Sooty mould appears as a black, powdery coating on mango leaves, blocking sunlight and affecting photosynthesis.';
    }else{
      header = '';
    }

    return Text(header,style: GoogleFonts.poppins(color: Colors.black),);
  }

  Widget getImages(String label) {
    String basePath = '';

    final normalized = label.toLowerCase().trim();

    if (normalized == 'gall midge') {
      basePath = 'assets/images/gall_midge/g';
    } else if (normalized == 'healthy') {
      basePath = 'assets/images/healthy/healthy';
    } else if (normalized == 'sooty mould') {
      basePath = 'assets/images/sooty_mould/s';
    } else {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Related Images',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final imagePath = '$basePath${index + 1}.jpg';
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, color: Colors.red),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection(String title, List<Map<String, String>> videos) {
    if (videos.isEmpty) {
      return Text(
        'No videos available.',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final video = videos[index];
              return Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerScreen(videoId: video['id']!),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://img.youtube.com/vi/${video['id']}/hqdefault.jpg',
                                fit: BoxFit.cover,
                                height: 120,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 120,
                                  color: Colors.grey.shade300,
                                  child: const Center(
                                    child: Icon(Icons.error, color: Colors.red),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white.withOpacity(0.8),
                                    size: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                video['title']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              if (video['source'] != null)
                                Text(
                                  video['source']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 6,
                                    color: Colors.black,
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
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLinksSection(String title, List<Map<String, String>> links) {
    if (links.isEmpty) {
      return Text(
        'No articles available.',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        ...links.asMap().entries.map((entry) {
          final link = entry.value;
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.link,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
                title: Text(
                  link['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _launchUrl(link['url']!),
              ),
              if (entry.key < links.length - 1)
                Divider(
                  color: Colors.grey.shade200,
                  height: 1,
                ),
            ],
          );
        }),
      ],
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {},
        child: Center(
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
                enableCaption: true,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: ProgressBarColors(
              playedColor: Colors.red.shade700,
              handleColor: Colors.red.shade900,
            ),
          ),
        ),
      ),
    );
  }
}
