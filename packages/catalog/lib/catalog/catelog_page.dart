import 'package:catalog/catalog/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CatalogPageBody();
  }
}

class _CatalogPageBody extends StatefulWidget {
  const _CatalogPageBody({Key? key}) : super(key: key);

  @override
  State<_CatalogPageBody> createState() => _CatalogPageBodyState();
}

class _CatalogPageBodyState extends State<_CatalogPageBody> {
  int selectedIndex = 0;
  String searchQuery = '';
  List<String> get categories => widgetsByCategory.keys.toList();
  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories[selectedIndex];
    final widgets = widgetsByCategory[selectedCategory] ?? [];
    final filteredWidgets = searchQuery.isEmpty
        ? widgets
        : widgets.where((meta) {
            String label = meta.name;
            final w = meta.widget;
            if (label.isEmpty) {
              if (w is ElevatedButton ||
                  w is OutlinedButton ||
                  w is TextButton) {
                final child = (w as dynamic).child;
                if (child is Text) label = child.data ?? '';
              } else if (w is FloatingActionButton) {
                label = 'FloatingActionButton';
              } else if (w is ListTile) {
                if (w.title is Text) label = (w.title as Text).data ?? '';
              } else if (w is Card) {
                if (w.child is Padding && (w.child as Padding).child is Text) {
                  label = ((w.child as Padding).child as Text).data ?? '';
                } else if (w.child is ListTile &&
                    ((w.child as ListTile).title is Text)) {
                  label = ((w.child as ListTile).title as Text).data ?? '';
                }
              } else if (w is TextField) {
                label = w.decoration?.labelText ?? '';
              } else if (w is Image) {
                label = w.semanticLabel ?? '';
              }
            }
            return label.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppbar(),
        body: Row(
          children: [
            // Sidebar
            buildSidebar(),
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    buildSearchbar(),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Icon(
                          _categoryIcon(selectedCategory),
                          color: Colors.deepPurple,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          selectedCategory,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: filteredWidgets.isEmpty
                          ? Center(
                              child: Text(
                                'No widgets found.',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : buildGridView(filteredWidgets),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView buildGridView(List<WidgetMeta> filteredWidgets) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 28,
        crossAxisSpacing: 28,
        childAspectRatio: 1.2,
      ),
      itemCount: filteredWidgets.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          shadowColor: Colors.deepPurple.withOpacity(0.10),
          child: Container(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(child: Center(child: filteredWidgets[index].widget)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        filteredWidgets[index].installCommand,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        tooltip: 'Copy',
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: filteredWidgets[index].installCommand,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Copied "${filteredWidgets[index].installCommand}"',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildSearchbar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.07),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search widgets...',
          prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }

  Container buildSidebar() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 16,
            offset: Offset(2, 0),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 32, 0, 16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(height: 2),
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.deepPurple[100]
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.08),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: ListTile(
                    leading: Icon(
                      _categoryIcon(categories[index]),
                      color: isSelected ? Colors.deepPurple : Colors.grey[600],
                    ),
                    title: Text(
                      categories[index],
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Colors.deepPurple : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        searchQuery = '';
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text(
        'Widget Catalog',
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
      backgroundColor: Colors.deepPurple,
      elevation: 6,
      shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
    );
  }
}

IconData _categoryIcon(String category) {
  switch (category) {
    case 'Buttons':
      return Icons.radio_button_checked;
    case 'TextFields':
      return Icons.text_fields;
    case 'Cards':
      return Icons.credit_card;
    case 'Lists':
      return Icons.list;
    case 'Dialogs':
      return Icons.chat_bubble_outline;
    case 'Images':
      return Icons.image;
    case 'Sliders':
      return Icons.tune;
    case 'Switches':
      return Icons.toggle_on;
    default:
      return Icons.widgets;
  }
}
