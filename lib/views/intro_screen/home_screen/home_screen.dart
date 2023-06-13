import 'package:chat_app/const/colors.dart';
import 'package:chat_app/controller/home_controller.dart';
import 'package:chat_app/views/compose%20screen/compose_screen.dart';
import 'package:chat_app/views/intro_screen/home_screen/components/appbar.dart';
import 'package:chat_app/views/intro_screen/home_screen/components/drawer.dart';
import 'package:chat_app/views/intro_screen/home_screen/components/tab_bar.dart';
import 'package:chat_app/views/intro_screen/home_screen/components/tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    var controller = Get.put(HomeController());
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldkey,
          drawer: drawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => const ComposeScreen(),
                  transition: Transition.downToUp);
            },
            backgroundColor: Vx.purple300,
            shape: const CircleBorder(),
            child: const Icon(Icons.create),
          ),
          backgroundColor: bgColor,
          body: Column(
            children: [
              appbar(scaffoldkey),
              Expanded(
                child: Row(
                  children: [
                    tabbar(),
                    tabbarView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
