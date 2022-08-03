import 'package:flutter/material.dart';
import 'package:msmchat/pages/base_staless_widget.dart';
import 'package:msmchat/pages/login/login_cubit.dart';
import 'package:msmchat/pages/register_account/register_account_page.dart';
import 'package:msmchat/utils/app_color.dart';

class LoginPage extends BaseStatelessWidget<LoginCubit> {
  LoginPage({Key? key}) : super(key: key, cubit: LoginCubit());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset('assets/images/default_avatar.png',
                    color: AppColor.primaryColor),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  TextField(
                    controller: cubit.usernameController,
                    decoration: const InputDecoration(
                      hintText: 'username',
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    style: const TextStyle(fontSize: 18),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: cubit.passwordController,
                    decoration: const InputDecoration(
                      hintText: 'password',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    style: const TextStyle(fontSize: 18),
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      InkWell(
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(color: AppColor.greenActiveColor, fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterAccountPage(),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.logIn(context);
                          },
                          child: const Text('ĐĂNG NHẬP'),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
