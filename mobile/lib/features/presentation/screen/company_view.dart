import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/domain/entity/company_entity.dart';
import 'package:commath/features/presentation/screen/company_problem_screen.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:flutter/material.dart';

class CompanyViewProfileScreen extends StatelessWidget {
  final CompanyEntity company;
  final bool showToProblem;
  const CompanyViewProfileScreen(
      {super.key, required this.company, this.showToProblem = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Instansi',
          style: title20,
        ),
      ),
      bottomNavigationBar: showToProblem
          ? BottomAppBar(
              padding: const EdgeInsets.all(20),
              child: AppCustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              CompanyProblemScreen(company: company)));
                },
                color: AppColor.primary,
                text: const Text("Lihat Permasalahan"),
              ),
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    company.cover,
                    width: MediaQuery.sizeOf(context).width,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Placeholder();
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 20,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.network(
                      company.profile,
                      width: 56,
                      height: 56,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(company.name, style: bold20),
                const SizedBox(height: 20),
                Text("Deskripsi Instansi", style: bold16),
                const SizedBox(height: 6),
                Text(
                  company.description,
                  style: regular14.copyWith(
                    color: AppColor.base,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
