class ClassificationResult {
  final String label;
  final double confidence;
  final Map<String, double> topResults;

  ClassificationResult({
    required this.label,
    required this.confidence,
    required this.topResults,
  });
}
