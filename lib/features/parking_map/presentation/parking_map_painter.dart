import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../domain/parking_slot.dart';
import '../../../core/theme/app_theme.dart';

class ParkingMapPainter extends CustomPainter {
  final List<ParkingSlot> slots;
  final ParkingSlot? selectedSlot;
  final bool isEditMode;
  final double gridSnapSize;

  ParkingMapPainter({
    required this.slots,
    this.selectedSlot,
    required this.isEditMode,
    this.gridSnapSize = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = AppTheme.background;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    // Draw grid if in edit mode
    if (isEditMode) {
      _drawGrid(canvas, size);
    }

    // Draw lanes/street labels
    _drawStreetDecorations(canvas, size);

    // Draw all slots
    for (final slot in slots) {
      _drawSlot(canvas, slot);
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF1E293B).withOpacity(0.4)
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += gridSnapSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSnapSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawStreetDecorations(Canvas canvas, Size size) {
    final streetPaint = Paint()
      ..color = const Color(0xFF334155).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // A central lane drive path
    canvas.drawRect(
      Rect.fromLTWH(50, size.height / 2 - 40, size.width - 100, 80),
      streetPaint,
    );

    // Draw dashed lane markings
    final lanePaint = Paint()
      ..color = const Color(0xFF64748B).withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 15, dashSpace = 15, startX = 60;
    while (startX < size.width - 60) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        lanePaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  void _drawSlot(Canvas canvas, ParkingSlot slot) {
    final isSelected = selectedSlot?.id == slot.id;

    canvas.save();
    // Translate to slot center
    canvas.translate(slot.x + slot.width / 2, slot.y + slot.height / 2);
    canvas.rotate(slot.rotation);

    // Color based on status
    Color statusColor;
    switch (slot.status) {
      case SlotStatus.available:
        statusColor = AppTheme.available;
      case SlotStatus.occupied:
        statusColor = AppTheme.occupied;
      case SlotStatus.reserved:
        statusColor = AppTheme.reserved;
    }

    // Outer border
    final borderPaint = Paint()
      ..color = isSelected 
          ? AppTheme.primary 
          : statusColor.withOpacity(0.8)
      ..strokeWidth = isSelected ? 3.0 : 1.5
      ..style = PaintingStyle.stroke;

    // Translucent fill
    final fillPaint = Paint()
      ..color = isSelected 
          ? AppTheme.primary.withOpacity(0.15) 
          : statusColor.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: slot.width, height: slot.height),
      const Radius.circular(8.0),
    );

    // 1. Draw Fill
    canvas.drawRRect(rrect, fillPaint);
    
    // 2. Draw Stroke
    canvas.drawRRect(rrect, borderPaint);

    // 3. Draw Type Indicator (Disabled / Standard / Large)
    if (slot.type == SlotType.disabled) {
      _drawDisabledIcon(canvas, slot.width, slot.height, statusColor);
    } else if (slot.status == SlotStatus.occupied) {
      _drawCarSilhouette(canvas, slot.width, slot.height, statusColor);
    }

    // 4. Draw selection indicator in edit mode
    if (isEditMode && isSelected) {
      final cornerPaint = Paint()
        ..color = AppTheme.accent
        ..style = PaintingStyle.fill;

      // Draw resizing handles in the corners
      const double hSize = 6.0;
      canvas.drawCircle(Offset(-slot.width / 2, -slot.height / 2), hSize, cornerPaint);
      canvas.drawCircle(Offset(slot.width / 2, -slot.height / 2), hSize, cornerPaint);
      canvas.drawCircle(Offset(-slot.width / 2, slot.height / 2), hSize, cornerPaint);
      canvas.drawCircle(Offset(slot.width / 2, slot.height / 2), hSize, cornerPaint);
    }

    // 5. Draw text label
    _drawLabelText(canvas, slot.label, slot.width, slot.height, isSelected);

    canvas.restore();
  }

  void _drawLabelText(Canvas canvas, String label, double width, double height, bool isSelected) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: isSelected ? AppTheme.textPrimary : const Color(0xFFE2E8F0),
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          shadows: const [
            Shadow(
              color: Colors.black54,
              offset: Offset(1, 1),
              blurRadius: 2.0,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      minWidth: 0,
      maxWidth: width,
    );

    // Place text at the top edge of the slot inside
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -height / 2 + 6),
    );
  }

  void _drawDisabledIcon(Canvas canvas, double width, double height, Color color) {
    // Draws a simplistic wheelchair/accessible icon inside the slot
    final iconPaint = Paint()
      ..color = color.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Wheel circle
    canvas.drawCircle(Offset(0, height / 8), height / 6, iconPaint);
    // Back, head, lap lines
    canvas.drawLine(Offset(-width / 12, -height / 8), Offset(-width / 12, height / 12), iconPaint);
    canvas.drawCircle(Offset(-width / 12, -height / 5), 2.5, iconPaint..style = PaintingStyle.fill);
  }

  void _drawCarSilhouette(Canvas canvas, double width, double height, Color color) {
    // Draws a highly stylized car silhouette from top view
    final carPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final carRect = Rect.fromCenter(
      center: Offset(0, height / 12),
      width: width * 0.55,
      height: height * 0.50,
    );

    // Draw main body
    canvas.drawRRect(
      RRect.fromRectAndRadius(carRect, const Radius.circular(6.0)),
      carPaint,
    );

    // Draw simple windshield
    final windshieldPaint = Paint()
      ..color = AppTheme.background.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(-width * 0.2, -height * 0.05, width * 0.4, height * 0.08),
      windshieldPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ParkingMapPainter oldDelegate) {
    return oldDelegate.slots != slots ||
        oldDelegate.selectedSlot != selectedSlot ||
        oldDelegate.isEditMode != isEditMode ||
        oldDelegate.gridSnapSize != gridSnapSize;
  }
}
