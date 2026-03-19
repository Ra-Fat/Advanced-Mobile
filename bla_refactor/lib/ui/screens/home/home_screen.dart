import 'package:bla_refactor/ui/screens/home/view_model/home_view_model.dart';
import 'package:bla_refactor/ui/screens/home/widgets/home_content.dart';
import 'package:bla_refactor/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final RidePreferenceState ridePreferenceState = context.watch<RidePreferenceState>();
    
    final HomeViewModel homeViewModel = HomeViewModel(ridePreferenceState: ridePreferenceState,);
    
    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
      child: HomeContent(homeViewModel: homeViewModel),
    );
  }
}