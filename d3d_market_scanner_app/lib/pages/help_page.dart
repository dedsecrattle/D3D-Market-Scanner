import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: Colors.pink,
        leading: const SideMenuWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const FAQCard(
              question: 'How do I create a new account?',
              answer:
                  'To create a new account, go to the Sign Up page and fill in the required information.',
            ),
            const SizedBox(height: 16),
            const FAQCard(
              question: 'Can I change my password?',
              answer:
                  'Yes, you can change your password in the Account Settings page.',
            ),
            const SizedBox(height: 16),
            const FAQCard(
              question: 'How do I contact customer support?',
              answer:
                  'You can reach out to our customer support team by emailing orbital@theprabhat.me',
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: _launchURL,
                  child: const Text('Report an Error'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    const url = 'https://www.theprabhat.me'; // Replace with your desired URL
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class FAQCard extends StatefulWidget {
  final String question;
  final String answer;

  const FAQCard({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          widget.question,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
        onExpansionChanged: (value) {
          setState(() {
            expanded = value;
          });
        },
        trailing: Icon(
          expanded ? Icons.expand_less : Icons.expand_more,
          size: 28,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.answer,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
