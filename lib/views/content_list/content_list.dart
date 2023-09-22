import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/content.dart';
import '/config/color.dart';
import 'content_detail/content_detail.dart';
import '/components/address_navigator.dart';
import '/components/primary_button.dart';
import '/components/small_tag.dart';
import '/components/basic/no_data.dart';
import '/components/basic/card_container.dart';

class ContentCard extends StatelessWidget {
  final Content contentInfo;

  const ContentCard({Key? key, required this.contentInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ContentDetailPage(contentInfo: contentInfo));
      },
      child: CardContainer(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(
          spacing: 12,
          children: [
            Text(
              "#${contentInfo.field1 ?? ''}",
              style: TextStyle(
                  color: C.primary, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SmallTag(
                title: contentInfo.field2 ?? '',
                theme: {
                      'status 1': 'blue',
                      'status 2': 'green',
                      'status 3': 'red'
                    }[contentInfo.field2] ??
                    'grey'),
          ],
        ),
        const SizedBox(height: 8),
        OrderCardMainInfo(contentInfo: contentInfo)
      ])),
    );
  }
}

class OrderCardMainInfo extends StatelessWidget {
  final Content contentInfo;

  const OrderCardMainInfo({Key? key, required this.contentInfo})
      : super(key: key);

  Widget greyTextTag(String text, Widget icon) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: C.gee,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(text,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contentInfo.field3 ?? '',
          overflow: TextOverflow.visible,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 8),
        Text(
          contentInfo.field4 ?? '',
          overflow: TextOverflow.visible,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            greyTextTag(
                contentInfo.field3 ?? '',
                const Text('ID:',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
            greyTextTag(contentInfo.field5 ?? '',
                const Icon(Icons.person_outline, size: 16)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddressWrapper(
              address: contentInfo.field5 ?? '',
              child: Container(
                height: 38,
                width: 60,
                padding: const EdgeInsets.all(6),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.near_me_outlined, color: C.primary, size: 28),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: PrimaryButton(
                text: 'Details'.tr,
                onTap: () {
                  Get.to(() => ContentDetailPage(contentInfo: contentInfo));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContentCardListPage extends StatelessWidget {
  const ContentCardListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<ContentCardListPage>(this); //用于后续用Getx调用fresh函数

    List<Content> cList = [
      Content(
        '1',
        'status 1',
        'some info',
        'Main info',
        'other info',
        'detail info',
      ),
      Content(
        '2',
        'status 2',
        'some info',
        'Main info',
        'other info',
        'detail info',
      ),
      Content(
        '3',
        'status 3',
        'some info',
        'Main info',
        'other info',
        'detail info',
      ),
    ];

    return cList.length == 0
        ? const NoData()
        : Container(
            color: C.gf9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cList.length,
                  itemBuilder: (context, index) {
                    Content o = cList[index];
                    return ContentCard(contentInfo: o);
                  },
                )),
              ],
            ));
  }
}
