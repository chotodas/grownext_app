import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/check_slots_viewmodel.dart';

class CheckSlotsPage extends StatelessWidget {
  const CheckSlotsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckSlotsViewModel(),
      child: Consumer<CheckSlotsViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.arrow_back, color: Colors.black),
              title: const Text(
                'Check Your Slots',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildTabs(vm),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    vm.formattedDate,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildScrollSelector(vm),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Available Slots',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: vm.slots.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(vm.slots[index]),
                //         trailing: Switch(
                //           value: vm.selectedSlots[index],
                //           onChanged: (val) {
                //             vm.selectSlot(index, val);
                //           },
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.slots.length,
                    itemBuilder: (context, index) {
                      Color randomColor = _getRandomColor();

                      Color slotBackgroundColor = index < 4
                          ? _getSlotBackgroundColor(index)
                          : Colors.white;

                      return ListTile(
                        tileColor: slotBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        title: Row(
                          children: [
                            Expanded(child: Text(vm.slots[index])),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: randomColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'id - 236589',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Switch(
                              value: vm.selectedSlots[index],
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                vm.selectSlot(index, val);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Color _getSlotBackgroundColor(int index) {
    List<Color> slotColors = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
    return slotColors[index % slotColors.length];
  }

  Widget _buildTabs(CheckSlotsViewModel vm) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Day', 'Month', 'Year'].map((type) {
              bool isSelected = vm.selectedType == type;
              return GestureDetector(
                onTap: () => vm.changeTab(type),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 38,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey[600],
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollSelector(CheckSlotsViewModel vm) {
    ScrollController _scrollController = ScrollController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: () {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.offset - 70,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
            vm.previousItem();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(vm.currentList.length, (index) {
                bool isSelected = vm.selectedIndex == index;
                return GestureDetector(
                  onTap: () => vm.selectItem(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1565C0)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      vm.currentList[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: () {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.offset + 70,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
            vm.nextItem();
          },
        ),
      ],
    );
  }
}
