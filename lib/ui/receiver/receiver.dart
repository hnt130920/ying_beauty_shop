import 'package:flutter/material.dart';
import 'package:ying_beauty/model/receiver_info.dart';

class Receiver extends StatefulWidget {
  final ReceiverInfo receiver;
  final Function(ReceiverInfo receiver) onClick;
  final Function(ReceiverInfo receiver)? onDelete;
  Receiver({required this.receiver, required this.onClick, this.onDelete});

  @override
  State<Receiver> createState() => _ReceiverState();
}

class _ReceiverState extends State<Receiver> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const UnderlineTabIndicator(
              insets: EdgeInsets.all(0),
              borderSide: BorderSide(color: Color.fromARGB(255, 70, 150, 91))),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.receiver.name),
                    Text(widget.receiver.phone),
                    Text(widget.receiver.address),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: widget.onDelete == null
                    ? null
                    : () => widget.onDelete!(widget.receiver),
                child: const Text(
                  'Xóa',
                  style: TextStyle(color: Color.fromARGB(255, 70, 150, 91)),
                ),
              )
            ],
          )),
      onTap: () => widget.onClick(widget.receiver),
    );
  }
}
