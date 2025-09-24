import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/app_notifier.dart';
import '../widgets/image_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<AppNotifier>(context);
    final theme = Theme.of(context);

    if (appNotifier.isTrendingLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (appNotifier.trendingError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Failed to load images',
              style: theme.textTheme.headlineSmall?.copyWith(color: Colors.red),
            ),
            Text(appNotifier.trendingError ?? ''),
          ],
        ),
      );
    }
    if (appNotifier.trendingImages.isEmpty) {
      return const Center(
        child: Text('No trending images found.'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Trending Images',
              style: theme.textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double screenWidth = constraints.maxWidth;
                final int crossAxisCount = (screenWidth / 250).floor();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: appNotifier.trendingImages.length,
                  itemBuilder: (context, index) {
                    final image = appNotifier.trendingImages[index];
                    return ImageCard(image: image);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
