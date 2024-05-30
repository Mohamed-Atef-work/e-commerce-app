import 'package:flutter/material.dart';

class LoadingHeartWidget extends StatefulWidget {
  const LoadingHeartWidget({super.key});

  @override
  State<LoadingHeartWidget> createState() => _LoadingHeartWidgetState();
}

class _LoadingHeartWidgetState extends State<LoadingHeartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    animation =
        Tween<double>(begin: 0.1, end: 0.7).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: IconButton(
        splashRadius: 20,
        onPressed: () {},
        splashColor: Colors.red,
        highlightColor: Colors.transparent,
        icon: const Icon(
          size: 35,
          Icons.favorite,
          color: Colors.red,
        ),
      ),
    );
  }
}
