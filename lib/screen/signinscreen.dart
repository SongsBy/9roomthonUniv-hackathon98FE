import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remind/const/color.dart';
import 'package:remind/model/agreement_model.dart';
import 'package:remind/model/signin_field_model.dart';
import 'package:remind/repository/signin_repository.dart';
import 'package:remind/screen/login_screen.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});

  @override
  State<Signinscreen> createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String passwordCheckText = '';

  final SigninRepository repository = GetIt.I<SigninRepository>();
  late final List<SigninFieldModel> signinFields;
  late final List<AgreementItemModel> agreementItems;

  late final List<TextEditingController> controllers;
  late final List<bool> agreementChecked;
  late final List<bool> obscures;


  @override
  initState() {
    super.initState();
    signinFields = repository.signinFields;
    agreementItems = repository.agreementItems;
    controllers = List.generate(signinFields.length, (_) => TextEditingController());
    agreementChecked = List.generate(agreementItems.length, (_) => false);
    obscures = signinFields.map((e) => e.obscure).toList();
    controllers[2].addListener(_checkPasswordMatch);
    controllers[3].addListener(_checkPasswordMatch);

  }

  void _checkPasswordMatch() {
    final pw = controllers[2].text;
    final res = controllers[3].text;


    setState(() {
      if (res.isEmpty) {
        passwordCheckText = '비밀번호가 다릅니다';
      } else if (pw == res) {
        passwordCheckText = '비밀번호가 일치합니다!';
      } else {
        passwordCheckText = '비밀번호가 다릅니다';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final line = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Image.asset('assets/img/headertext.png'),
    );
    final padding = SizedBox(height: 30);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Align(
                alignment: Alignment(-0, 1),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ///상단
                      _Top(),
                      ///텍스트 필드
                      _TextField(
                        signinFields: signinFields ,
                        controllers: controllers,
                        passwordCheckText: passwordCheckText,
                        obscures:obscures,
                        onEyeIconPressed: (int index){
                          setState(() {
                            obscures[index] = !obscures[index];
                          });
                        },
                      ),
                      ///구분선
                      line,
                      ///체크 박스
                      _CheckBox(
                          agreementItems: agreementItems,
                          agreementCheckd: agreementChecked,
                          onChanged: (index , value){
                            setState(() {
                              agreementChecked[index] = value;
                            });
                          },
                          ),
                      padding,
                      ///하단
                      _Bottom(onSigninPressed: onSigninPressed)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void onSigninPressed(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
  }
}
///상단위젯
class _Top extends StatefulWidget {
  const _Top({super.key});

  @override
  State<_Top> createState() => _TopState();
}

class _TopState extends State<_Top> {
  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
      child: Text('회원가입', style: titleLarge?.copyWith(fontSize: 25)),
    );
  }
}
///텍스트 입력 필드 위젯
class _TextField extends StatelessWidget {
  final List<SigninFieldModel>signinFields;
  final List<TextEditingController> controllers;
  final String passwordCheckText;
  final List<bool> obscures;
  final void Function(int) onEyeIconPressed;
  const _TextField({
    required this.signinFields,
    required this.controllers,
    required this.passwordCheckText,
    required this.obscures,
    required this.onEyeIconPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      signinFields.asMap().entries.map((entry) {
        int index = entry.key;
        final item = entry.value;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                height: 60,
                child: TextFormField(
                  controller: controllers[index],
                  obscureText: obscures[index],
                  decoration: InputDecoration(
                    labelText: item.header,
                    suffixIcon:
                    item.showicon
                        ? IconButton(
                    onPressed: (){
                      onEyeIconPressed(index);
                      },
                      icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset('assets/img/pwicon.png'),
                      ),
                    )
                        : null,
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            if (index == 3)
              Text(
                passwordCheckText,
                style: TextStyle(
                  color:
                  passwordCheckText.contains('일치')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}
///체크박스 위젯
typedef OnAgreementChanged = void Function(int index, bool value);
class _CheckBox extends StatelessWidget {
  final List<AgreementItemModel> agreementItems;
  final List<bool> agreementCheckd;
  final OnAgreementChanged onChanged;
  const _CheckBox({
    required this.agreementItems,
    required this.agreementCheckd,
    required this.onChanged,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        agreementItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 1.0,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(item.title, style: mediumText),
                Checkbox(
                  value: agreementCheckd[index],
                  onChanged: (bool? value) {
                    onChanged(index, value ?? false);
                  },
                  activeColor: primaryColor,
                  checkColor: Colors.white,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
/// 하단 위젯
class _Bottom extends StatelessWidget {
  final VoidCallback onSigninPressed;
  const _Bottom({
    required this.onSigninPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    final baseButtonStyle = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: baseButtonStyle,
        padding: EdgeInsets.symmetric(
          horizontal: 120,
          vertical: 17,
        ),
      ),
      onPressed: onSigninPressed,
      child: Text(
        '회원가입하기',
        style: mediumText?.copyWith(color: Colors.white),
      ),
    );
  }
}



