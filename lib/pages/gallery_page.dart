import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/app_notifier.dart';
import '../widgets/image_card.dart';
import '../utils/constants.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<AppNotifier>(context);
    final isMobile = MediaQuery.of(context).size.width <= kMobileBreakpoint;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search for images',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      appNotifier.searchImages(query);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    appNotifier.searchImages(_searchController.text);
                  }
                },
                child: const Text('Search'),
              ),
            ],
          ),
        ),
        if (appNotifier.isSearchLoading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (appNotifier.searchError != null)
          Expanded(
            child: Center(
              child: Text(appNotifier.searchError!),
            ),
          )
        // This is the corrected line using the null-aware operator.
        // It checks if the list is null OR empty.
        else if (appNotifier.searchResults?.isEmpty ?? true)
            const Expanded(
              child: Center(child: Text('Enter a keyword to search for images.')),
            )
          else
            Expanded(
              child: isMobile
                  ? ListView.builder(
                // Safe access to length, defaults to 0 if null
                itemCount: appNotifier.searchResults!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: ImageCard(image: appNotifier.searchResults![index]),
                  );
                },
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double screenWidth = constraints.maxWidth;
                    final int crossAxisCount = (screenWidth / 250).floor();
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      // Safe access to length, defaults to 0 if null
                      itemCount: appNotifier.searchResults!.length,
                      itemBuilder: (context, index) {
                        return ImageCard(image: appNotifier.searchResults![index]);
                      },
                    );
                  },
                ),
              ),
            ),
      ],
    );
  }
}
