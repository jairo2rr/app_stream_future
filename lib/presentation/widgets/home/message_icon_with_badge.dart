
import 'package:app_stream_future/presentation/controller/media_file_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageIconWithBadge extends StatelessWidget {

  final MediaFileController _controller = Get.find();
  final _padding = EdgeInsets.all(5);

  MessageIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(Icons.mail, size: 30,),
        Positioned(
            right: 0,
            child: Obx((){
              return _controller.messageCount.value > 0 ?
                  Container(
                    padding: _padding,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_controller.messageCount.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),
                    ),
                  )
                  : SizedBox.shrink();
            })
        )
      ],
    );
  }
}
