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

  @override
  void initState() {
    super.initState();

    dataFuture = fetchData();
  }


  Future<Map<String, dynamic>> fetchData() async {
    await checkPermission(); // 권한 확인을 기다림

    final position = await Geolocator.getCurrentPosition();


    final allMeetings =
    await GetIt.I<MeetingRepository>().fetchMeetingsStatically(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    const double maxDistanceInMeters = 3000.0;


    final filteredMeetings = allMeetings.where((meeting) {
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
      'meetings': filteredMeetings,
    };
  }

  Future<void> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw Exception('위치 서비스를 활성화해주세요.');
    }
    LocationPermission checkLocationPermission =
    await Geolocator.checkPermission();
    if (checkLocationPermission == LocationPermission.denied) {
      checkLocationPermission = await Geolocator.requestPermission();
    }
    if (checkLocationPermission != LocationPermission.always &&
        checkLocationPermission != LocationPermission.whileInUse) {
      throw Exception('위치 권한을 허가해 주세요.');
    }
  }


  void _goToMyLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition();
      _mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (e) {
      print('현재 위치를 가져오는 데 실패했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('모임 찾기 ',style: mediumText?.copyWith(fontSize: 20),),
      ),
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
          final meetings =
          snapshot.data!['meetings'] as List<MeetingListCardModel>;

          final initialCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 13.4,
          );

          final markers = meetings
              .map((meeting) => Marker(
            markerId: MarkerId(meeting.id),
            position: LatLng(meeting.latitude, meeting.longitude),
            infoWindow:
            InfoWindow(
                title: meeting.title,
                snippet: meeting.place
            ),
            onTap: ()async {
              await Future.delayed(Duration(milliseconds: 600));
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

          return SlidingUpPanel(
            controller: _panelController,
            color: const Color(0XFFFAFAFA),
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            minHeight: 120.0,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            panel: _buildPanelContent(meetings),
            body: Stack(
              children: [
                SafeArea(
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
                Positioned(
                  bottom: 250,
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
          );
        },
      ),
    );
  }

  Widget _buildPanelContent(List<MeetingListCardModel> meetings) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
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
          const SizedBox(height: 20),
          Text('내 주변 모임',
              style: mediumText?.copyWith(
                  fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          Expanded(
            child: meetings.isEmpty
                ? Center(child: Text('주변 3km 이내에 모임이 없습니다.'))
                : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: meetings.length,
              itemBuilder: (context, index) {
                final meeting = meetings[index];
                return _MeetingCard(meeting: meeting);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MeetingCard extends StatelessWidget {
  final MeetingListCardModel meeting;
  const _MeetingCard({required this.meeting, super.key});

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 140,
        child: GestureDetector(
          onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_) => MeetingDetailScreen(meetingId: meeting.id)));},
          child: Card(
              color: Colors.white,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Image.asset(
                    meeting.imagePath,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting.title,
                          style: mediumText?.copyWith(
                            fontWeight: FontWeight.w700,
                              fontSize: 19, color: const Color(0XFF6D7AC9)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('장소 : ${meeting.place}',
                            style: mediumText?.copyWith(color: Colors.grey)),
                        Text('시간 : ${meeting.time}', style: mediumText),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}