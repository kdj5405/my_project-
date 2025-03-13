import 'dart:io';

class ShoppingMall {
  final Map<String, int> products = {
    '셔츠': 45000,
    '원피스': 30000,
    '반팔티': 35000,
    '반바지': 38000,
    '양말': 5000,
  };

  final Map<String, int> cart = {};
  int totalPrice = 0;

  void showProductList() {
    print('판매 상품 목록');
    products.forEach((name, price) {
      print('$name / ${price}원');
    });
  }

  void addToCart() {
    stdout.write('담을 상품 이름을 입력하세요: ');
    String? productName = stdin.readLineSync();

    if (productName == null || !products.containsKey(productName)) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    stdout.write('상품 개수를 입력하세요: ');
    String? quantityInput = stdin.readLineSync();

    try {
      int quantity = int.parse(quantityInput ?? '0');
      if (quantity <= 0) {
        print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
        return;
      }

      cart[productName] = (cart[productName] ?? 0) + quantity;
      totalPrice += products[productName]! * quantity;
      print('장바구니에 상품이 담겼어요 !');
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
    }
  }

  void showCartDetails() {
    if (cart.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
      return;
    }

    List<String> cartItems = cart.keys.toList();
    print('장바구니에 ${cartItems.join(', ')}이(가) 담겨있네요. 총 ${totalPrice}원 입니다!');
  }

  void clearCart() {
    if (cart.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
    } else {
      cart.clear();
      totalPrice = 0;
      print('장바구니를 초기화했습니다.');
    }
  }

  bool checkOut() {
    stdout.write('정말 종료하시겠습니까? (5 입력 시 종료, 그 외 취소): ');
    String? input = stdin.readLineSync();
    if (input == '5') {
      print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
      return true;
    } else {
      print('종료하지 않습니다.');
      return false;
    }
  }
}

void main() {
  ShoppingMall mall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print('-------------------------------------- 쇼핑몰 ----------------------------------');
    print('[1] 상품 목록 보기 / [2] 장바구니에 상품 담기 / [3] 장바구니 상세 보기');
    print('[4] 프로그램 종료 / [6] 장바구니 초기화');
    print('-------------------------------------------------------------------------------');

    stdout.write('메뉴를 선택하세요: ');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProductList();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showCartDetails();
        break;
      case '4':
        if (mall.checkOut()) {
          isRunning = false;
        }
        break;
      case '6':
        mall.clearCart();
        break;
      default:
        print('올바른 번호를 입력하세요 !');
    }
  }
}