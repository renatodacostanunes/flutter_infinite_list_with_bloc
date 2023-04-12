import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(home: MyHomePage()),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  int itemCount = 15;
  bool isLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  _onScroll() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        itemCount += 5;
        print('Chegou no fim da lista...');

        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Loading'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Title $index'),
                  subtitle: const Text('Subtitle'),
                ),
              ),
            ),
            isLoading ? const CircularProgressIndicator() : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
