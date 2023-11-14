import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class QuoteGenerator extends StatefulWidget {
  const QuoteGenerator({super.key});

  @override
  State<QuoteGenerator> createState() => _QuoteGeneratorState();
}

class _QuoteGeneratorState extends State<QuoteGenerator> {
  final String quoteURL = "https://zenquotes.io/api/random";
  String quote = 'Random Quote';

  generateQuote() async {
  var res = await http.get(Uri.parse(quoteURL));
  var result = jsonDecode(res.body);
  print(result[0]["q"]);
  setState(() {
    // Access the first element of the list and then access the "q" key
    quote = result[0]["q"];
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x44000000),
        elevation: 0,
        title: const Text('Random Quote Generator',
        style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(),
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1505506874110-6a7a69069a08?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c3BhY2V8ZW58MHx8MHx8fDA%3D"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  quote,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  generateQuote();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                ),
                child: const Text('Generate',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("You want to share");
                  Share.share(quote);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
