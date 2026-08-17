import 'package:flutter/material.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Row(
          children: [
            const Text(
              'AutoMate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), // Placeholder avatar
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Log Maintenance',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Keep your vehicle\'s health records up to date for better resale value and performance.',
                style: TextStyle(fontSize: 14, color: Color(0xFF515F74)),
              ),
              const SizedBox(height: 24),

              // Service Details Section
              _buildSectionCard(
                title: 'Service Details',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Service Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF45464D))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(hintText: 'Oil Change'),
                      items: const [],
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF45464D))),
                              const SizedBox(height: 8),
                              TextFormField(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Mileage', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF45464D))),
                              const SizedBox(height: 8),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  suffixText: 'KM',
                                  suffixIcon: Icon(Icons.unfold_more, size: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Workshop / Service Center', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF45464D))),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Search service center name...',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildChoiceChip('GHABBOUR AUTO'),
                        _buildChoiceChip('EZZ ELARAB'),
                        _buildChoiceChip('BAVARIAN'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Additional Info Section
              _buildSectionCard(
                icon: Icons.description_outlined,
                title: 'Additional Information',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF45464D))),
                    const SizedBox(height: 8),
                    TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Specify parts used or future recommendations...',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Spare Parts Section
              _buildSectionCard(
                icon: Icons.settings_suggest_outlined,
                title: 'Spare Parts',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Renewed Spare Part', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF45464D))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(hintText: 'Select a part...'),
                      items: const [],
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline, color: Color(0xFF515F74)),
                      label: const Text('Add Another Part', style: TextStyle(color: Color(0xFF515F74))),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Maintenance Cost Section
              _buildSectionCard(
                icon: Icons.money,
                title: 'Maintenance Cost',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF45464D))),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: '0.00',
                        suffixIcon: SizedBox(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.unfold_more, size: 16, color: Color(0xFFC6C6CD)),
                              SizedBox(width: 8),
                              Text('EGP', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Includes VAT and labor fees.', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Color(0xFF7C839B))),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Receipt Section
              _buildSectionCard(
                icon: Icons.receipt_long,
                title: 'Receipt / Invoice',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFC6C6CD), style: BorderStyle.solid), // Dashed borders need custom painters, using solid for now
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCE9FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.cloud_upload_outlined, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 16),
                      const Text('Upload Document', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('PDF, JPG, or PNG (Max 5MB)', style: TextStyle(fontSize: 12, color: Color(0xFF515F74))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_outlined, size: 18),
                label: const Text('Log Service'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, IconData? icon, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: const Color(0xFF0F172A)),
                  const SizedBox(width: 8),
                ],
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE5EEFF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF515F74)),
      ),
    );
  }
}
