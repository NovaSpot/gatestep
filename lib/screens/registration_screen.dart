import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _passcodeController = TextEditingController();
  final _massController = TextEditingController();
  final _cycleController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passcodeController.dispose();
    _massController.dispose();
    _cycleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Corner frame decoration
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryCyan.withAlpha(40),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryCyan.withAlpha(60),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.terminal,
                        color: AppColors.primaryCyan,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Title
                    Text(
                      'HUNTER REGISTRATION',
                      style: GoogleFonts.shareTechMono(
                        color: AppColors.primaryCyan,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'SYSTEM_INIT // AWAITING_INPUT',
                      style: GoogleFonts.shareTechMono(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Username field
                    _buildFieldLabel('[USERNAME]', 'REQ_01'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _usernameController,
                      style: GoogleFonts.shareTechMono(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Designation...',
                        hintStyle: GoogleFonts.shareTechMono(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Passcode field
                    _buildFieldLabel('[PASSCODE]', 'REQ_02'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passcodeController,
                      obscureText: true,
                      style: GoogleFonts.shareTechMono(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: GoogleFonts.shareTechMono(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Mass and Cycle fields
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel('[MASS]', 'KG'),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _massController,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.shareTechMono(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  hintText: '00.0',
                                  hintStyle: GoogleFonts.shareTechMono(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel('[CYCLE]', 'YRS'),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _cycleController,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.shareTechMono(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  hintText: '00',
                                  hintStyle: GoogleFonts.shareTechMono(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Terms notice
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: AppColors.primaryCyan.withAlpha(60),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.textSecondary,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'By entering the gate, you agree to the terms and conditions of GateStep.',
                              style: GoogleFonts.shareTechMono(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Enter button
                    CyberButton(
                      text: 'ENTER THE GATE →]',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/main');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Version footer
              Text(
                'V.1.0.4 // OFFLINE',
                style: GoogleFonts.shareTechMono(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, String suffix) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.shareTechMono(
            color: AppColors.primaryCyan,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          suffix,
          style: GoogleFonts.shareTechMono(
            color: AppColors.textSecondary,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
