import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PriorityScreen extends StatefulWidget {
  const PriorityScreen({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<PriorityScreen> createState() => _PriorityScreenState();
}

class _PriorityScreenState extends State<PriorityScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.categoryId),
    );
  }
}