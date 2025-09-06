// lib/screen/meeting_ListScreen.dart
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remind/model/meeting_list_card_model.dart';
import 'package:remind/repository/meeting_repository.dart';
import 'package:remind/screen/meeting_detailScreen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MeetingListscreen extends StatefulWidget {
  const MeetingListscreen({super.key});

  @override
  State<MeetingListscreen> createState() => _MeetingListscreenState();
}

class _MeetingListscreenState extends State<MeetingListscreen> {
  late final Future<Map<String, dynamic>> dataFuture;
  late GoogleMapController _mapController;
  final PanelController _panelController = PanelController();


  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  double _panelPos = 0.0;

  @override
  void initState() {
    super.initState();
    dataFuture = fetchData();
    _searchCtrl.addListener(() {
      setState(() {
        _query = _searchCtrl.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchData() async {
    await checkPermission();
    final position = await Geolocator.getCurrentPosition();

    final allMeetings = await GetIt.I<MeetingRepository>().fetchMeetingsStatically(
      latitude: position.latitude,
      longitude: position.longitude,
    );


    const double maxDistanceInMeters = 3000.0;
    final filteredByRadius = allMeetings.where((meeting) {
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        meeting.latitude,
        meeting.longitude,
      );
      return distance <= maxDistanceInMeters;
    }).toList();

    return {
      'position': position,
      'meetings': filteredByRadius,
    };
  }

  Future<void> checkPermission() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception('위치 서비스를 활성화해주세요.');
    }
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm != LocationPermission.always && perm != LocationPermission.whileInUse) {
      throw Exception('위치 권한을 허가해 주세요.');
    }
  }

  void _goToMyLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      _mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (e) {

      print('현재 위치를 가져오는 데 실패했습니다: $e');
    }
  }

  List<MeetingListCardModel> _applySearch(List<MeetingListCardModel> meetings) {
    if (_query.isEmpty) return meetings;
    final q = _query.toLowerCase();
    return meetings.where((m) {
      final t = m.title.toLowerCase();
      final p = m.place.toLowerCase();
      return t.contains(q) || p.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    final double mapScale = 1.0 - 0.06 * _panelPos;
    final double mapTranslateY = -24.0 * _panelPos;


    final double fabBottomStart = 140.0;
    final double fabBottomEndExtra = 220.0;
    final double fabBottom = lerpDouble(
      fabBottomStart,
      fabBottomStart + fabBottomEndExtra,
      _panelPos.clamp(0.0, 0.5) / 0.5,
    )!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final position = snapshot.data!['position'] as Position;
          final meetings = snapshot.data!['meetings'] as List<MeetingListCardModel>;


          final searched = _applySearch(meetings);

          final initialCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 13.7,
          );


          final markers = searched
              .map(
                (meeting) => Marker(
              markerId: MarkerId(meeting.id),
              position: LatLng(meeting.latitude, meeting.longitude),
              infoWindow: InfoWindow(title: meeting.title, snippet: meeting.place),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 300));
                if (_panelController.isAttached) {
                  _panelController.open();
                }
              },
            ),
          )
              .toSet();

          final circles = {
            Circle(
              circleId: const CircleId('3km_radius'),
              center: LatLng(position.latitude, position.longitude),
              radius: 3000,
              fillColor: Colors.blue.withOpacity(0.1),
              strokeColor: Colors.blue,
              strokeWidth: 1,
            )
          };

          final double panelMaxHeight = size.height * 0.8;

          return SlidingUpPanel(
            controller: _panelController,
            color: const Color(0XFFFAFAFA),
            maxHeight: panelMaxHeight,
            minHeight: 120.0,
            panelSnapping: true,
            snapPoint: 0.5,
            parallaxEnabled: true,
            parallaxOffset: .18,


            panel: _buildPanelContent(searched),


            body: Stack(
              children: [

                Transform.translate(
                  offset: Offset(0, mapTranslateY),
                  child: Transform.scale(
                    scale: mapScale,
                    child: GoogleMap(
                      initialCameraPosition: initialCameraPosition,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                      markers: markers,
                      circles: circles,
                    ),
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Row(
                      children: [
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 2,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => Navigator.pop(context),
                            child: const SizedBox(
                              width: 44,
                              height: 44,
                              child: Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        Expanded(
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 12),
                                  const Icon(Icons.search, color: Colors.black54),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchCtrl,
                                      textInputAction: TextInputAction.search,
                                      decoration: const InputDecoration(
                                        hintText: '제목 또는 장소로 검색',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  if (_query.isNotEmpty)
                                    IconButton(
                                      icon: const Icon(Icons.close, size: 18),
                                      color: Colors.black54,
                                      onPressed: () {
                                        _searchCtrl.clear();
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeOut,
                  bottom: fabBottom,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    onPressed: _goToMyLocation,
                    child: const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),


            onPanelSlide: (pos) {
              setState(() {
                _panelPos = pos;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildPanelContent(List<MeetingListCardModel> meetings) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '내 주변 모임',
            style: textTheme.titleMedium?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: meetings.isEmpty
                ? const Center(child: Text('조건에 맞는 모임이 없습니다.'))
                : ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: meetings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final m = meetings[index];
                return MeetingCardPro(
                  m: m,
                  favorite: index.isEven,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MeetingDetailScreen(meetingId: m.id),
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

/// 리디자인 카드 위젯
class MeetingCardPro extends StatelessWidget {
  final MeetingListCardModel m;
  final VoidCallback onTap;
  final bool favorite;
  const MeetingCardPro({
    super.key,
    required this.m,
    required this.onTap,
    this.favorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF7F5FF), Color(0xFFFDFDFF)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6D7AC9).withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 썸네일
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  m.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          m.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF5660C8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          favorite ? Icons.favorite : Icons.favorite_border,
                          color: favorite ? const Color(0xFFE25A7B) : Colors.black38,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),


                  _MetaRow(icon: Icons.place_rounded, text: m.place),
                  const SizedBox(height: 2),


                  _MetaRow(icon: Icons.access_time_rounded, text: m.time),

                  const SizedBox(height: 10),


                  Row(
                    children: [
                      const _Chip(text: '거리 ~3km', icon: Icons.near_me_outlined),
                      const SizedBox(width: 6),
                      const Spacer(),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF6D7AC9), width: 1.3),
                          foregroundColor: const Color(0xFF6D7AC9),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onTap,
                        child: const Text('자세히 보기'),
                      ),
                    ],
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

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.black87,
      height: 1.2,
    );
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black45),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style,
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final IconData icon;
  const _Chip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7FB)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: const Color(0xFF6D7AC9)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF4E56B9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}