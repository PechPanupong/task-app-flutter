import 'package:flutter/material.dart';

import '../../models/task.dart';

class DetailBox extends StatefulWidget {
  final TaskModel data;

  const DetailBox({
    required this.data,
  });

  @override
  State<DetailBox> createState() => _DetailBoxState();
}

class _DetailBoxState extends State<DetailBox> {
  bool toggleShow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          toggleShow = !toggleShow;
        });
      },
      child: ListTile(
        title: Text(
          widget.data.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(widget.data.description,
            maxLines: 2, overflow: TextOverflow.ellipsis),
        leading: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              widget.data.status,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
