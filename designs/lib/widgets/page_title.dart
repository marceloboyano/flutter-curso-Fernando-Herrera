import 'package:flutter/material.dart';

class PageTitle extends StatefulWidget {
  const PageTitle({super.key});

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Classify transaction',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            SizedBox(height: 10),
            Text('Classify this transaction into a particular \ncategory',style: TextStyle(fontSize: 16, color: Colors.white),
            maxLines: 2),
          ],
        ),
      ),
    );
  }
}