import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza/screens/auth/views/sign_up_screen.dart';
import 'package:user_repository/user_repository.dart';

import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import 'sign_in_screen.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({super.key});

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(20, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width/1.3,
                  width: MediaQuery.of(context).size.width/1.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
              ),
              BackdropFilter(
                filter:   ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/1.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: Theme.of(context).colorScheme.primary,
                          labelColor: Theme.of(context).colorScheme.onBackground,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18
                                ),
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sing Up',
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            BlocProvider<SignInBloc>(
                              create: (context) => SignInBloc(
                                context.read<AuthenticationBloc>().userRepository
                              ),
                              child: const SignInScreen(),
                            ),
                            BlocProvider<SignUpBloc>(
                              create: (context) => SignUpBloc(
                                context.read<AuthenticationBloc>().userRepository
                              ),
                              child: const SignUpScreen(),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}