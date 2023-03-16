class Hasill {
  final String hasil;

  Hasill({required this.hasil});

  factory Hasill.fromRTDB(Map<String, dynamic> data) {
    return Hasill(hasil: data['hasil']);
  }
}
