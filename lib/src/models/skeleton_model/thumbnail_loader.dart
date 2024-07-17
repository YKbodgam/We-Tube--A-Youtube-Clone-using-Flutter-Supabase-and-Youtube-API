import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

// Your existing widget goes here

class BuildSkeletonLoader extends StatelessWidget {
  final Size size;

  const BuildSkeletonLoader({
    super.key,
    required this.size,
  });

  Widget _buildTextPlaceholder(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.02,
      ),
      child: Card(
        elevation: 0, // Set the elevation to 0 to remove Card's default shadow
        color: Colors.grey[300]!.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18), // Adjust the border radius as needed
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextPlaceholder(
              double.infinity,
              size.height * 0.2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.03,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTextPlaceholder(40, 40),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTextPlaceholder(
                          double.infinity,
                          16,
                        ),
                        const SizedBox(height: 8),
                        _buildTextPlaceholder(
                          double.infinity,
                          12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  _buildTextPlaceholder(25, 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
