import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String peerName;
  const ChatPage({super.key, required this.peerName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();

  // dummy messages
  final List<_Msg> _messages = [
    _Msg('Permisi, pesanannya sudah sesuai apa tidak ya?', false),
    _Msg('Sudah ya', true),
    _Msg('Pesanan sedang disiapkan ya, mohon ditunggu 🙏', false),
  ];

  void _send() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;
    setState(() {
      _messages.add(_Msg(txt, true));
      _controller.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 12),
            Text(
              widget.peerName,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const _DaySeparator(label: 'TODAY'),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return _ChatBubble(text: m.text, isMe: m.isMe);
              },
            ),
          ),
          _InputBar(controller: _controller, onSend: _send),
          SafeArea(top: false, child: Container()),
        ],
      ),
    );
  }
}

class _Msg {
  final String text;
  final bool isMe;
  _Msg(this.text, this.isMe);
}

class _DaySeparator extends StatelessWidget {
  final String label;
  const _DaySeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  const _ChatBubble({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? Colors.lightBlue : Colors.grey.shade200;
    final textColor = isMe ? Colors.white : Colors.black87;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(isMe ? 64 : 8, 4, isMe ? 8 : 64, 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: Text(text, style: TextStyle(color: textColor, fontSize: 15)),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const _InputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 6,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Type a message',
                prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.camera_alt_outlined),
                    SizedBox(width: 8),
                    Icon(Icons.mic_none),
                    SizedBox(width: 8),
                  ],
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton.small(
            onPressed: onSend,
            child: const Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }
}