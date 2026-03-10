import 'package:flutter/material.dart';

import '../../../domain/entities/room_tip_model.dart';

class RoomTipCard extends StatefulWidget {
  final RoomTipModel room;

  const RoomTipCard({
    super.key,
    required this.room,
  });

  @override
  State<RoomTipCard> createState() =>
      _RoomTipCardState();
}

class _RoomTipCardState
    extends State<RoomTipCard> {
  bool isExpanded = false;

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case "kitchen":
        return Icons.restaurant;
      case "bed":
        return Icons.bed;
      case "wc":
        return Icons.wc;
      case "temple_buddhist":
        return Icons.temple_buddhist;
      case "balcony":
        return Icons.balcony;
      case "tip":
        return Icons.lightbulb;
      default:
        return Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child: Icon(
                  _getIcon(room.icon),
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    Text(
                      room.description,
                      style: const TextStyle(
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded =
                    !isExpanded;
                  });
                },
                icon: Icon(isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              )
            ],
          ),

          if (isExpanded) ...[
            const SizedBox(height: 20),

            /// TIME
            Container(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.orange),
              ),
              child: Text(
                "⏰ Thời gian: ${room.time}",
              ),
            ),

            const SizedBox(height: 20),

            /// STEPS
            const Align(
              alignment:
              Alignment.centerLeft,
              child: Text(
                "Các bước thực hiện:",
                style: TextStyle(
                    fontWeight:
                    FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            ...room.steps.asMap().entries.map(
                  (entry) => Padding(
                padding:
                const EdgeInsets.only(
                    bottom: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor:
                      Colors.red.shade100,
                      child: Text(
                        "${entry.key + 1}",
                        style:
                        const TextStyle(
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                        width: 12),
                    Expanded(
                        child:
                        Text(entry.value)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// TOOLS
            Container(
              padding:
              const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                const Color(0xFFE9EEF6),
                borderRadius:
                BorderRadius.circular(
                    20),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: room.tools
                    .map(
                      (tool) =>
                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                            horizontal:
                            12,
                            vertical:
                            6),
                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius
                              .circular(
                              20),
                          border: Border.all(
                              color: Colors
                                  .blue),
                        ),
                        child: Text(tool),
                      ),
                )
                    .toList(),
              ),
            )
          ]
        ],
      ),
    );
  }
}