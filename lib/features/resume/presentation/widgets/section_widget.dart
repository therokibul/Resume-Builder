import 'package:flutter/material.dart';

class SectionWidget<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final VoidCallback onAdd;

  const SectionWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: onAdd,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: Text('No ${title.toLowerCase()} added yet.')),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    itemBuilder(context, items[index], index),
              ),
          ],
        ),
      ),
    );
  }
}
