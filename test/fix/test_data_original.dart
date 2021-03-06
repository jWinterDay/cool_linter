// import 'package:meta/meta.dart';

// Map<String, String> map = {}; //LINT
// List<String> strings = []; //LINT
// Set<String> set = {}; //LINT

// List? list; // LINT
// List<List>? lists; //LINT
// List<int>? ints; //OK

// final x = 1; //LINT [1:5]
// final int xx = 3;
// const y = 2; //LINT
// const int yy = 3;

// final bl = false;

// int? lvar;

// /*fsdfsd **/
// final Map? testMap;

// /// fsdfd
// a(var x) {} //LINT
// // for test comment under
// a2(_) {} //LINT
// b(s) {} //LINT [3:1]
// c(int x) {} // for test comment right
// d(final x) {} //LINT
// e(final int x) {}

// // simple class comment
// @optionalTypeArgs
// class P<T> {}

// @optionalTypeArgs
// void g<T>() {}

// //https://github.com/dart-lang/linter/issues/851
// void test() {
//   /// method comment
//   g<dynamic>(); //OK
//   g(); //OK
// }

// main() {
//   var x = ''; //LINT [3:3]
//   for (var i = 0; i < 10; ++i) {
//     //LINT [8:3]
//     print(i);
//   }
//   List<String> ls = <String>[];
//   ls.forEach((String s1without) => print(s1without)); //LINT [15:1]
//   ls.forEach((String s1final) => print(s1final)); //LINT [15:1]
//   ls.forEach((String s1var) => print(s1var)); //LINT [15:1]
//   ls.forEach((dynamic s1dynamic) => print(s1dynamic)); //LINT [15:1]
//   for (var l in ls) {
//     //LINT [8:3]
//     print(l);
//   }
//   try {
//     for (final l in ls) {
//       // LINT [10:5]
//       print(l);
//     }
//   } on Exception catch (ex) {
//     print(ex);
//   } catch (e) {
//     // NO warning (https://codereview.chromium.org/1427223002/)
//     print(e);
//   }

//   var __; // LINT

//   listen((_) {
//     // OK!
//     // ...
//   });

//   P p = new P(); //OK (optionalTypeArgs)
// }

// P doSomething(P p) //OK (optionalTypeArgs)
// {
//   return p;
// }

// listen(void onData(Object event)) {}

// var z; //LINT

// class Foo {
//   static var bar; //LINT
//   static final baz = 1; //LINT
//   static final int bazz = 42;
//   var foo; //LINT
//   Foo(var bar) => print(s1var)); //LINT [15:1]
//   ls.forEach((dynamic s1dynamic) => print(s1dynamic)); //LINT [15:1]
//   for (var l in ls) {
//     //LINT [8:3]
//     print(l);
//   }
//   try {
//     for (final l in ls) {
//       // LINT [10:5]
//       print(l);
//     }
//   } on Exception catch (ex) {
//     print(ex);
//   } catch (e) {
//     // NO warning (https://codereview.chromium.org/1427223002/)
//     print(e);
//   }

//   var __; // LINT

//   listen((_) {
//     // OK!
//     // ...
//   });

//   P p = new P(); //OK (optionalTypeArgs)
// }

// P doSomething(P p) //OK (optionalTypeArgs)
// {
//   return p;
// }

// listen(void onData(Object event)) {}

// var z; //LINT

// class Foo {
//   static var bar; //LINT
//   static final baz = 1; //LINT
//   static final int bazz = 42;
//   var foo; //LINT
//   Foo(var bar) {
//     // NO warning (https://codereview.chromium.org/1427223002/)
//     print(e);
//   }

//   var __; // LINT

//   listen((_) {
//     // OK!
//     // ...
//   });

//   P p = new P(); //OK (optionalTypeArgs)
// }

// P doSomething(P p) //OK (optionalTypeArgs)
// {
//   return p;
// }

// listen(void onData(Object event)) {}

// var z; //LINT

// class Foo {
//   static var bar; //LINT
//   static final baz = 1; //LINT
//   static final int bazz = 42;
//   var foo; //LINT
//   Foo(var bar); //LINT [7:3]
//   void f(List l) {} //LINT
// }

// void m() {
//   if ('' is Map) //OK {
//   {
//     print("won't happen");
//   }
// }
