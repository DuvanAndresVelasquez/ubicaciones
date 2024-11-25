import 'dart:io';

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String? photo;
  final VoidCallback? onTap;

  const CardWidget({
    Key? key,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    this.photo,
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

          photo != null && photo!.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.file(
              File(photo!),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          )
              : const Icon(
            Icons.person,
            size: 50,
            color: Colors.grey,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nombre: $name $lastName",
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Email: $email",
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Teléfono: $phone",
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
