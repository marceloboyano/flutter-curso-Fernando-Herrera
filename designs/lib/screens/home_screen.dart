
import 'package:designs/widgets/background.dart';
import 'package:designs/widgets/card_table.dart';
import 'package:designs/widgets/custom_bottom_navigator.dart';
import 'package:designs/widgets/page_title.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          const Background(),
          _HomeBody(),
          
        ],

      ),
       bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          PageTitle(),
            CardTable(),


        ],
      ),
    );
  }
}