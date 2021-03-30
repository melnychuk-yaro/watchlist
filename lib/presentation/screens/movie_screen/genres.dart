import 'package:flutter/material.dart';

class Genres extends StatelessWidget {
  final List<dynamic> genres;

  const Genres({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Chip(
              label: Text(genres[index]['name']),
            ),
          );
        },
      ),
    );
  }
}
