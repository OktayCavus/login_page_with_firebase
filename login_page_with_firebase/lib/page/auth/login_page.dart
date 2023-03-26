import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_with_firebase/constant.dart';
import 'package:login_page_with_firebase/page/home_page.dart';
import 'package:login_page_with_firebase/service/auth_service.dart';
import 'package:login_page_with_firebase/widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // * Firebase auth methodlarına erişmek için bu değişkeni oluşturduk
  final firebaseAuth = FirebaseAuth.instance;

  // * Form widget'ını dışarıdan yönetmek için key oluşturmak lazım
  final formKey = GlobalKey<FormState>();

  late String email, password;

  final authService = AuthService();

  ElevatedButton loginButton(double height) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll(CustomColors.loginButtonColor),
            shape: const MaterialStatePropertyAll(StadiumBorder()),
            minimumSize:
                MaterialStatePropertyAll(Size(height * 0.25, height * 0.07))),
        onPressed: signIn,
        child: const Text('Giris Yap'));
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final result = await authService.signIn(email, password);
      if (result == 'success') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Geri Dön')),
                )
              ],
              content: Text(result!),
            );
          },
        );
      }

      /* try {
        final userResult = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacementNamed(context, '/homePage');
        //print(userResult.user!.email);
      } catch (e) {
        print(e.toString());
      }*/
    } else {}
  }

  TextFormField passwordTextField() {
    return TextFormField(
      // * textfield'a girilen bilgileri validator ile alacağız
      validator: (value) {
        if (value!.isEmpty) {
          return 'Bilgileri eksiksiz Doldur';
        }
        return null;
      },
      // * validator'den sonra çalışacak ve kullanıcının girdiği veriyi
      //* başka bir değişkene koyacaz
      onSaved: (value) {
        password = value!;
      },
      // ! obscureText içine yazılan yazıyı gizliyor
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: customInputDecoration('Password'),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Bilgileri eksiksiz Doldur';
        }
        return null;
      },
      // * validator'den sonra çalışacak ve kullanıcının girdiği veriyi
      //* başka bir değişkene koyacaz
      onSaved: (value) {
        email = value!;
      },
      style: const TextStyle(color: Colors.white),
      decoration: customInputDecoration('Email'),
    );
  }

  Widget customSizedBox() => const SizedBox(
        height: 20,
      );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        // ! focus olmayınca gri gözükecek
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(imagePath('topImage')))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Merhaba, \nHoşgeldin',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        customSizedBox(),
                        emailTextField(),
                        customSizedBox(),
                        passwordTextField(),
                        customSizedBox(),
                        Center(
                            // ! LOGİN BUTONU
                            child: loginButton(height)),
                        customSizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const forgetPasswordButton(),
                            CustomTextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signUp'),
                              buttonText: 'Hesap Olustur',
                            ),
                          ],
                        ),
                        Center(
                          child: CustomTextButton(
                              onPressed: () async {
                                final result =
                                    await authService.signInAnonymous();

                                if (result != null) {
                                  Navigator.pushReplacementNamed(
                                      context, '/homePage');
                                } else {
                                  print('auth anon hata');
                                }
                              },
                              buttonText: 'Misafir Girisi'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*TextButton signUpButton(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, '/signUp'),
        child: const Text(
          'Hesap Olustur',
          style: TextStyle(color: CustomColors.textButtonColor),
        ));
  }*/
}

class forgetPasswordButton extends StatelessWidget {
  const forgetPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Sifremi Unuttum',
          style: TextStyle(color: CustomColors.textButtonColor),
        ));
  }
}
