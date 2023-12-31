import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Controlador geral dos widgets do aplicativo
class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  bool isDarkTheme = false,
      isSignUpCheckboxConfirmed = false,
      produtorState = false,
      coletorState = false,
      sucatariaState = false,
      occupationState = false;

  int bottomNotifications = 0;

  //Função para alterar estado do switch de Dark Mode
  Future<void> changeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isDarkTheme == true) {
      prefs.setBool("isDarkTheme", true);
    } else if (isDarkTheme == false) {
      prefs.setBool("isDarkTheme", false);
    }
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  //Função para alterar estado da Checbox da página de cadastro
  checkboxSet() {
    isSignUpCheckboxConfirmed = !isSignUpCheckboxConfirmed;
    notifyListeners();
  }

  //Funções para alterar o estado dos Buttons da segunda página de cadastro
  catadorSet() {
    produtorState = !produtorState;
    notifyListeners();
  }

  coletorSet() {
    coletorState = !coletorState;
    notifyListeners();
  }

  sucatariaSet() {
    sucatariaState = !sucatariaState;
    notifyListeners();
  }

  occupationSet() {
    occupationState = !occupationState;
    notifyListeners();
  }
}
