import 'dart:io';

import 'package:flutter/material.dart';

class CardLocationWidget extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback? onTap;

  const CardLocationWidget({
    Key? key,
    required this.name,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = Colors.white;
    final shadowColor = Colors.grey[300];
    final textColor = Colors.black;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          if (shadowColor != null)
            BoxShadow(
              color: shadowColor!,
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                ),
              ),

            ],
          ),
          Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.grey),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
