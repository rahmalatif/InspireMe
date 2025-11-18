import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service/quote_service.dart';
import '../api_service/Quote.dart';
import '../core/Design/Bottom_Nav_Bar.dart';
import 'favourite.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? currentQuote;
  bool isFavorite = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkAndShowQuoteModePrompt();
      await loadLastQuote();
      await loadQuote();
      await getQuote();
    });
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning, Rahma';
    if (hour < 17) return 'Good Afternoon, Rahma';
    return 'Good Evening, Rahma';
  }

  Future<void> checkAndShowQuoteModePrompt() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool("seenQuoteModePrompt") ?? false;
    if (!seen) {
      showQuoteModeDialog();
      await prefs.setBool("seenQuoteModePrompt", true);
    }
  }

  void showQuoteModeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choose your quotes mode"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Daily Quote"),
              leading: const Icon(Icons.calendar_today),
              onTap: () {
                userQuoteChoice(true);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Many Per Day"),
              leading: const Icon(Icons.shuffle),
              onTap: () {
                userQuoteChoice(false);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> userQuoteChoice(bool isDaily) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDailyQuote", isDaily);
  }

  Future<void> loadLastQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final lastQuote = prefs.getString("lastQuote");
    if (lastQuote != null) {
      final favList = prefs.getStringList("favorites") ?? [];
      setState(() {
        currentQuote = lastQuote;
        isFavorite = favList.contains(lastQuote);
        isLoading = false;
      });
    }
  }

  Future<void> loadQuote({bool isRefresh = false}) async {
    await getQuote(isRefresh: isRefresh);
  }

  Future<void> getQuote({bool isRefresh = false}) async {
    setState(() {
      isLoading = true;
    });

    final quotes = await QuoteService().getQuote();

    if (quotes.isNotEmpty) {
      final randomQuote = quotes[Random().nextInt(quotes.length)];

      final prefs = await SharedPreferences.getInstance();
      final favList = prefs.getStringList("favorites") ?? [];

      setState(() {
        currentQuote = randomQuote.quote;
        isFavorite = favList.contains(randomQuote.quote);
        isLoading = false;
      });

      await prefs.setString("lastQuote", randomQuote.quote);
    } else {
      setState(() {
        currentQuote = "No quotes found.";
        isFavorite = false;
        isLoading = false;
      });
    }
  }

  Future<void> toggleFavorite(String quote) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> fav = prefs.getStringList("favorites") ?? [];

    setState(() {
      if (fav.contains(quote)) {
        fav.remove(quote);
        isFavorite = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Removed from favorites")),
        );
      } else {
        fav.add(quote);
        isFavorite = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Added to favorites!")),
        );
      }
    });

    await prefs.setStringList("favorites", fav);
  }

  @override
  Widget build(BuildContext context) {
    const Color cardBg = Colors.white;
    const Color iconColor = Colors.black87;
    const double cardWidth = 360;
    const double cardHeight = 240;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        title: Text(
          greeting(),
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w600),
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Stack(
        children: [
          // full background image
          Positioned.fill(
            child: Image.asset(
              "assets/JPG/background.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // subtle dark overlay so content pops
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.12)),
          ),

          // center card
          Center(
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: cardBg.withOpacity(0.92),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            currentQuote ?? "No quote available",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (currentQuote != null) {
                                            toggleFavorite(currentQuote!);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: isFavorite
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      IconButton(
                                        onPressed: () {
                                          getQuote(isRefresh: true);
                                        },
                                        icon: const Icon(Icons.refresh,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(width: 20),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.share,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ))),
                        ]),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
