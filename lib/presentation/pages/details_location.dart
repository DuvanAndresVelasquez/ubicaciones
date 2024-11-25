import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prueba/domain/entities/location.dart';

class LocationDetailPage extends StatelessWidget {
  final Location location;

  const LocationDetailPage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (location.description != null)
              Text(
                location.description!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            const SizedBox(height: 16),
            const Text(
              "Fotos:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (location.photos != "")
              Expanded(
                child: ListView.builder(
                  itemCount: location.photos?.length,
                  itemBuilder: (context, index) {
                    final photo = location.photos?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          File(photo!),
                          width: 280,
                          height: 280,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Center(
                child: Text(
                  "No hay fotos disponibles.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
