import 'package:flutter/material.dart';
import 'package:safecitadel/components/form_error.dart';
import 'package:safecitadel/helper/keyboard.dart';
import 'package:safecitadel/screens/forgot_password/forgot_password_screen.dart';
import 'package:safecitadel/screens/home/home_screen.dart';
import 'package:safecitadel/utils/Persistence.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:safecitadel/utils/Persistencia.dart';
import 'package:safecitadel/models/User.dart';

class SignForm extends StatefulWidget {

  SignForm({super.key});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  late SharedPreferencesUtil prefsUtil;

  final _formKey = GlobalKey<FormState>();

  String? username;

  String? password;

  bool? remember = false;

  String _errorMessage = '';

  final List<String?> errors = [];
  bool passToggle = false;
  @override
  void initState() {
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    prefsUtil = await SharedPreferencesUtil.getInstance();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
  } 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        buildUsernameFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPasswordFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        Row(
          children: [
            Checkbox(
              value: remember,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                remember = value;
              },
            ),
            const Text("Recordarme"),
            const Spacer(),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              child: const Text(
                "Olvidé mi contraseña",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(20)),
        DefaultButton(
          press: () {
            final apiClient = ApiGlobal.api;
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // if all are valid then go to success screen
              KeyboardUtil.hideKeyboard(context);
            }
            apiClient.authenticate(username, password,context).then((_) {
              widgetLoading(context);
              apiClient.getUserData().then((userData) {
                UserSingleton.user = userData;
                widgetLoading(context);
                Future.delayed(const Duration(seconds: 4), () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                });
              }).catchError((error) {
                _errorMessage = error.toString();
              });
            }).catchError((error) {
              _errorMessage = error.toString();
            });
          },
          text: 'Iniciar Sesión',
        ),
        if (_errorMessage.isNotEmpty)
          Text(
            _errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
      ]),
    );
  }

  TextFormField buildPasswordFormField() {
    
    return TextFormField(
      obscureText: !passToggle,
      enableInteractiveSelection: false,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 7) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 7) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingresar contraseña",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               passToggle
               ? Icons.visibility
               : Icons.visibility_off,
               ),
            onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                   passToggle = !passToggle;
               });
             },
            ),
          ),
      );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUsernameNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kUsernameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Usuario",
        hintText: "Ingresar usuario",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}
