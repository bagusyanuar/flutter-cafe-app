import 'package:rye_coffee/model/order.model.dart';

List<Map<String, dynamic>> DummyCategories = [
  {'id': 1, 'name': 'Coffee Based', 'type': 'menu'},
  {'id': 2, 'name': 'Non Coffee', 'type': 'menu'},
  {'id': 3, 'name': 'Snack', 'type': 'menu'},
  {'id': 4, 'name': 'Western Food', 'type': 'menu'},
  {'id': 5, 'name': 'Desert', 'type': 'menu'},
  {'id': 6, 'name': 'Paket', 'type': 'package'},
];

List<Map<String, dynamic>> DummyProducts = [
  {
    'id': 1,
    'name': 'Esspresso',
    'price': 15000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 2,
    'name': 'Kopi Susu Gula Aren',
    'price': 23000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 3,
    'name': 'Lychee Tea',
    'price': 25000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 4,
    'name': 'Cappucino',
    'price': 27000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 5,
    'name': 'Americano',
    'price': 20000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
];

List<dynamic> DummyPackages = [
  {
    'id': 1,
    'name': 'Americano',
    'qty': 3,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 1,
    'name': 'Americano',
    'qty': 3,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 2,
    'name': 'Americano',
    'qty': 3,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 4,
    'name': 'Americano',
    'qty': 3,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 5,
    'name': 'Americano',
    'qty': 3,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  },
  {
    'id': 6,
    'name': 'Americano',
    'qty': 3,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg'
  }
];

List<dynamic> dummyCategoriesDynamic = [
  {'id': 1, 'name': 'Coffee Based', 'type': 'menu'},
  {'id': 2, 'name': 'Non Coffee', 'type': 'menu'},
  {'id': 3, 'name': 'Snack', 'type': 'menu'},
  {'id': 4, 'name': 'Western Food', 'type': 'menu'},
  {'id': 5, 'name': 'Desert', 'type': 'menu'},
  {'id': 6, 'name': 'Paket', 'type': 'package'},
];

const List<dynamic> dummyProductsDynamic = [
  {
    'id': 1,
    'name': 'Esspresso',
    'price': 15000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
    'description':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    'type': 'menu',
    'items': []
  },
  {
    'id': 2,
    'name': 'Kopi Susu Gula Aren',
    'price': 23000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
    'description':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    'type': 'menu',
    'items': []
  },
  {
    'id': 3,
    'name': 'Lychee Tea',
    'price': 25000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
    'description':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    'type': 'menu',
    'items': []
  },
  {
    'id': 4,
    'name': 'Cappucino',
    'price': 27000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
    'description':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    'type': 'menu',
    'items': []
  },
  {
    'id': 5,
    'name': 'Americano',
    'price': 20000,
    'image':
        'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
    'description':
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    'type': 'menu',
    'items': []
  },
];

List<Order> dummyOrderList = [
  Order(
      id: 1,
      image:
          'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
      date: '2024-01-01',
      orderNumber: 'RYE-0001',
      price: 10000,
      point: 10,
      status: 1),
  Order(
      id: 2,
      image:
          'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
      date: '2024-01-02',
      orderNumber: 'RYE-0002',
      price: 25000,
      point: 10,
      status: 2),
  Order(
      id: 3,
      image:
          'https://ayomakan.oss-ap-southeast-5.aliyuncs.com/article/ARTICLE-AYOMAKAN_20231103140453.jpg',
      date: '2024-01-03',
      orderNumber: 'RYE-0003',
      price: 25000,
      point: 10,
      status: 3),
];
