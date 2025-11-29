import 'package:flutter/material.dart';

import '../../../../../../core/common/widgets/custom_admin_textfied.dart';
import '../../controller/add_new_sop_controller.dart';
import 'dynamic_textfield_section.dart';
import 'dynamic_complex_section.dart';

class SopContentSection extends StatelessWidget {
  const SopContentSection({super.key, required this.controller});

  final AddNewSopController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffDFE1E6), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SOP Content',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  color: Color(0xff141617),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                child: Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Color(0xff333333),
                  ),
                ),
              ),
              CustomAdminTextField(
                controller: controller.overviewController,
                hintText: 'Enter detailed overview...',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Divider(color: Color(0xff12295E)),
              ),
              DynamicTextFieldSection(
                title: 'Indications',
                controllers: controller.indicationsControllers,
                hintText: 'Enter detailed indications...',
                onAdd: controller.addIndicationField,
                onRemove: controller.removeIndicationField,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Divider(color: Color(0xff12295E)),
              ),
              DynamicTextFieldSection(
                title: 'Contraindications',
                controllers: controller.contraindicationsControllers,
                hintText: 'Enter detailed contraindications...',
                onAdd: controller.addContraindicationField,
                onRemove: controller.removeContraindicationField,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Divider(color: Color(0xff12295E)),
              ),
              DynamicTextFieldSection(
                title: 'Required Equipment',
                controllers: controller.requiredEquipmentControllers,
                hintText: 'Enter detailed required equipment...',
                onAdd: controller.addRequiredEquipmentField,
                onRemove: controller.removeRequiredEquipmentField,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Divider(color: Color(0xff12295E)),
              ),
              DynamicComplexSection(
                title: 'Protocol Step',
                items: controller.protocolSteps,
                fieldLabels: ['Headline', 'Description', 'Duration'],
                fieldHints: [
                  'Enter headline...',
                  'Enter description...',
                  'Enter duration...',
                ],
                onAdd: controller.addProtocolStep,
                onRemove: controller.removeProtocolStep,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Divider(color: Color(0xff12295E)),
              ),
              DynamicComplexSection(
                title: 'Medication',
                items: controller.medications,
                fieldLabels: ['Headline', 'Dose', 'Route', 'Repeat'],
                fieldHints: [
                  'Enter headline...',
                  'Enter dose...',
                  'Enter route...',
                  'Enter repeat...',
                ],
                onAdd: controller.addMedication,
                onRemove: controller.removeMedication,
              ),

              SizedBox(height: 12),
              Text(
                'Use clear, numbered steps. Include safety warnings and contraindications.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                  color: Color(0xff141617),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
