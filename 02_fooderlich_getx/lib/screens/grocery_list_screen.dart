import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final GroceryManager manager;

  @override
  Widget build(BuildContext context) {
    // 1
    final groceryItems = manager.groceryItems;
// 2
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // 3
      child: ListView.separated(
        // 4
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          // 1
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50,
              ),
            ),
            child: InkWell(
              child: GroceryTile(
                  key: Key(item.id),
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  }),
              // 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      // 3
                      onUpdate: (item) {
                        // 4
                        manager.updateItem(item, index);
                        // 5
                        Navigator.pop(context);
                      },
                      // 6
                      onCreate: (item) {},
                      isUpdating: true,
                    ),
                  ),
                );
              },
            ),
          );
          // 5
        },
        // 8
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
