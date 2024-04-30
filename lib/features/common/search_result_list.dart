import 'package:flutter/material.dart';

class SearchResultList extends StatefulWidget {
  const SearchResultList({super.key});

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
        itemBuilder: (context,index) => Text('xvjn')
    );
  }
}
