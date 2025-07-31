import 'package:flutter/material.dart';
import 'package:masjid_community_29_06_25/models/leaders_profile_model.dart';
import 'package:masjid_community_29_06_25/utils/resources/colors_res.dart';
import 'package:masjid_community_29_06_25/utils/resources/images.dart';

class LeadersCardWidget extends StatelessWidget {
  final LeadersProfile model;
  const LeadersCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: ColorResTheme.cardBgColo(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorResTheme.shadowColor(),
            blurRadius: 2,
            offset: const Offset(0, 1),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              model.image.toString(),
              width: 100,
              height: 125,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Verified
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        model.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorResTheme.textColor(),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Image.asset(
                      Images.verifyTick,
                      height: 18,
                      width: 18,
                    ),
                  ],
                ),
                // Position
                Text(
                  model.position ?? '',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ColorResTheme.subTitleTextColor(),
                  ),
                ),
                const SizedBox(height: 6),
                Divider(color: ColorResTheme.premiumDividerColor(), height: 0, thickness: 0.4),
                SizedBox(height: 5),
                // About
                Text(
                  model.about ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorResTheme.miniTextColor(),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

