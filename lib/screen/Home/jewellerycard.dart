import 'package:flutter/material.dart';
import 'package:zariyajewllery/model/jewllerydata_model.dart';

class JewelleryCard extends StatelessWidget {
  final Datum item;

  const JewelleryCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                item.jewllImage,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              item.jewlleryname,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "${item.jewlleryprice}",
              style: const TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}