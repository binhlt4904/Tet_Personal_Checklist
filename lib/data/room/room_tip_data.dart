

import '../../domain/entities/room_tip_model.dart';

final List<RoomTipModel> roomTips = [
  RoomTipModel(
    title: "Phòng khách",
    description: "Dọn dẹp phòng khách",
    time: "3-4 giờ",
    icon: "home",
    steps: [
      "Quét mạng nhện, lau quạt trần",
      "Lau cửa kính",
      "Đánh bóng đồ gỗ",
      "Hút bụi sofa",
      "Lau thiết bị điện tử",
    ],
    tools: [
      "Chổi dài",
      "Dung dịch lau kính",
      "Nước đánh bóng gỗ",
      "Máy hút bụi",
    ],
  ),

  RoomTipModel(
    title: "Phòng ngủ",
    description: "Làm sạch phòng ngủ",
    time: "2 giờ",
    icon: "bed",
    steps: [
      "Giặt chăn ga",
      "Hút bụi nệm",
      "Lau tủ quần áo",
    ],
    tools: [
      "Máy hút bụi",
      "Nước xịt khử mùi",
    ],
  ),
  RoomTipModel(
    title: "Phòng bếp",
    description: "Vệ sinh phòng bếp",
    time: "2-3 giờ",
    icon: "kitchen",
    steps: [
      "Dọn rác và phân loại",
      "Lau bếp gas",
      "Lau tủ lạnh",
      "Vệ sinh bồn rửa",
    ],
    tools: [
      "Nước rửa chén",
      "Khăn microfiber",
      "Nước tẩy bếp",
    ],
  ),
  RoomTipModel(
    title: "Nhà vệ sinh",
    description: "Vệ sinh và khử khuẩn nhà vệ sinh",
    time: "1.5 giờ",
    icon: "wc",
    steps: [
      "Cọ rửa bồn cầu",
      "Lau lavabo và gương",
      "Chà sàn và tường",
      "Đổ rác và thay túi mới",
    ],
    tools: [
      "Nước tẩy rửa",
      "Bàn chải cọ",
      "Găng tay cao su",
      "Khăn lau",
    ],
  ),
  RoomTipModel(
    title: "Phòng thờ",
    description: "Dọn dẹp bàn thờ",
    time: "1-2 giờ",
    icon: "temple_buddhist",
    steps: [
      "Chuẩn bị tâm thành, thắp nhang xin phép",
      "Lau sạch bàn thờ bằng khăn mềm",
      "Đánh bóng đồ thờ cúng (lư, đèn, bình hoa)",
      "Thay nước hoa quả, cúng phẩm mới",
      "Tỉa chân nhang cho gọn gàng",
      "Lau sạch ảnh thờ và khung ảnh",
      "Sắp xếp lại đồ thờ cúng ngăn nắp"
    ],
    tools: [
      "Khăn mềm sạch",
      "Nước lau chuyên dụng (không mùi)",
      "Bông gòn"
      "Nước hoa quả tươi",
    ],
  ),
  RoomTipModel(
    title: "Ban công",
    description: "Làm sạch và sắp xếp ban công",
    time: "1 giờ",
    icon: "balcony",
    steps: [
      "Quét rác và lá khô",
      "Lau lan can",
      "Vệ sinh cửa kính",
      "Sắp xếp lại cây cảnh",
    ],
    tools: [
      "Chổi",
      "Cây lau nhà",
      "Nước lau kính",
    ],
  ),
  RoomTipModel(
    title: "Mẹo chung",
    description: "Bí quyết dọn nhà hiệu quả",
    time: "Linh hoạt",
    icon: "tip",
    steps: [
      "Lập kế hoạch chi tiết trước 2 tuần Tết",
      "Dọn từ trong ra ngoài, từ trên xuống dưới",
      "Chia nhỏ công việc, mỗi ngày làm 1-2 phòng",
      "Chuẩn bị đầy đủ dụng cụ trước khi bắt đầu",
      "Nghỉ ngơi 10-15 phút sau mỗi giờ làm việc",
      "Mở cửa sổ thông thoáng khi vệ sinh",
      "Nghe nhạc vui để giảm mệt mỏi",
      "Rủ cả nhà cùng làm để nhanh hơn"
    ],
    tools: [
      "Danh sách checklist",
      "Găng tay, khẩu trang",
      "Nhiều loại khăn lau",
          "Máy hút bụi",
      "Thùng đựng đồ dùng vệ sinh"
    ],
  ),
];