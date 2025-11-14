import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodsplash/pages/chat_page.dart';

enum OrderStage {
  findCourier,
  courierToResto,
  restoPreparing,
  courierToAddress,
  finished,
}

class TrackOrderPage extends StatefulWidget {
  final String orderNo;
  final DateTime estimateArrive;

  TrackOrderPage({
    super.key,
    this.orderNo = 'A-748003BGWJEN',
    DateTime? estimateArrive,
  }) : estimateArrive = estimateArrive ?? Duration(minutes: 30).fromNow();

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  final _mapHeight = 320.0;

  final stages = OrderStage.values;
  int _currentIndex = 0;

  Timer? _timer;

  late final DateTime baseMinute;
  late final List<_TimelineItem> _timeline;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    baseMinute = DateTime(now.year, now.month, now.day, now.hour, 0);

    _timeline = [
      _TimelineItem('Mendapatkan Kurir Pesanan', baseMinute.add(const Duration(minutes: 0))),
      _TimelineItem('Kurir Menuju Resto',       baseMinute.add(const Duration(minutes: 10))),
      _TimelineItem('Resto Menyiapkan Pesanan', baseMinute.add(const Duration(minutes: 15))),
      _TimelineItem('Kurir Menuju Alamat',      baseMinute.add(const Duration(minutes: 20))),
      _TimelineItem('Pesanan Selesai',          baseMinute.add(const Duration(minutes: 30))),
    ];

    _timer = Timer.periodic(const Duration(seconds: 10), (t) {
      if (!mounted) return;
      if (_currentIndex < stages.length - 1) {
        setState(() => _currentIndex++);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _etaText(DateTime t) {
    final day = '13 November';
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '$day $hh.$mm';
  }

  int _macroStepIndex() {
    switch (stages[_currentIndex]) {
      case OrderStage.findCourier:
      case OrderStage.courierToResto:
        return 0;
      case OrderStage.restoPreparing:
      case OrderStage.courierToAddress:
        return 1;
      case OrderStage.finished:
        return 2;
    }
  }

  final _macroLabels = [
    'Pesanan Dibuat',
    'Dijemput Kurir',
    'Pesanan Sampai',
  ];

  String _macroLabel(int i) => _macroLabels[i];

  @override
  Widget build(BuildContext context) {
    final macroIndex = _macroStepIndex();
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          SizedBox(
            height: _mapHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/map.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 16 + statusBarHeight,
                  left: 16,
                  right: 16,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                          )
                        ],
                      ),
                      child: const Text('Your food arrives in 30 min'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: _roundIcon(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: _roundIcon(
                    icon: Icons.my_location,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimasi tiba : ${_etaText(widget.estimateArrive)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _Progress3Steps(activeIndex: macroIndex),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(3, (i) {
                            final active = i == macroIndex;
                            return SizedBox(
                              width: (MediaQuery.of(context).size.width - 16 * 2 - 16) / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _macroLabel(i),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: active ? Colors.blue : Colors.black.withOpacity(0.45),
                                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.schedule, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Garansi Tiba : Dapatkan Voucher Rp.10.000 jika pesanan belum tiba',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange.shade100,
                              child: const Icon(Icons.egg_outlined,
                                  color: Colors.orange),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('NO Pesanan',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(widget.orderNo,
                                      style: const TextStyle(
                                          color: Colors.black54)),
                                ],
                              ),
                            ),
                            _roundIcon(
                              icon: Icons.chat_bubble_outline_rounded,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ChatPage(peerName: '',)),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _Timeline(
                          items: _timeline,
                          activeCount: _currentIndex + 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundIcon({required IconData icon, VoidCallback? onTap}) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: Colors.black87),
        ),
      ),
    );
  }
}

class _Progress3Steps extends StatelessWidget {
  final int activeIndex;
  const _Progress3Steps({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final activeColor = Colors.lightBlue;
    final inactive = Colors.grey.shade300;

    Widget circle(IconData icon, bool on) => Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: on ? activeColor : inactive, width: 2),
          ),
          child: Icon(icon, color: on ? activeColor : inactive),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                const SizedBox(width: 30),
                Expanded(child: Container(height: 2, color: inactive)),
                const SizedBox(width: 30),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 30),
                Expanded(
                  child: Container(
                    height: 2,
                    color: activeIndex >= 1 ? activeColor : Colors.transparent,
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                circle(Icons.inventory_2_outlined, activeIndex >= 0),
                circle(Icons.two_wheeler_rounded, activeIndex >= 1),
                circle(Icons.check_circle, activeIndex >= 2),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _TimelineItem {
  final String label;
  final DateTime time;
  _TimelineItem(this.label, this.time);
}

class _Timeline extends StatelessWidget {
  final List<_TimelineItem> items;
  final int activeCount;

  const _Timeline({required this.items, required this.activeCount});

  String _timeText(DateTime t) {
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return 'Hari ini\n$hh.$mm';
  }

  @override
  Widget build(BuildContext context) {
    final primary = Colors.blue;
    final muted = Colors.black45;

    return Column(
      children: List.generate(items.length, (i) {
        final it = items[i];
        final reached = i < activeCount;
        final isLast = i == items.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              child: Text(
                _timeText(it.time),
                style: TextStyle(
                  fontSize: 12,
                  color: reached ? Colors.black87 : muted,
                ),
              ),
            ),
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: reached ? primary : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 40,
                      color: reached ? primary : Colors.grey.shade300,
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  it.label,
                  style: TextStyle(
                    fontSize: 14,
                    color: reached ? Colors.black87 : muted,
                    fontWeight: reached ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

extension on Duration {
  DateTime fromNow() => DateTime.now().add(this);
}