import 'package:flutter/material.dart';
import 'chat_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = <_ChatPreview>[
      _ChatPreview(
        name: 'Joko Susanto',
        last: 'Pesanan sedang disiapkan ya…',
        time: '19.46',
        unread: 1,
      ),
      _ChatPreview(
        name: 'Jamaludin',
        last: 'Pesanan sudah siap silahkan jem…',
        time: '08.46',
      ),
      _ChatPreview(
        name: 'Joko Suprianto',
        last: 'Jemput pesanan sekarang',
        time: '06.20',
      ),
      _ChatPreview(
        name: 'Abbel',
        last: 'Pesanan sudah siap',
        time: 'Yesterday',
      ),
      _ChatPreview(
        name: 'Satria Abbel',
        last: 'Jemput pesanan sekarang',
        time: 'Friday',
      ),
      _ChatPreview(
        name: 'Pangestu',
        last: 'Menu yang kamu pesan habis',
        time: '9/11/25',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: chats.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final c = chats[i];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(c.name.isNotEmpty ? c.name[0] : '?'),
                  ),
                  title: Text(
                    c.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    c.last,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(c.time, style: const TextStyle(color: Colors.white)),
                      if (c.unread > 0) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${c.unread}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(peerName: c.name),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatPreview {
  final String name;
  final String last;
  final String time;
  final int unread;
  _ChatPreview({
    required this.name,
    required this.last,
    required this.time,
    this.unread = 0,
  });
}