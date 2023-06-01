import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Services/global_variables.dart';

class Login extends StatefulWidget {


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _animationController;

  final TextEditingController _emailTextController = TextEditingController(text: '');
  FocusNode _passFocusNode = FocusNode();

  final _loginFormkey = GlobalKey<FormState>();

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
             imageUrl: loginUrlImage,
             placeholder: (context, url)=> Image.asset(
               'assets/images/wallpaper.jpg',
               fit: BoxFit.fill,
             ),
             errorWidget: (context, url , error) => const Icon(Icons.error),
             width: double.infinity,
             height: double.infinity,
             fit: BoxFit.cover,
             alignment: FractionalOffset(_animation.value, 0),

           ),
           Container(
             color: Colors.black54,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
               child: ListView(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 80, right: 80),
                     child: Image.asset('assets/images/Teacher student-pana.png'),
                   ),
                   const SizedBox(height: 15,),
                   Form(
                     key: _loginFormkey,
                     child: Column(
                       children: [
                         TextFormField(
                           textInputAction: TextInputAction.next,
                           onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode),
                           keyboardType: TextInputType.emailAddress,
                           controller: _emailTextController,
                           validator: (value)
                           {
                             if(value!.isEmpty || !value.contains('@'))
                               {
                                 return 'Please enter a valid Email address';
                               }
                             else{
                               return null;
                             }
                           },
                           style: const TextStyle(color: Colors.white),
                           decoration: const InputDecoration(
                             hintText: 'Enter your Email',
                             hintStyle: TextStyle(color: Colors.white),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.white),
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.white),
                             ),
                             errorBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.red),
                             )
                           ),
                         )
                       ],
                     ),
                   ),

                 ],
               ),
             ),
           ),
        ],
      ),
    );
  }
}
