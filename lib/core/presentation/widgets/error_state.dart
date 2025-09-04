import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String title;
  final Object error;
  const ErrorState({
    super.key,
    required this.title,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 42, color: Colors.white38),
            const SizedBox(height: 8),
            Text(title, style: t.titleMedium?.copyWith(color: Colors.white70)),
            const SizedBox(height: 6),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: t.bodySmall?.copyWith(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
