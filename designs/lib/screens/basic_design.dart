import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
   
  const BasicDesignScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Column(
        children: [
            const Image(image: AssetImage('assets/landscape.png')),
            const Title(),

            const ButtonSection(),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text('Mollit veniam pariatur consequat mollit anim commodo duis. Magna velit esse veniam ad laborum cillum labore est officia. Voluptate pariatur quis reprehenderit nostrud dolor sint deserunt. Minim qui incididunt aliquip officia ad.Elit elit quis in sit reprehenderit ipsum voluptate voluptate deserunt ex commodo est ullamco culpa. Anim magna anim esse excepteur eiusmod sint fugiat sit. Minim consequat id magna consectetur in occaecat duis excepteur irure minim aliquip dolore fugiat. Labore irure non cupidatat et duis nostrud proident in consectetur duis aliqua et. Duis esse fugiat est qui quis Lorem fugiat. Dolor sunt nulla ullamco aliqua excepteur. Consequat ex commodo aliqua laboris nulla consequat quis eu.'))
        ],
      )
      );

  }
}


class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child:  Row(
       
        children: [
         const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Oeschinen Lake Campground', style: TextStyle(fontWeight:FontWeight.bold )),
             Text('kandersteg, Switzerland', style: TextStyle(color: Colors.black45)),
          ],
         ),
    
          Expanded(           
             child: Container(),
            ),
          const Icon(Icons.star, color: Colors.red),
          const Text('41'),
        ],
      ),
    );
  }

  
}


class ButtonSection extends StatelessWidget {
  const ButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: const Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      
      CustomButton(icon: Icons.call, text: 'CALL'),
      CustomButton(icon: Icons.arrow_outward_rounded, text: 'ROUTE'),
      CustomButton(icon: Icons.share, text: 'SHARE'),
       
       
       
      ],
    ),
    );

  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomButton({
    super.key, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Icon(icon, color: Colors.lightBlue, size: 35),
         Text(text, style: const TextStyle(color: Colors.lightBlue),),
      ],
    );
  }
}









