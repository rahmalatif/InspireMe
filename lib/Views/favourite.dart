import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inspireme/core/Design/app_Image.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  List<String> favorites = [];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList("favorites") ?? [];
    });
  }

  Future<void> removeFavorite(String quote) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites.remove(quote);
    });
    await prefs.setStringList("favorites", favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AppImage(
              "background.jpg",
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          favorites.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        "No favorites yet",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final quote = favorites[index];
                    return Card(
                      color: Colors.white.withOpacity(0.85),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        title: Text(
                          quote,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            removeFavorite(quote);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),

    );
  }
}
