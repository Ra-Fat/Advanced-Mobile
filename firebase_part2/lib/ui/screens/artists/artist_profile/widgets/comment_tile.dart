import 'package:firebase_part2/model/comment/comment.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author name (optional)
          if (comment.authorName != null && comment.authorName!.isNotEmpty)
            Text(
              comment.authorName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

          if (comment.authorName != null) const SizedBox(height: 4),

          // Comment message
          Text(
            comment.message,
            style: const TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 6),

          // Date
          Text(
            _formatDate(comment.createdAt),
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}