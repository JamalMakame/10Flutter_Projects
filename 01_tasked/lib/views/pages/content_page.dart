import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasked/const/app_colors.dart';
import 'package:tasked/controllers/task_controller.dart';
import 'package:tasked/model/task_model.dart';
import 'package:tasked/services/notification_services.dart';
import 'package:tasked/views/widgets/task_tile.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>
    with AutomaticKeepAliveClientMixin<ContentPage> {
  late NotifyHelper notifyHelper;
  List showProgressData = [];
  final TaskModel taskModel = TaskModel();

  final DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  List<Map<String, String>> cardData = [
    {
      'title': 'Data Models',
      'date': 'October 11,2020',
    },
    {
      'title': 'UI/UX \nDesigning',
      'date': 'October 20,2020',
    },
    {
      'title': 'Front-End \nDevelopment',
      'date': 'October 24,2020',
    },
    {
      'title': 'Back-End \nDevelopment',
      'date': 'October 27,2020',
    },
  ];

  @override
  void initState() {
    super.initState();
    _taskController.getTasks();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestingIOSPermissions();
  }

  @override
  bool get wantKeepAlive => true;

  GestureDetector customBottomSheetButton({
    required Function() onTap,
    required BuildContext context,
    required String title,
    required Color buttonClr,
    required bool isClosed,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.h,
        ),
        child: Container(
          width: Get.width,
          height: 82.h,
          decoration: BoxDecoration(
            color: buttonClr,
            border: Border.all(
              width: 2.w,
              color: isClosed == true ? Colors.grey : buttonClr,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(226, 226, 226, 0.25),
                offset: const Offset(17, 26),
                blurRadius: 25.r,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: isClosed == true
                  ? Theme.of(context).primaryTextTheme.headline6
                  : Theme.of(context).primaryTextTheme.headline5,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> customBottomSheet({
    required TaskModel taskModel,
  }) {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4.h),
        height:
            taskModel.isCompleted == 1 ? Get.height * 0.24 : Get.height * 0.32,
        child: Column(
          children: [
            Container(
              height: 6.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: TodoColors.darkTextClr,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            taskModel.isCompleted == 1
                ? Container()
                : customBottomSheetButton(
                    isClosed: false,
                    context: context,
                    onTap: () {
                      _taskController.markTaskCompleted(taskModel.id!);
                      Get.back();
                    },
                    title: 'Task Completed',
                    buttonClr: Colors.blueAccent,
                  ),
            SizedBox(
              height: 20.h,
            ),
            customBottomSheetButton(
              isClosed: false,
              onTap: () {
                _taskController.delete(taskModel);
                Get.back();
              },
              context: context,
              title: 'Delete Task',
              buttonClr: Colors.red,
            ),
            SizedBox(
              height: 25.h,
            ),
            customBottomSheetButton(
              onTap: () {
                Get.back();
              },
              isClosed: true,
              context: context,
              title: 'Close',
              buttonClr: Colors.white,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  int _selectedIndex = 0;
  final List<String> _options = const [
    'My Tasks',
    'In-Progress',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    PageController pageController = PageController(
      viewportFraction: 0.6,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: TodoColors.backGroundClr,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 54.w),
              child: Text(
                'Progress',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 37.h,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                child: MediaQuery.removeViewPadding(
                  context: context,
                  removeTop: true,
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: _taskController.taskModelList.length,
                      itemBuilder: (context, index) {
                        TaskModel taskModel =
                            _taskController.taskModelList[index];
                        debugPrint(taskModel.toJson());
                        if (taskModel.date ==
                            DateFormat('yyyy-MM-d').format(_selectedDate)) {
                          notifyHelper.scheduledNotification(
                              hour: int.parse(
                                  taskModel.startTime.toString().split(':')[0]),
                              minutes: int.parse(
                                  taskModel.startTime.toString().split(':')[1]),
                              taskModel: taskModel);
                          return AnimationConfiguration.staggeredList(
                            duration: const Duration(
                              milliseconds: 600,
                            ),
                            position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          customBottomSheet(
                                            taskModel: _taskController
                                                .taskModelList[index],
                                          );
                                        },
                                        child: TaskTile(
                                          _taskController.taskModelList[index],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
