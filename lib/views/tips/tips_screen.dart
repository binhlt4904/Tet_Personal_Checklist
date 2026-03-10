import 'package:flutter/material.dart';
import '../../data/room/room_tip_data.dart';
import 'widgets/tips_header.dart';
import 'widgets/advice_card.dart';
import 'widgets/room_tip_card.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF6F4EDDD),
      body: SafeArea(
        child: Column(
          children: [
            const TipsHeader(),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AdviceCard(),
                    const SizedBox(height: 20),

                    /// Render nhiều room
                    ...roomTips.map(
                          (room) => RoomTipCard(room: room),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}