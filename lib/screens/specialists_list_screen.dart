import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/specialist_provider.dart';

class SpecialistsListScreen extends StatefulWidget {
  const SpecialistsListScreen({super.key});

  @override
  State<SpecialistsListScreen> createState() => _SpecialistsListScreenState();
}

class _SpecialistsListScreenState extends State<SpecialistsListScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchData() {
    Provider.of<SpecialistProvider>(context, listen: false)
        .fetchServiceCenters(
      search: _searchController.text,
      type: _selectedFilter == 'All' ? null : _selectedFilter.toUpperCase().replaceAll(' ', '_'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFDCE9FF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.store, color: Color(0xFF0F172A), size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'AutoMate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF0F172A)),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFC6C6CD)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Color(0xFF515F74), size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onSubmitted: (_) => _fetchData(),
                                onChanged: (_) => _fetchData(),
                                decoration: const InputDecoration(
                                  hintText: 'Search workshops or services...',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _fetchData,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.search, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Authorized'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Non Authorized'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<SpecialistProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!, style: const TextStyle(color: Colors.red)));
          }

          final centers = provider.serviceCenters;

          if (centers.isEmpty) {
            return const Center(child: Text('No service centers found.', style: TextStyle(color: Color(0xFF515F74))));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Map Header
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF213145),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      const Center(child: Icon(Icons.map, size: 48, color: Color(0xFF515F74))),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Row(
                          children: [
                            const Icon(Icons.my_location, color: Colors.white, size: 16),
                            const SizedBox(width: 8),
                            Text('${centers.length} Specialists near you', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Specialist Cards
                ...centers.map((center) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildSpecialistCard(
                    title: center.name,
                    rating: '4.8 (120)', // Static for now
                    address: '${center.address}, ${center.city}',
                    tags: [center.type.replaceAll('_', ' ')],
                    isVerified: center.type == 'AUTHORIZED',
                  ),
                )).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
        _fetchData();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE5EEFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color(0xFF515F74),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialistCard({
    required String title,
    required String rating,
    required String address,
    required List<String> tags,
    required bool isVerified,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 140,
            color: const Color(0xFFC6C6CD),
            child: Stack(
              children: [
                const Center(child: Icon(Icons.storefront, size: 48, color: Color(0xFF515F74))),
                if (isVerified)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'VERIFIED SPECIALIST',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.black, size: 16),
                        const SizedBox(width: 4),
                        Text(rating, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EEFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(tag, style: const TextStyle(fontSize: 10, color: Color(0xFF515F74), fontWeight: FontWeight.bold)),
                  )).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Color(0xFF515F74), size: 16),
                    const SizedBox(width: 4),
                    Expanded(child: Text(address, style: const TextStyle(fontSize: 12, color: Color(0xFF515F74)))),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone_outlined, size: 18),
                        label: const Text('Call'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.directions, size: 18),
                        label: const Text('Route'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
