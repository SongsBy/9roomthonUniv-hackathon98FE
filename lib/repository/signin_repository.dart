import 'package:flutter/material.dart';
import 'package:remind/model/agreement_model.dart';
import 'package:remind/model/signin_field_model.dart';

class SigninRepository {
  List<SigninFieldModel> get signinFields {
    return [
      SigninFieldModel(header: '이름', obscure: false, showicon:false),
      SigninFieldModel(header: '아이디', obscure: false, showicon:false),
      SigninFieldModel(header: '비밀번호', obscure: true, showicon:true),
      SigninFieldModel(header: '비밀번호 확인', obscure: true, showicon:true),
    ];
  }
  List<AgreementItemModel> get agreementItems{
    return [
      AgreementItemModel(title: '이용 약관 동의(필수)', isRequired: true),
      AgreementItemModel(title: '개인정보 수집 동의(필수)', isRequired: true),
      AgreementItemModel(title: '개인정보 수집 동의(선택)', isRequired: false),
      AgreementItemModel(title: '혜택/알림 정보 수신 동의(선택)', isRequired: false),
    ];
  }
}

