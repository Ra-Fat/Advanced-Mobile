import 'package:bla_refactor/model/ride_pref/ride_pref.dart';
import 'package:bla_refactor/ui/screens/home/view_model/home_view_model.dart';
import 'package:bla_refactor/ui/screens/home/widgets/home_history_tile.dart';
import 'package:bla_refactor/ui/screens/rides_selection/rides_selection_screen.dart';
import 'package:bla_refactor/ui/theme/theme.dart';
import 'package:bla_refactor/ui/widgets/pickers/bla_ride_preference_picker.dart';
import 'package:bla_refactor/utils/animations_util.dart';
import 'package:flutter/material.dart';


  const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class HomeContent extends StatelessWidget {
  final HomeViewModel homeViewModel;
  const HomeContent({super.key, required this.homeViewModel});

  void onRidePrefSelected( BuildContext context, HomeViewModel homeViewModel, RidePreference selectedPreference,) async {
    homeViewModel.setRidePreference(selectedPreference);
    await Navigator.of(context,).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildBackground(), _buildForeground(context, homeViewModel)],
    );
  }

  Widget _buildForeground(BuildContext context, HomeViewModel homeViewModel) {
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: homeViewModel.currentRidePreference,
                onRidePreferenceSelected: (pref) =>
                    onRidePrefSelected(context, homeViewModel, pref),
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(context, homeViewModel),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(BuildContext context, HomeViewModel homeViewModel) {
    // Reverse the history of preferences
    final history = homeViewModel.history;
    return SizedBox(
      height: 200, // Set a fixed height
      child: ListView.builder(
        shrinkWrap: true, // Fix ListView height issue
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () =>
              onRidePrefSelected(context, homeViewModel, history[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}