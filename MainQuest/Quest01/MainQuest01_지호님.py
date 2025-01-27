# #1 Account 클래스 : 은행에 가서 계좌를 개설하면 은행이름, 예금주, 계좌번호, 잔액이 설정됩니다.
# Account 클래스를 생성한 후 생성자(hint: 매직매서드..!!)를 구현해보세요.
# 생성자에서는 예금주와 초기 잔액만 입력 받습니다.
# 은행이름은 SC은행으로 계좌번호는 3자리-2자리-6자리 형태로 랜덤하게 생성됩니다. (은행이름: SC은행, 계좌번호: 111-11-111111)
# #2 클래스 변수: 클래스 변수를 사용해서 Account 클래스로부터 생성된 계좌 객체의 개수를 저장하세요.
# #3 클래스 변수 출력 : Account 클래스로부터 생성된 계좌의 개수를 출력하는 get_account_num() 메서드를 추가하세요.
# #4 입금 메서드 : Account 클래스에 입금을 위한 deposit 메서드를 추가하세요. 입금은 최소 1원 이상만 가능합니다.
# #5 출금 메서드 : Account 클래스에 출금을 위한 withdraw 메서드를 추가하세요. 출금은 계좌의 잔고 이상으로 출금할 수는 없습니다.
# #6. 정보 출력 메서드 : Account 인스턴스에 저장된 정보를 출력하는 display_info() 메서드를 추가하세요.
# 잔고는 세자리마다 쉼표를 출력하세요.
# (은행이름: SC은행, 예금주: 파이썬, 계좌번호: 111-11-111111, 잔고: 10,000원)
# #7 이자 지급하기 : 입금 횟수가 5회가 될 때 잔고를 기준으로 1%의 이자가 잔고에 추가되도록 코드를 변경해보세요.
# #8 여러 객체 생성 : Account 클래스로부터 3개 이상 인스턴스를 생성하고 생성된 인스턴스를 리스트에 저장해보세요.
# #9 객체 순회 반복문을 통해 리스트에 있는 객체를 순회하면서 잔고가 100만원 이상인 고객의 정보만 출력하세요.
# #10 입금과 출금 내역이 기록되도록 코드를 업데이트 하세요.
# (입금 내역과 출금 내역을 출력하는 deposit_history와 withdraw_history 메서드를 추가하세요.)
     

import random as r

class Account:
  account_count = 0 # 초기값
  transaction_count = 0 # 초기값

  def __init__(self, user_name, money_left):
# 예금주, 잔액, 은행이름, 계좌번호 설정
    self.user_name = user_name
    self.money_left = money_left
    self.bank_name = "SC은행"
    # 계좌번호가 001-01-000001 일 경우 빈 자릿수를 0으로 채우는 기능도 예시 답안에는 구현되어 있습니다. 저는 예시를 보고 해서 혼자 이렇게 하라면 시간이 걸렸을 것 같습니다. 참고 바랍니다.
    # https://wikidocs.net/7037
    self.account_number = f"{r.randint(100, 999)}-{r.randint(10, 99)}-{r.randint(100000, 999999)}"
    Account.account_count += 1 # 생성된 계좌 객체의 개수를 저장
    self.withdraw_info = []
    self.deposit_info = []
    self.deposit_count = 0 # 초기값
    self.transaction_history = []

# 삭제한 코드
# 성함과 잔액을 일일히 입력받는 채점방식이 아니므로 삭제..ㅠㅠ
  # def make_account(self): # 예금주와 초기 잔액만 입력 받음.
  #   user_name = input("성함을 입력하세요: ")
  #   money_left = int(input("금액을 입력하세요(숫자로만 입력): "))
  #   return Account(user_name, money_left)

  @classmethod
  def get_account_num(cls):
    print(f"생성된 계좌의 총 개수 : {cls.account_count}")

  def print_transaction_history(self):  # 거래 내역 출력 메서드 추가
    for i, transaction_type, amount, balance in self.transaction_history:
      print(f"{i}회: {transaction_type}, 금액: {amount:,}, 잔액: {balance:,}")

  def deposit(self, money_add): # 입금
    print("입금은 최소 1원 이상만 가능합니다.")

    if money_add >= 1:
      Account.transaction_count += 1
      self.deposit_info.append(money_add)
      self.money_left += money_add
      self.deposit_count += 1
      self.transaction_history.append((self.transaction_count, "입금", money_add, self.money_left))

      if self.deposit_count % 5 == 0: # 입금 횟수에 따른 이자 계산
        Account.transaction_count += 1 # 거래 내역 횟수에 반영
        interest = int(self.money_left * 0.01)
        self.money_left += interest
        print(f"{interest}의 이자가 입금되었습니다.")
        self.transaction_history.append((self.transaction_count, "이자지급", interest, self.money_left))

  def withdraw(self, money_minus): # 출금

    if self.money_left >= money_minus:
      Account.transaction_count += 1 # 거래 내역 횟수에 반영
      self.withdraw_info.append(money_minus)
      self.money_left -= money_minus
      transaction_count = len(self.transaction_history) + 1
      self.transaction_history.append((transaction_count, "출금", money_minus, self.money_left))
    else:
      print("계좌 잔고 이상으로 출금할 수 없습니다.")

  def print_transaction_history(self):  # 거래 내역 출력 메서드
        for i, transaction_type, amount, balance in self.transaction_history:
            print(f"{i}회: {transaction_type}, 금액: {amount:,}, 잔액: {balance:,}")

  def withdraw_history(self): # 출금 정보
    for money_minus in self.withdraw_info:
      print(f"출금 내역 : {money_minus}")

  def deposit_history(self): # 입금 정보
    for money_add in self.deposit_info:
      print(f"입금 내역 : {money_add}")

  def display_info(self): # 종합 정보
        print(f"은행이름: {self.bank_name}, 예금주: {self.user_name}, 계좌번호: {self.account_number}, 잔고: {self.money_left:,}")

# append를 활용하면 임의의 n개 계좌를 입력 및 출력할 수 있을 것 같지만
# 어떻게 적을지 몰라서 방식 변경
# 일단 6개까지 마련해놓고, pop을 활용해서 입력이 안 된 것은 지우는 것으로
# 목표를 바꿨습니다.
# # 삭제한 코드
# # 예시로 나온 3가지만 받을 수 있도록 목표를 낮췄습니다.
# # 임의의 n개를 입력받는 것을 구현하기에는 아직 너무 어렵습니다.
# List_of_accounts = [first_account, second_account, third_account,fourth_account, fifth_account, sixth_account]
# for account in List_of_accounts:
# account.personal_info()

data = []
first_account = Account('차정은', 1000)
second_account = Account('박광석', 30000000)
third_account = Account('조웅제', 50000000)
my_account = first_account

# 리스트에 계좌 정보 추가
data.append(first_account)
data.append(second_account)
data.append(third_account)

for i in range(10): #실제 입출금
  my_account.deposit(1000)
my_account.deposit(-1000)
my_account.withdraw(30000000)
my_account.withdraw(3000)

# 입출금 내역 디스플레이
my_account.deposit_history()
print('-'*50)
my_account.withdraw_history()
print('-'*50)
Account.get_account_num()
first_account.display_info()
second_account.display_info()
third_account.display_info()
print('-'*50)

for account in data:
    account.print_transaction_history() # 거래 내역을 출력
print('-'*50)
