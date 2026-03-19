import 'package:bla_refactor/data/repositories/ride/ride_repository.dart';
import 'package:bla_refactor/ui/screens/rides_selection/view_model/ride_selection_view_model.dart';
import 'package:bla_refactor/ui/screens/rides_selection/widgets/ride_selection_content.dart';
import 'package:bla_refactor/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RidesSelectionScreen extends StatelessWidget {
  const RidesSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RideSelectionViewModel(
        ridepreferencesState: context.read<RidePreferenceState>(),
        rideRepository: context.read<RideRepository>(),
      ),
      
      child: Builder(
        builder: (context) {
          final rideSelectionViewModel = context.watch<RideSelectionViewModel>();
          return RideSelectionContent(rideSelectionViewModel: rideSelectionViewModel);
        },
      ),
    );
  }
}