import 'package:flutter/material.dart';
import 'package:shlink_app/util/license.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceLicensesView extends StatefulWidget {
  const OpenSourceLicensesView({super.key});

  @override
  State<OpenSourceLicensesView> createState() => _OpenSourceLicensesViewState();
}

class _OpenSourceLicensesViewState extends State<OpenSourceLicensesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.medium(
              expandedHeight: 120,
              title: Text(
                "Open Source Licenses",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              final currentLicense = LicenseUtil.getLicenses()[index];
              return GestureDetector(
                onTap: () async {
                  if (currentLicense.repository != null) {
                    if (await canLaunchUrl(
                        Uri.parse(currentLicense.repository ?? ""))) {
                      launchUrl(Uri.parse(currentLicense.repository ?? ""),
                          mode: LaunchMode.externalApplication);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[100]
                          : Colors.grey[900],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentLicense.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("Version: ${currentLicense.version ?? "N/A"}",
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(currentLicense.license,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: LicenseUtil.getLicenses().length),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 20),
            child: Text(
              "Thank you to all maintainers of these repositories 💝",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ))
        ],
      ),
    );
  }
}
