import 'package:flutter/material.dart';

void main() {
  runApp(const Aplikasi());
}

class Aplikasi extends StatelessWidget {
  const Aplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tes Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IndexScreen(),
    );
  }
}

// ########################################################################

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImplicitAnimation(),
            const SizedBox(height: 20),
            const ConfiguredImplicit(),
            const Row(),
            const SizedBox(height: 20),
            const ExplicitAnimation(),
            const FinetuningExplicit(),
            const SizedBox(height: 20),
            Hero(
              tag: "can be text/int/anything",
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ObjectMovedScreen(),
                      ));
                },
                child: const Text("change-screen object transition"),
              ),
            ),
          ],
        ));
  }
}

// --------------------------------------

class ObjectMovedScreen extends StatelessWidget {
  const ObjectMovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Hero(
            tag: "can be text/int/anything",
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("go back"),
            ),
          ),
        ),
      ),
    );
  }
}

// ########################################################################

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});
  // sebenernya bisa stateless, tapi mau implement switch jadinya stateful

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  bool lamp = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(value: lamp, onChanged: (b) => setState(() => lamp = !lamp)),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 4000),
          child: SizedBox(
            key: ValueKey(lamp),
            // here animatedswitcher think nothing changes, since the outer widget
            // not change (in our case sizedbox). so we added key to let dart
            // know there is definately a change, based on a value, in our case the lamp bool
            child: lamp
                ? const Text('implicit animation (2)')
                : const Text('implicit animation (1)'),
          ),
          transitionBuilder: (child, animation) {
            return RotationTransition(turns: animation, child: child);
          },
        ),
      ],
    );
  }
}

// ########################################################################

class ConfiguredImplicit extends StatefulWidget {
  const ConfiguredImplicit({super.key});
  // sebenernya bisa stateless, tapi mau implement switch jadinya stateful

  @override
  State<ConfiguredImplicit> createState() => _ConfiguredImplicitState();
}

class _ConfiguredImplicitState extends State<ConfiguredImplicit> {
  bool lamp = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(value: lamp, onChanged: (b) => setState(() => lamp = b)),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 4000),
          child: SizedBox(
            key: ValueKey(lamp),
            // here animatedswitcher think nothing changes, since the outer widget
            // not change (in our case sizedbox). so we added key to let dart
            // know there is definately a change, based on a value, in our case the lamp bool
            child: lamp
                ? const Text('configured implicit (2)')
                : const Text('configured implicit (1)'),
          ),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween<double>(
                begin: 0.7,
                end: 0.0,
              ).animate(
                // animation, // for more simple you can also directly use this
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            );
          },
        ),
      ],
    );
  }
}

// ########################################################################

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({
    super.key,
  });

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with SingleTickerProviderStateMixin {
  // if need more animation controller, use TickerProviderStateMixin instead
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
      // lowerBound: 0, // no need, already a default
      // upperBound: 1, // no need, already a default
    );

    _animation.repeat(); // there also .forward or .stop
    // usually we us .forward, but here we use repeat to see the animation haha
  }

  @override
  void dispose() {
    _animation.dispose(); // delete memory before close this page.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        child: const Text('explicit animation'),
        // child used if you sure it wont rebuild, for performance
        // and this is best pratice, to separate animation widget with its childs
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.only(left: 100 - 100 * _animation.value),
            child: child,
            // and then you call that non-rebuild child here
          );
        });
  }
}

// ########################################################################

class FinetuningExplicit extends StatefulWidget {
  const FinetuningExplicit({
    super.key,
  });

  @override
  State<FinetuningExplicit> createState() => _FinetuningExplicitState();
}

class _FinetuningExplicitState extends State<FinetuningExplicit>
    with SingleTickerProviderStateMixin {
  // if need more animation controller, use TickerProviderStateMixin instead
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
      // lowerBound: 0, // no need, already a default
      // upperBound: 1, // no need, already a default
    );

    _animation.repeat(); // there also .forward or .stop
    // usually we us .forward, but here we use repeat to see the animation haha
  }

  @override
  void dispose() {
    _animation.dispose(); // delete memory before close this page.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: const Text('finetunning explicit'),
      // child used if you sure it wont rebuild, for performance
      // and this is best pratice, to separate animation widget with its childs
      builder: (context, child) => SlideTransition(
        // position: _animation.drive(Tween(
        //   begin: const Offset(0.7, 0),
        //   end: const Offset(0, 0),
        // )),
        // you can choose .drive or directly use tween
        position: Tween(
          begin: const Offset(0.7, 0),
          end: const Offset(0.0, 0),
        ).animate(
          // animation, // for more simple you can also directly use this
          CurvedAnimation(parent: _animation, curve: Curves.easeInOut),
          // but using .animate give you this more control, cool
        ),
        // and then you call that non-rebuild child here
        child: child,
      ),
    );
  }
}
