import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InteractiveDemo(),
  ));
}

class InteractiveDemo extends StatefulWidget {
  const InteractiveDemo({Key? key}) : super(key: key);

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  // Counter using ValueNotifier
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  // Toggle using setState
  bool _showWidget = true;

  // Task list using setState
  final List<bool> _tasksChecked = [false, false, false];

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151C17),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Interactive Demo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Counter Section
            const SizedBox(height: 8),
            const Text(
              'Counter',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap the button to increment the counter.',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (context, value, _) => Text(
                'Count: $value',
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7EE2A0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () => _counter.value++,
                child: const Text(
                  'Increment',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Toggle Visibility Section
            const Text(
              'Toggle Visibility',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Toggle the visibility of the widget below.',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Show Widget',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                Switch(
                  value: _showWidget,
                  onChanged: (val) => setState(() => _showWidget = val),
                  activeColor: const Color(0xFF7EE2A0),
                  inactiveTrackColor: Colors.white24,
                ),
              ],
            ),
            const SizedBox(height: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showWidget
                  ? Container(
                key: const ValueKey('image'),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
                  : const SizedBox(height: 24),
            ),

            // Task List Section
            const Text(
              'Task List',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Mark tasks as completed by checking the boxes.',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 16),
            ...List.generate(3, (i) {
              final tasks = [
                'Task 1: Buy groceries',
                'Task 2: Finish report',
                'Task 3: Call mom',
              ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        tasks[i],
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Checkbox(
                      value: _tasksChecked[i],
                      onChanged: (val) => setState(() => _tasksChecked[i] = val!),
                      activeColor: const Color(0xFF7EE2A0),
                      checkColor: Colors.black,
                      side: const BorderSide(color: Colors.white54),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}