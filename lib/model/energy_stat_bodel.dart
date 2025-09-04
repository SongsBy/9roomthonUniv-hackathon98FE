import 'dart:ui';

class EnergyStat {
  final String characterName;
  final String characterImagePath;
  final int mindEnergyValue;
  final int bodyEnergyValue;
  final int relationEnergyValue;
  final String explanationText;

  EnergyStat({
    required this.characterName,
    required this.characterImagePath,
    required this.mindEnergyValue,
    required this.bodyEnergyValue,
    required this.relationEnergyValue,
    required this.explanationText
});
}