import 'package:bla_refactor/ui/screens/rides_selection/view_model/ride_selection_view_model.dart';
import 'package:bla_refactor/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:bla_refactor/ui/screens/rides_selection/widgets/rides_selection_tile.dart';
import 'package:bla_refactor/ui/theme/theme.dart';
import 'package:flutter/material.dart';


class RideSelectionContent extends StatelessWidget {
  const RideSelectionContent({super.key, required this.rideSelectionViewModel});

  final RideSelectionViewModel rideSelectionViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: rideSelectionViewModel.selectedRidePreference,
              onBackPressed: () => rideSelectionViewModel.onBackTap(context),
              onFilterPressed: rideSelectionViewModel.onFilterPressed,
              onPreferencePressed: () => rideSelectionViewModel.onPreferencePressed(context, rideSelectionViewModel.selectedRidePreference),
            ),

            SizedBox(height: 100),

            Expanded(
              child: ListView.builder(
                itemCount: rideSelectionViewModel.matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: rideSelectionViewModel.matchingRides[index],
                  onPressed: () => rideSelectionViewModel.onRideSelected(rideSelectionViewModel.matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}