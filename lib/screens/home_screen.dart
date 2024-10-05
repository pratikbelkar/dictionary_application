import 'package:dictionary_application/data/model/dictionary_model.dart';
import 'package:dictionary_application/data/services/service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<HomeScreen> {
  DictonaryModel? myDictonaryModel;
  bool isloading = false;
  String noDataFound = "Now you can Search";

  searchContain(String word) async {
    setState(() {
      isloading = true;
    });
    try {
      myDictonaryModel = await Apiservices.fetchData(word);
      setState(() {});
    } catch (e) {
      myDictonaryModel == null;
      noDataFound = "meaning can't be found";
      setState(() {});
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dictionary')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SearchBar(
              hintText: "search the word here",
              onSubmitted: (value) async {
                await searchContain(value);
              },
            ),
            const SizedBox(height: 10),
            if (isloading)
              const LinearProgressIndicator()
            else if (myDictonaryModel != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myDictonaryModel!.word,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 25),
                    ),
                    Text(myDictonaryModel!.phonetics.isNotEmpty
                        ? myDictonaryModel!.phonetics[0].text ?? ""
                        : ""),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: myDictonaryModel!.meanings.length,
                        itemBuilder: (context, index) {
                          return showMeaning(myDictonaryModel!.meanings[index]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              Center(
                child: Text(
                  noDataFound,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
          ],
        ),
      ),
    );
  }

  showMeaning(Meaning meaning) {
    String wordDefination = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefination += "\n${index + 1}.${element.definition}\n";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meaning.partOfSpeech,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue),
              ),
              const SizedBox(height: 10),
              const Text(
                'Definations:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              Text(
                wordDefination,
                style: const TextStyle(fontSize: 16, height: 1),
              ),
              wordRelation("synonyms", meaning.synonyms),
              wordRelation("Antonyms", meaning.antonyms),
            ],
          ),
        ),
      ),
    );
  }

  wordRelation(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
