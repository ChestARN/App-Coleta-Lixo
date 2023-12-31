import 'package:app_coleta_lixo/pages/account_auth/signup_page.dart';
import 'package:app_coleta_lixo/pages/bottom_bar_pages/bottom_navigator_controller.dart';
import 'package:app_coleta_lixo/providers/state_controller.dart';
import 'package:app_coleta_lixo/providers/usuario_controller.dart';
import 'package:app_coleta_lixo/services/colors.dart';
import 'package:app_coleta_lixo/widgets/custom_widgets.dart';
import 'package:app_coleta_lixo/widgets/theme_save.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:app_coleta_lixo/data_api/repositories/usuario_repository.dart';
import 'package:app_coleta_lixo/data_api/http/http_client.dart';
import 'package:intl/intl.dart';


class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});
  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  String convertDateFormat(String originalDate) {
  final inputFormat = DateFormat('dd/MM/yyyy');
  final outputFormat = DateFormat('yyyy-MM-dd');

  final date = inputFormat.parse(originalDate);
  final formattedDate = outputFormat.format(date);

  return formattedDate;
  }
  final UsuarioController usuarioController = UsuarioController(
      repository: UsuarioRepository(
    client: HttpClient(),
  ));

  final _nameTextController = TextEditingController(),
      _emailTextController = TextEditingController(),
      _phoneTextController = TextEditingController(),
      _cpfTextController = TextEditingController(),
      _passwordTextController = TextEditingController(),
      _dateTextController = TextEditingController();

  List<String> name = [];

  String username = '',
      first_name = '',
      last_name = '',
      email = '',
      phoneNumber = '',
      cpf = '',
      password = '',
      date = '';

  var nameMaskFormatter = MaskTextInputFormatter(
      mask:
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
      filter: {
        "x": RegExp(
            r'[a-zA-ZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØŒŠÞÚÛÜÝßàáâãäåæçèéêëìíîïðñòóôõöøœšþúûüýÿ\s]'),
      },
      type: MaskAutoCompletionType.eager);
  var phoneNumberMaskFormatter = MaskTextInputFormatter(
      mask: '(xx) xxxx-xxxx',
      filter: {
        "x": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);
  var phoneNumberMaskFormatterSecond = MaskTextInputFormatter(
      mask: '(xx) xxxxx-xxxx',
      filter: {
        "x": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);
  var cpfMaskFormatter = MaskTextInputFormatter(
      mask: 'xxx.xxx.xxx-xx',
      filter: {
        "x": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);
  var dateMaskFormatter = MaskTextInputFormatter(
      mask: 'xx/xx/xxxx',
      filter: {
        "x": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy);
  Widget _body() {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return AnimatedBuilder(
          animation: AppController.instance,
          builder: (context, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ScrollConfiguration(
                behavior: ScrollRemove(),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        children: [
                          AutoSizeTextField(
                            textAlign: TextAlign.center,
                            inputFormatters: [nameMaskFormatter],
                            controller: _nameTextController,
                            maxLength: 100,
                            onChanged: (text) {
                              name = text.split(' ');
                              if (name.length == 1) {
                                usuarioController.atualizarUsuarioNome(
                                    username: name[0],
                                    first_name: name[0],
                                    last_name: SignUpPage.surname);
                                SignUpPage.name = name[0];
                              } else if (name.length >= 2) {
                                usuarioController.atualizarUsuarioNome(
                                    username: name[0],
                                    first_name: name[0],
                                    last_name: name[1]);
                                SignUpPage.name = name[0];
                                SignUpPage.surname = name[1];
                              }
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              isDense: true,
                              counterText: '',
                              prefixIcon: Icon(
                                Icons.person,
                                size: 24,
                                color: MyColors.primary[400],
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 24,
                                color: notifier.darkTheme
                                    ? Colors.grey[400]
                                    : MyColors.darkGrayScale[300],
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              label: Center(
                                widthFactor:
                                    MediaQuery.of(context).size.width / 2,
                                child: const Text(
                                  'Nome',
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AutoSizeTextField(
                            textAlign: TextAlign.center,
                            controller: _emailTextController,
                            onChanged: (text) {
                              SignUpPage.email = text;
                              usuarioController.atualizarUsuarioEmail(
                                  email: SignUpPage.email);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              counterText: '',
                              prefixIcon: Icon(
                                Icons.email,
                                size: 24,
                                color: MyColors.primary[400],
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 24,
                                color: notifier.darkTheme
                                    ? Colors.grey[400]
                                    : MyColors.darkGrayScale[300],
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              label: Center(
                                widthFactor:
                                    MediaQuery.of(context).size.width / 2,
                                child: const Text(
                                  'Email',
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              /* USA ESSA POHA*/
                              TextInputMask(
                                mask: ['(99) 9999-9999', '(99) 99999-9999'],
                                reverse: false,
                              )
                            ],
                            controller: _phoneTextController,
                            onChanged: (text) {
                              SignUpPage.phone = text;
                              usuarioController.atualizarUsuarioTelefone(
                                  telefone: SignUpPage.phone);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              prefixIcon: Icon(
                                Icons.phone,
                                size: 24,
                                color: MyColors.primary[400],
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 24,
                                color: notifier.darkTheme
                                    ? Colors.grey[400]
                                    : MyColors.darkGrayScale[300],
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              label: Center(
                                widthFactor:
                                    MediaQuery.of(context).size.width / 2,
                                child: const Text(
                                  'Número de celular',
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            inputFormatters: [cpfMaskFormatter],
                            controller: _cpfTextController,
                            onChanged: (text) {
                              cpf = text;
                              usuarioController.atualizarUsuarioCpf(cpf: cpf);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              prefixIcon: Icon(
                                Icons.badge,
                                size: 24,
                                color: MyColors.primary[400],
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 24,
                                color: notifier.darkTheme
                                    ? Colors.grey[400]
                                    : MyColors.darkGrayScale[300],
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              label: Center(
                                widthFactor:
                                    MediaQuery.of(context).size.width / 2,
                                child: const Text(
                                  'CPF',
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            controller: _passwordTextController,
                            onChanged: (text) {
                              password = text;
                              usuarioController.atualizarUsuarioPassword(
                                  password: password);
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              counterText: '',
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 24,
                                color: MyColors.primary[400],
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 24,
                                color: notifier.darkTheme
                                    ? Colors.grey[400]
                                    : MyColors.darkGrayScale[300],
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              label: Center(
                                widthFactor:
                                    MediaQuery.of(context).size.width / 2,
                                child: const Text(
                                  'Senha',
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            inputFormatters: [dateMaskFormatter],
                            controller: _dateTextController,
                            onChanged: (text) {
                              final formattedDate = convertDateFormat(text);
                              usuarioController.atualizarUsuarioDataNascimento(
                                  dt_nascimento: formattedDate);
                            },
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                              counterText: '',
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                size: 24,
                                color: MyColors.primary[400],
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 24,
                                color: notifier.darkTheme
                                    ? Colors.grey[400]
                                    : MyColors.darkGrayScale[300],
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              label: Center(
                                widthFactor:
                                    MediaQuery.of(context).size.width / 2,
                                child: const Text(
                                  'Data de nascimento',
                                ),
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            child: Container(child: Icon(Icons.add)),
                            onTap: () => print(
                                phoneNumber.replaceAll(RegExp(r"\D"), "")),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dados pessoais'),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: notifier.darkTheme
                  ? const Color(0xFFFFFFFF)
                  : const Color.fromARGB(0, 0, 0, 0).withOpacity(1),
            ),
            backgroundColor: notifier.darkTheme
                ? MyColors.grayScale[900]
                : Colors.white.withOpacity(1),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: const AppNavigator(),
                  ),
                );
              },
              child: Icon(
                Icons.arrow_back,
                color: notifier.darkTheme ? Colors.grey : Colors.grey[800],
                size: 28,
              ),
            ),
            elevation: 1,
          ),
          body: Stack(
            children: [
              _body(),
            ],
          ),
        );
      },
    );
  }
}
