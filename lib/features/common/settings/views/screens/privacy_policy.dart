import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyStyle = getTsRegularText(
      fontSize: 13,
      lineHeight: AppSizes.lineHeight1_6,
      color: const Color(0xFF172B4D),
    );
    final TextStyle headingStyle = getTsSectionTitle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      lineHeight: AppSizes.lineHeight1_4,
      color: const Color(0xFF141617),
    );
    final TextStyle subHeadingStyle = getTsSubTitle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      lineHeight: AppSizes.lineHeight1_4,
      color: const Color(0xFF12295E),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBarHelper.backWithAvatar(
        title: 'Privacy Policy',
        showConnectionStatus: true,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.szW24,
          vertical: AppSizes.szH20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DermaInstitute is a clinical training and protocol management platform designed for administrators and trainees. We take the stewardship of sensitive medical and personal information seriously. This Privacy Policy explains what data we collect, how we use and share it, and the choices you have.',
              style: bodyStyle,
            ),
            _buildSection(
              title: '1. Information We Collect',
              headingStyle: headingStyle,
              children: [
                Text(
                  'We collect information that you provide directly, information that is generated through your use of the app, and limited data from integrated services.',
                  style: bodyStyle,
                ),
                SizedBox(height: AppSizes.szH12),
                Text('Account & Profile Data', style: subHeadingStyle),
                SizedBox(height: AppSizes.szH8),
                _buildBullet(
                  bodyStyle,
                  'Name, email address, phone number, role (e.g., Admin or Trainee), jurisdiction, specialization, and other professional metadata supplied during signup or profile updates.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Authentication credentials are transmitted to the DermaInstitute API; only access tokens are stored locally using SharedPreferences and GetStorage.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Profile photos or other images you choose to upload through the camera or photo library (powered by image_picker).',
                ),
                SizedBox(height: AppSizes.szH12),
                Text('Operational & Content Data', style: subHeadingStyle),
                SizedBox(height: AppSizes.szH8),
                _buildBullet(
                  bodyStyle,
                  'Standard Operating Procedures (SOPs), protocol steps, medication lists, and related metadata entered through the admin workflow.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Incident and clinical reports, including patient age, sex, severity assessments, incident descriptions, actions taken, outcomes, and lessons learned. Drafts of reports and SOPs may be stored locally using GetStorage and Hive adapters until you submit or delete them.',
                ),
                _buildBullet(
                  bodyStyle,
                  'AI triage conversations and prompts shared with the DermaInstitute AI endpoint (aibaseUrl) when you opt into decision-support tools.',
                ),
                SizedBox(height: AppSizes.szH12),
                Text('Device & Usage Data', style: subHeadingStyle),
                SizedBox(height: AppSizes.szH8),
                _buildBullet(
                  bodyStyle,
                  'Firebase Cloud Messaging (FCM) device tokens and local notification identifiers used to deliver push notifications and in-app alerts.',
                ),
                _buildBullet(
                  bodyStyle,
                  'App version, build number, storage usage, and basic connectivity status (via connectivity_plus) collected to support troubleshooting and optimization.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Diagnostic logs produced by the logger package for error tracking and quality assurance. Logs avoid storing clinical content where possible.',
                ),
              ],
            ),
            _buildSection(
              title: '2. How We Use Your Information',
              headingStyle: headingStyle,
              children: [
                _buildBullet(
                  bodyStyle,
                  'Authenticate users, maintain secure sessions, and enforce role-based access within the platform.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Provision and synchronize SOP libraries, emergency protocols, and clinical calculators across admin and trainee flows.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Store draft reports and SOPs locally so you can work offline and resume later. Drafts remain on-device unless you submit them to the server.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Generate, send, and manage push notifications for account changes, protocol updates, emergencies, and reminders.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Improve reliability, debug issues, and measure feature adoption using de-identified usage insights.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Support AI-assisted triage and guidance when you intentionally share scenario details with the DermaInstitute AI service.',
                ),
              ],
            ),
            _buildSection(
              title: '3. Legal Bases for Processing',
              headingStyle: headingStyle,
              children: [
                Text(
                  'We process personal information on the following legal bases (depending on your jurisdiction):',
                  style: bodyStyle,
                ),
                SizedBox(height: AppSizes.szH8),
                _buildBullet(
                  bodyStyle,
                  'Contractual necessity to deliver the services you access through your user account.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Legitimate interests in maintaining platform security, ensuring clinical quality, and improving functionality.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Compliance with legal obligations related to medical record keeping or audit trails, when applicable.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Your consent for optional features such as AI triage, marketing communications, or local data exports.',
                ),
              ],
            ),
            _buildSection(
              title: '4. How We Share Information',
              headingStyle: headingStyle,
              children: [
                Text(
                  'We share data only when necessary to operate the platform or meet legal requirements. We do not sell personal information.',
                  style: bodyStyle,
                ),
                SizedBox(height: AppSizes.szH8),
                _buildBullet(
                  bodyStyle,
                  'DermaInstitute backend services hosted on Render.com receive authentication requests, SOP content, reports, and related metadata.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Firebase (Google LLC) processes push notification tokens and delivers in-app notifications.',
                ),
                _buildBullet(
                  bodyStyle,
                  'AI decision-support endpoints (currently hosted at 72.60.199.45) receive only the case details you submit for analysis. These requests are currently sent over HTTP; avoid including unnecessary personal identifiers.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Service providers such as secure file storage or analytics partners engaged under contract and bound by confidentiality.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Regulators or authorities when required by law, court order, or to protect the rights and safety of users or patients.',
                ),
              ],
            ),
            _buildSection(
              title: '5. Data Storage, Security, and Retention',
              headingStyle: headingStyle,
              children: [
                _buildBullet(
                  bodyStyle,
                  'Data in transit to the primary DermaInstitute API is encrypted via HTTPS. AI triage traffic currently uses HTTP; we recommend redacting direct patient identifiers until TLS is enabled.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Access tokens are stored locally in SharedPreferences/GetStorage and cleared when you log out. Draft SOPs and reports reside on-device until submitted or deleted.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Server-side data is retained for as long as your organization maintains an active account or as mandated by clinical recordkeeping obligations.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Locally exported files created with the export data feature remain on your device and fall under your organization’s security policies.',
                ),
                _buildBullet(
                  bodyStyle,
                  'We apply role-based access controls, least-privilege permissions, and logging to protect sensitive information.',
                ),
              ],
            ),
            _buildSection(
              title: '6. Your Choices & Rights',
              headingStyle: headingStyle,
              children: [
                _buildBullet(
                  bodyStyle,
                  'Access, edit, and update profile details from the Settings area. Changes sync to the DermaInstitute backend.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Download or export key account data locally using the export feature in Settings.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Manage push notification preferences within the app or through your device OS settings.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Delete drafts stored on your device at any time; submitted reports follow your organization’s retention policy.',
                ),
                _buildBullet(
                  bodyStyle,
                  'Request account deletion or additional privacy rights (e.g., access, portability, objection) by contacting us. Response times comply with applicable laws.',
                ),
              ],
            ),
            _buildSection(
              title: '7. International Data Transfers',
              headingStyle: headingStyle,
              children: [
                Text(
                  'Our infrastructure may operate in the United States or other jurisdictions. We implement safeguards such as contractual clauses and technical controls to protect cross-border data transfers.',
                  style: bodyStyle,
                ),
              ],
            ),
            _buildSection(
              title: '8. Children’s Privacy',
              headingStyle: headingStyle,
              children: [
                Text(
                  'DermaInstitute is intended for licensed medical professionals and trainees acting under institutional supervision. It is not directed to individuals under 16, and we do not knowingly collect personal data from children.',
                  style: bodyStyle,
                ),
              ],
            ),
            _buildSection(
              title: '9. Changes to This Policy',
              headingStyle: headingStyle,
              children: [
                Text(
                  'We may update this Privacy Policy to reflect product upgrades or regulatory changes. Material updates will be announced in-app or via email, and the “Last updated” date will change accordingly.',
                  style: bodyStyle,
                ),
              ],
            ),
            _buildSection(
              title: '10. Contact Us',
              headingStyle: headingStyle,
              children: [
                Text(
                  'For privacy questions, data requests, or incident reports, please contact privacy@dermainstitute.com or reach your organization’s DermaInstitute administrator. We aim to respond within 30 days.',
                  style: bodyStyle,
                ),
                SizedBox(height: AppSizes.szH24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSection({
    required String title,
    required TextStyle headingStyle,
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: AppSizes.szH24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headingStyle),
          SizedBox(height: AppSizes.szH8),
          ...children,
        ],
      ),
    );
  }

  static Widget _buildBullet(TextStyle style, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.szH8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: style.copyWith(fontWeight: FontWeight.w600)),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}
