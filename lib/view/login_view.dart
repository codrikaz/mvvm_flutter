import 'package:flutter/material.dart';
import 'package:mvvm_flu/res/components/round_button.dart';
import 'package:mvvm_flu/utils/routes/routes_name.dart';
import 'package:mvvm_flu/utils/utils.dart';
import 'package:mvvm_flu/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height  = MediaQuery.of(context).size.height * 1 ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.alternate_email)
              ),
              onFieldSubmitted: (valu){
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context , value, child){
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value,
                    focusNode: passwordFocusNode,

                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      suffixIcon: InkWell(
                          onTap: (){
                            _obsecurePassword.value = !_obsecurePassword.value ;
                          },
                          child: Icon(
                              _obsecurePassword.value ?  Icons.visibility_off_outlined :
                              Icons.visibility
                          )),
                    ),
                  );

                }
            ),
            SizedBox(height: height * .085,),
            RoundButton(
              title: 'Login',
              loading: authViewMode.loading,
              onPress: (){
                if(_emailController.text.isEmpty){

                  Utils.flushBarErrorMessage('Please enter email', context);
                }else if(_passwordController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please enter password', context);

                }else if(_passwordController.text.length < 6){
                  Utils.flushBarErrorMessage('Please enter 6 digit password', context);

                }else {


                  // Map data = {
                  //   'email' : _emailController.text.toString(),
                  //   'password' : _passwordController.text.toString(),
                  // };

                  Map data = {
                    'email' : 'eve.holt@reqres.in',
                    'password' : 'cityslicka',
                  };

                  authViewMode.loginApi(data , context);
                  print('api hit');
                }
              },
            ),
            SizedBox(height: height * .02,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.signUp);
              },
                child: Text("Don't have an accont? Sign Up"))

          ],
        ),
      ),
    );
  }

}
