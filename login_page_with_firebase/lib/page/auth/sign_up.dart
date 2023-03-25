import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_with_firebase/constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email, password;
  // * Form widget'ını dışarıdan yönetmek için key oluşturmak lazım
  final formKey = GlobalKey<FormState>();
  // * Firebase auth methodlarına erişmek için bu değişkeni oluşturduk
  final firebaseAuth = FirebaseAuth.instance;
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
              Stack(
                children: [
                  Container(
                    height: height * 0.25,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(imagePath('topImage')))),
                  ),
                  const backToLoginPage(),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customSizedBox(),
                          emailTextField(),
                          customSizedBox(),
                          passwordTextField(),
                          customSizedBox(),
                          customSizedBox(),
                          signUpButton(),
                        ]),
                  ))
            ],
          ),
        )),
      ),
    );
  }

  TextButton signUpButton() {
    return TextButton(
        onPressed: signUp,
        child: const Text(
          'Hesap Olustur',
          style: TextStyle(color: CustomColors.textButtonColor),
        ));
  }

  void signUp() async {
    // ! form'a erişip validator ve onSaved işlemlerini yapacaz
    // ! validate işlemi yapıldıysa save işlemine bakılması lazım
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        // * userResult.user ile bir çok dğeişkene ulaşabiliyoruz
        var userResult = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        formKey.currentState!.reset();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Hesap oluşturuldu ')));
        Navigator.pushReplacementNamed(context, '/loginPage');
      } catch (e) {
        print(e.toString());
      }
    } else {}
  }

  TextFormField passwordTextField() {
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
        password = value!;
      },
      // ! obscureText içine yazılan yazıyı gizliyor
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: customInputDecoration('Sifre'),
    );
  }

  TextFormField emailTextField() {
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
        email = value!;
      },
      style: const TextStyle(color: Colors.white),
      decoration: customInputDecoration('E-mail'),
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
}

class backToLoginPage extends StatelessWidget {
  const backToLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, '/loginPage'),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 40));
  }
}
