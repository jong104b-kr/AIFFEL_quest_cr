/* DetailScreen에서 MyScreen으로, MyScreen에서 DetailScreen으로
전환하고 되돌아올 때 전달할 데이터 형식 */
class User {
  String id; // 아이디
  String password; // 비밀번호
  // String my_wines; 내 와인들(추후 반영)
  // String ratings; 와인평가(추후 반영)
  // String wishlists; 위시리스트(추후 반영)
  User(this.id, this.password);
}