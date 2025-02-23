import 'package:care_bridge/res/color.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? selectedMood;
  List<Map<String, String>> songRecommendations = [];
  List<String> bookRecommendations = [];
  String? currentSongUrl;
  bool isPlaying = false;

  // Mood Data with Song URLs (Replace URLs with actual links)
  final Map<String, Map<String, dynamic>> moodRecommendations = {
    "Happy": {
      "Songs": [
        {"title": "Happy - Pharrell Williams", "url": "https://on.soundcloud.com/Kkk8r1ju1zfbCrWn7"},
        {"title": "Can't Stop The Feeling! - Justin Timberlake", "url": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"},
      ],
      "Books": ["The Happiness Project - Gretchen Rubin", "The Alchemist - Paulo Coelho"]
    },
    "Sad": {
      "Songs": [
        {"title": "Someone Like You - Adele", "url": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"},
        {"title": "Fix You - Coldplay", "url": "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3"},
      ],
      "Books": ["Reasons to Stay Alive - Matt Haig", "The Fault in Our Stars - John Green"]
    },
  };

  // Update recommendations based on mood selection
  void updateRecommendations(String mood) {
    setState(() {
      selectedMood = mood;
      songRecommendations = List<Map<String, String>>.from(moodRecommendations[mood]?["Songs"] ?? []);
      bookRecommendations = List<String>.from(moodRecommendations[mood]?["Books"] ?? []);
    });
  }

  // Play selected song
  void playSong(String url) async {
    if (currentSongUrl == url && isPlaying) {
      await _audioPlayer.pause();
      setState(() => isPlaying = false);
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        currentSongUrl = url;
        isPlaying = true;
      });
    }
  }

  // Stop song
  void stopSong() async {
    await _audioPlayer.stop();
    setState(() => isPlaying = false);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text("Mood Recommendations", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Your Mood:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Mood Selection Buttons
            Wrap(
              spacing: 10,
              children: moodRecommendations.keys.map((mood) {
                return ChoiceChip(
                  label: Text(mood),
                  selected: selectedMood == mood,
                  selectedColor: AppColors.selectedItem,
                  labelStyle: TextStyle(color: selectedMood == mood ? Colors.white : Colors.black),
                  onSelected: (bool selected) {
                    if (selected) updateRecommendations(mood);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Recommendations Section
            if (selectedMood != null) ...[
              const Text("Recommended Songs 🎵", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Songs List with Play/Pause/Stop Buttons
              Expanded(
                child: ListView.builder(
                  itemCount: songRecommendations.length,
                  itemBuilder: (context, index) {
                    final song = songRecommendations[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.music_note, color: AppColors.mainColor),
                        title: Text(song["title"] ?? ""),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                currentSongUrl == song["url"] && isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.green,
                              ),
                              onPressed: () => playSong(song["url"]!),
                            ),
                            IconButton(
                              icon: const Icon(Icons.stop, color: Colors.red),
                              onPressed: stopSong,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),
              const Text("Recommended Books 📚", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Books List
              Expanded(
                child: ListView.builder(
                  itemCount: bookRecommendations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.book, color: AppColors.mainColor),
                        title: Text(bookRecommendations[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
