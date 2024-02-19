import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      title: 'BLOOD SUGAR CLASSIFIER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatelessWidget {
  final TextEditingController beforeController = TextEditingController();
  final TextEditingController afterController = TextEditingController();

  InputScreen({super.key});

  void validateData(BuildContext context) {
    double before = double.tryParse(beforeController.text) ?? 0.0;
    double after = double.tryParse(afterController.text) ?? 0.0;
    if (before <= 0 || after <= 0) {
      Get.defaultDialog(
        title: "Invalid Data",
        middleText: "Please enter valid blood sugar values.",
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text("OK"),
          ),
        ],
      );
    } else {
      Get.to(InformationScreen(before: before, after: after));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLOOD SUGAR CLASSIFIER')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/A3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Input Blood Sugar Data',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: beforeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Before Meal (mg/dL)',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: afterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'After Meal (mg/dL)',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => validateData(context),
                child: const Text('Show Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationScreen extends StatelessWidget {
  final double before;
  final double after;

  const InformationScreen({super.key, required this.before, required this.after});

  String getCategory(double before, double after) {
    double difference = after - before;
    if (difference < 0) {
      return "Low blood sugar level";
    } else if (difference == 0) {
      return "blood sugar level is Normal";
    } else {
      return "High blood sugar level";
    }
  }

  @override
  Widget build(BuildContext context) {
    String category = getCategory(before, after);
    return Scaffold(
      appBar: AppBar(title: const Text('Blood Sugar Information')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/2287209.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Before Meal: $before mg/dL',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                'After Meal: $after mg/dL',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Category: $category',
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Image.asset(
                'assets/62f2bee4de0117f1ec10c745_BloodGlucoseChart.jpeg',
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}









