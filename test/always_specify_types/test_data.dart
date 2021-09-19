import 'package:meta/meta.dart';

Map<String, String> map = {}; //LINT
List<String> strings = []; //LINT
List<String> strings2 = ['fsd']; //LINT
Set<String> set = {}; //LINT

List? list; // LINT
List<List>? lists; //LINT
List<int>? ints; //OK

// final funcRes = () {};
// final funcResAsync = (dynamic fggd) async {
//   return 'fsdfs $fggd';
// };
// var a = 1, b = 2, c = 'fsdfds', d = 0.15;
final x = 1; //LINT [1:5]
var xvar = 1; //LINT [1:5]
// late int x11, y11;
final int xx = 3;
var y = 3.14; //LINT

const yy = 3;

final bl = false;

int? lvar;

/*fsdfsd **/
late final Map? testMap;

void main() {
  var x = ''; //LINT [3:3]
  for (var i = 0; i < 10; ++i) {
    //LINT [8:3]
    print(i);
  }
  List<String> ls = <String>[];

  ls.forEach((s1without) => print(s1without)); //LINT [15:1]
  ls.forEach((final s1final) => print(s1final)); //LINT [15:1]
  ls.forEach((var s1var) => print(s1var)); //LINT [15:1]
  ls.forEach((dynamic s1dynamic) => print(s1dynamic)); //LINT [15:1]

  for (var l in ls) {
    //LINT [8:3]
    print(l);
  }
  try {
    for (final l in ls) {
      // LINT [10:5]
      print(l);
    }
  } on Exception catch (ex) {
    print(ex);
  } catch (e) {
    // NO warning (https://codereview.chromium.org/1427223002/)
    print(e);
  }
}

class Foo {
  static var bar = 'dsfsd'; //LINT
  static final baz = 1; //LINT
  static final int bazz = 42;
  // var foo; //LINT
  // Foo(var bar); //LINT [7:3]
  void f(List l) {} //LINT
}

void m() {
  if ('' is Map) //OK {
  {
    print("won't happen");
  }
}
