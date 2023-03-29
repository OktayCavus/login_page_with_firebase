import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final title;
  const CustomAppBar({super.key, required this.title});

  // ! bu override kısmı çok önemli
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: title,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.message_outlined)),
      ],
    );
  }
}
