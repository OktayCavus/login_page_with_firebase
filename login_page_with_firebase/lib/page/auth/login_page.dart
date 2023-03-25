import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_with_firebase/constant.dart';

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

  ElevatedButton loginButton(double height) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(loginButtonColor),
            shape: const MaterialStatePropertyAll(StadiumBorder()),
            minimumSize:
                MaterialStatePropertyAll(Size(height * 0.25, height * 0.07))),
        onPressed: signIn,
        child: const Text('Giris Yap'));
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        final userResult = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacementNamed(context, '/homePage');
        //print(userResult.user!.email);
      } catch (e) {
        print(e.toString());
      }
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
                          children: const [
                            forgetPasswordButton(),
                            signUpButton(),
                          ],
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
}

class signUpButton extends StatelessWidget {
  const signUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, '/signUp'),
        child: Text(
          'Hesap Olustur',
          style: TextStyle(color: textButtonColor),
        ));
  }
}

class forgetPasswordButton extends StatelessWidget {
  const forgetPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          'Sifremi Unuttum',
          style: TextStyle(color: textButtonColor),
        ));
  }
}
