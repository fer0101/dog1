import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Dog.dart';
import 'dogProvider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  bool isLoading = false;

  MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Dog App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dog App'),
        ),
        body: Column(
          children: [
            const Text("Nuevo Perro"),
            Consumer(builder: (context, ref, child) {
              final dogAsyncValue = ref.watch(dogProvider);
              return dogAsyncValue.when(
                data: (dog) => Image.network(dog),
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              );
            }),
            const SizedBox(
              width: 20,
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  ref.refresh(dogProvider);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Cargar imagen'),
            ),
          ],
        ),
      ),
    );
  }
}
