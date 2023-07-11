import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  const DetailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'title',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            'st est veniam deserunt eu aliqua anim exercitation. Deserunt Lorem reprehenderit magna cupidatat sunt eiusmod ut sunt deserunt nulla ea tempor commodo',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
