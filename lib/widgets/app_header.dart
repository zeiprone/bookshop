import 'package:flutter/material.dart';

/// Custom app header widget
class AppHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showCartButton;
  final int cartItemCount;
  final VoidCallback? onCartPressed;

  const AppHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.showCartButton = false,
    this.cartItemCount = 0,
    this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFAF7F0),
        border: Border(
          bottom: BorderSide(color: Color(0xFF1C1A17), width: 1.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        child: Row(
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: onBackPressed ?? () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF1C1A17),
                  size: 20,
                ),
              ),
            if (showBackButton) const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1C1A17),
                  fontFamily: 'serif',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            if (showCartButton)
              GestureDetector(
                onTap: onCartPressed,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF1C1A17),
                      size: 24,
                    ),
                    if (cartItemCount > 0)
                      Positioned(
                        right: -8,
                        top: -6,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF8A3324),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$cartItemCount',
                              style: const TextStyle(
                                color: Color(0xFFFAF7F0),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'sans-serif',
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
