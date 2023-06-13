import 'package:chat_app/const/images.dart';
import 'package:chat_app/const/strings.dart';
import 'package:chat_app/splashscreen.dart';
import 'package:chat_app/views/intro_screen/verification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:velocity_x/velocity_x.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.07, 0),
                        child: Image.asset(
                          logo,
                          width: 170,
                        ),
                      ),
                      appname.text.size(30).fontWeight(FontWeight.bold).make(),
                    ])),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10.0,
                      children: List.generate(listOfFeatures.length, (index) {
                        return Chip(
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          label: listOfFeatures[index]
                              .text
                              .color(Colors.purpleAccent)
                              .semiBold
                              .make(),
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: Vx.blue300),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    "Embrace".text.size(30).purple700.bold.make(),
                    "the Chatter,".text.size(30).bold.blue500.make(),
                    "Join the".text.size(30).bold.purple700.make(),
                    "Revolution".text.size(30).bold.blue500.make()
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                      width: context.screenWidth - 80,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple[400],
                              textStyle: const TextStyle()),
                          onPressed: () {
                            Get.to(() => const VerificationScreen(),
                                transition: Transition.downToUp);
                          },
                          child: cont.text
                              .color(Colors.white)
                              .size(16)
                              .semiBold
                              .make()),
                    ),
                    4.heightBox,
                    poweredby.text.size(15).blue600.make(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
