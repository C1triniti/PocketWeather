import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearchPressed;
  const LocationHeader({super.key, required this.controller,required this.onSearchPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.sizeOf(context).width * 0.60,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Digite sua Cidade",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onSearchPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.deepPurpleAccent,
              elevation: 0,
            ),
            child: const Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
