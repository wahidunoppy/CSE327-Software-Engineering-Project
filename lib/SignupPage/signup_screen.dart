import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:setp/Services/global_variables.dart';

class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>with TickerProviderStateMixin {

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((animationStatus) {
        if(animationStatus == AnimationStatus.completed)
        {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: signUpUrlImage,
            placeholder: (context, url) => Image.asset(
              'assets/images/wallpaper.jpg',
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error)=> const Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
        ],
      ),
    );
  }
}
