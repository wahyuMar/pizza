import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/components/my_text_field.dart';
import 'package:pizza/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool constainUpperCase = false;
  bool constainLowerCase = false;
  bool constainNumber = false;
  bool constainSpacialChar = false;
  bool constain8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          setState(() {
            signUpRequired = false;
          });
        }
      },
      child: Form(
        key : _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(CupertinoIcons.mail_solid),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$').hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(CupertinoIcons.lock_fill),
                onChanged: (val) {
                  if (val!.contains(RegExp(r'[A-Z]'))) {
                    setState(() {
                      constainUpperCase = true;
                    });
                  } else {
                    setState(() {
                      constainUpperCase = false;
                    });
                  }
                  if (val.contains(RegExp(r'[a-z]'))) {
                    setState(() {
                      constainLowerCase = true;
                    });
                  } else {
                    setState(() {
                      constainLowerCase = false;
                    });
                  }
                  if (val.contains(RegExp(r'[0-9]'))) {
                    setState(() {
                      constainNumber = true;
                    });
                  } else {
                    setState(() {
                      constainNumber = false;
                    });
                  }
                  if (val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                    setState(() {
                      constainSpacialChar = true;
                    });
                  } else {
                    setState(() {
                      constainSpacialChar = false;
                    });
                  }
                  if (val.length >= 8) {
                    setState(() {
                      constain8Length = true;
                    });
                  } else {
                    setState(() {
                      constain8Length = false;
                    });
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      obscurePassword = !obscurePassword;
                      if (obscurePassword) {
                        iconPassword = CupertinoIcons.eye_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      }
                    });
                  },
                  icon: Icon(iconPassword),
                ),
                validator: (val) {
                  if(val!.isEmpty) {
                      return 'Please fill in this field';			
                    } else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    Text(
                      "⚈  1 uppercase",
                      style : TextStyle(
                        color: constainUpperCase
                          ? Colors.green
                          : Theme.of(context).colorScheme.onBackground
                      )
                    ),
                    Text(
                      "⚈  1 lowercase",
                      style : TextStyle(
                        color: constainLowerCase
                          ? Colors.green
                          : Theme.of(context).colorScheme.onBackground
                      )
                    ),
                    Text(
                      "⚈  1 number",
                      style : TextStyle(
                        color: constainNumber
                          ? Colors.green
                          : Theme.of(context).colorScheme.onBackground
                      )
                    ),
                  ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "⚈  1 special character",
                      style : TextStyle(
                        color: constainSpacialChar
                          ? Colors.green
                          : Theme.of(context).colorScheme.onBackground
                      )
                    ),
                    Text(
                      "⚈  8 characters",
                      style : TextStyle(
                        color: constain8Length
                          ? Colors.green
                          : Theme.of(context).colorScheme.onBackground
                      )
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: nameController,
                hintText: 'Name',
                obscureText: false,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(CupertinoIcons.person_fill),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Name is required';
                  } 
                  if (val.length > 50) {
                    return 'Name must be less than 50 characters';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            !signUpRequired
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        MyUser myUser = MyUser.empty;
                        myUser.email = emailController.text;
                        myUser.name = nameController.text;

                        setState(() {
                          context.read<SignUpBloc>().add(
                            SignUpRequired(myUser, passwordController.text)
                          );
                        });
                      }
                    },
                  style: TextButton.styleFrom(
                    elevation: 3.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)
                    )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  ),
              )
              : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}