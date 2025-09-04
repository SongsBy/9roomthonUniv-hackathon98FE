import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remind/model/meeting_list_card_model.dart';
import 'package:remind/repository/meeting_repository.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MeetingListscreen extends StatefulWidget {
  const MeetingListscreen({super.key});

  @override
  State<MeetingListscreen> createState() => _MeetingListscreenState();
}

class _MeetingListscreenState extends State<MeetingListscreen> {
  late final Future<List<MeetingListCardModel>> meetingsFuture;

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.339496586083, 126.73287520461),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();

    meetingsFuture = GetIt.I<MeetingRepository>().fetchMeetingsStatically();
  }


  Future<void> checkPermession() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: FutureBuilder(

        future: Future.wait([
          checkPermession(),
          meetingsFuture,
        ]),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }


          final meetings = snapshot.data![1] as List<MeetingListCardModel>;

          return SlidingUpPanel(
            color: const Color(0XFFFAFAFA),
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            minHeight: 250.0,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),

            panel: _buildPanelContent(meetings),
            body: SafeArea(
              child: GoogleMap(
                initialCameraPosition: initialCameraPosition,
              ),
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
              style:
              mediumText?.copyWith(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),


          Expanded(
            child: ListView.builder(
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
        child: Card(
            color: Colors.white,
            elevation: 12,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
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
                            fontSize: 19, color: const Color(0XFF6D7AC9)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('장소 : ${meeting.place}',
                          style: mediumText?.copyWith(color: Colors.grey)),
                      Text('시간 : ${meeting.time}',
                          style: mediumText),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}