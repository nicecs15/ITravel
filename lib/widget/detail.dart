import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class NorthDetail extends StatelessWidget {
  const NorthDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('สถานที่ท่องเที่ยวภาคเหนือ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/wall.png',
                  height: 400.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: const Text(
                          "ม่อนแจ่ม",
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Container(
                          height: 34.0,
                          width: 94.0,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                size: 18,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                "Favorite",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.black.withOpacity(0.8),
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.share,
                        size: 24,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                          child: Text(
                        "เชียงใหม่",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.black.withOpacity(0.8),
                    height: 32.0,
                  ),
                  const Text(
                    "ม่อนแจ่ม เป็นสถานที่เที่ยวยอดนิยมของเชียงใหม่ เที่ยวได้ตลอดทั้งปี ตั้งอยู่ในอำเภอแม่ริม ห่างจากตัวเมืองประมาณ 40 นาที  ม่อนแจ่มเป็นส่วนหนึ่งของศูนย์พัฒนาโครงการหลวงหนองหอย ตั้งอยู่บริเวณหมู่บ้านม้ง หนองหอย อำเภอแม่ริม บนยอดม่อนแจ่มมีพื้นที่ไม่กว้างมาก สามารถเดินชมได้ทั่วถึง  ที่ตั้งของ “ม่อนแจ่ม” อยู่บนสันเขาบริเวณหมู่บ้านม้งหนองหอย เดิมบริเวณนี้ชาวบ้าน เรียกว่ากิ่วเสือเป็นป่ารกร้าง ต่อมาชาวบ้านเข้ามาแผ้วถางและปลูกผิ่น จนในท้ายที่สุดโครงการหลวงมาขอซื้อพื้นที่เข้าโครงการหลวงหนองหอย เมื่อเข้าเป็นส่วนหนึ่งของโครงการหลวง คุณแจ่ม-แจ่มจรัส สุชีวะ หลานของ ม.จ. ภีศเดช รัชนี ประธานมูลนิธิโครงการหลวงได้เข้ามาพัฒนาและปรับปรุงบริเวณม่อนแจ่มให้กลายเป็นสถานที่ท่องเที่ยว โดยเฉพาะในลักษณะ ของแค้มปิ้งรีสอร์ท",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Container(
                    height: 64.0,
                    width: size.width,
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 212, 214),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 32.0,
                          width: 32.0,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Image.asset("images/write.png"),
                        ),
                        const Expanded(
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Write a comment ....",
                              hintStyle: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 32.0,
                          width: 32.0,
                          padding: EdgeInsets.all(9.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Image.asset("images/sendcom.png"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
