import 'package:flutter/material.dart';
import 'package:remind/model/energy_stat_bodel.dart';

class SurveyResultRepository {
  Future<EnergyStat> getSurveyResult()async{
    await Future.delayed(Duration(seconds: 3));
    return EnergyStat(
        characterName:'작은 성공이 필요한 성실한 수달 타입',
        characterImagePath: 'assets/img/otter.png',
        mindEnergyValue: 70,
        bodyEnergyValue: 20,
        relationEnergyValue: 10,
        explanationText: '반복되는 무력감에 자존감이 많이 떨어져 있군요.거창한 목표보다는, "오늘 내가 해냈다"고 느낄 수 있는 작은 성공의 경험들이 필요해요. 꾸준히 돌멩이를 쌓아 멋진 집을 짓는 수달처럼, 작은 성취감이 모여 당신의 단단한 자존감을 만들어 줄 거예요.'
    );
  }
}