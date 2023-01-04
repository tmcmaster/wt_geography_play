import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wt_geography_play/apps/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_controller.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/widgets/found_dinosaur_list.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_info_panel.dart';

class FindDinosaursApp extends ConsumerWidget {
  const FindDinosaursApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(FindDinosaursController.provider);

    return WorldMapApp(
      appName: 'Find Dinosaurs',
      controller: controller,
      zoomControls: true,
      rightHeader: const [
        HoverCountry(),
      ],
      leftFooter: [
        FoundDinosaurList(
          controller: controller,
        ),
      ],
      infoPanels: [
        CollectedDinosaurs(
          controller: controller,
        ),
      ],
    );
  }
}

class CollectedDinosaurs extends ConsumerWidget {
  final FindDinosaursController controller;

  const CollectedDinosaurs({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);
    final collected = state.collected.toList();
    collected.sort((a, b) => a.compareTo(b));
    final dinosaurMap = ref.read(FindDinosaursController.dinosaurMap);
    return WorldMapAppInfoPanel(
      size: const Size(400, 400),
      title: 'Collected Dinosaurs',
      alignment: Alignment.centerRight,
      children: [
        Expanded(
          child: Container(
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: collected
                    .map((dinosaurName) => TextButton(
                          onPressed: () {
                            final dinosaur = dinosaurMap[dinosaurName];
                            if (dinosaur != null && dinosaur.link.isNotEmpty) {
                              launchUrl(Uri.parse(dinosaur.link));
                            }
                          },
                          child: Text(
                            dinosaurName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ))
                    .toList()),
          ),
        ),
      ],
    );
  }
}
