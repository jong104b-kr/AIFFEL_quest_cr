import random as r
import math

class Account():
  total_accounts = 0

  def __init__(self, name, balance):
    self.bank_name = "SC은행"
    self.name = name
    # 계좌번호가 001-01-000001 일 경우 빈 자릿수를 0으로 채우는 기능도 예시 답안에는 구현되어 있습니다. 저는 예시를 보고 해서 혼자 이렇게 하라면 시간이 걸렸을 것 같습니다. 참고 바랍니다.
    # https://wikidocs.net/7037
    self.account = f"{r.randint(100, 999)}-{r.randint(10,99)}-{r.randint(100000,999999)}"
    self.balance = balance
    self.deposit_count = 0
    self.deposit_list = []
    self.withdraw_list = []
    Account.total_accounts += 1

  def get_account_num(self):
    print(f'생성된 계좌의 총 개수: {Account.total_accounts}개')

  def deposit(self, amount): #amount : 입금액
    if amount >= 1:
      self.balance += amount #balance : 잔액
      self.deposit_list.append(f'{len(self.deposit_list)+1}회: 입금\t금액: {amount}\t잔액: {self.balance}')
      self.deposit_count += 1

      if self.deposit_count % 5 == 0:
        interest = math.floor(self.balance * 0.01)
        self.balance += interest
        print(f'입금 횟수가 {self.deposit_count}회가 되어 {interest}의 이자가 입급되었습니다.')
        self.deposit_list.append(f'{len(self.deposit_list)+1}회: 이자지급\t금액: {interest}\t잔액: {self.balance}')
    else:
      print('입금은 최소 1원 이상만 가능합니다.')

  def withdraw(self, amount):
    if amount <= self.balance:
      self.balance -= amount
      self.withdraw_list.append(f'{len(self.deposit_list)+1}회: 출금\t금액: {amount}\t잔액: {self.balance}')
      print(f'출금이 완료되었습니다. 현재 잔고: {self.balance}\n')
    else:
      print(f'계좌 잔고 이상으로 출금할 수 없습니다. 현재 잔고: {self.balance}')


  def display_info(self):
    print(f'은행이름: {self.bank_name}, 예금주: {self.name}, 계좌번호: {self.account}, 잔고: {self.balance:,}원')


  def deposit_history(self):
    for i in range(len(self.deposit_list)):
      print(self.deposit_list[i])


  def withdraw_history(self):
    for i in range(len(self.withdraw_list)):
      print(self.withdraw_list[i])


first_account = Account('김해원', 10000000)
second_account = Account('김철수', 10000)
third_account = Account('이영희', 10000000000)
forth_account = Account('이영희', 10000000000)
fifth_account = Account('이영희', 10000000000)


accounts = [first_account, second_account, third_account]

third_account.get_account_num()
for account in accounts:
    if account.balance >= 1000000:
        account.display_info()
print()

my_account = Account('김혜원', 1000)

for i in range(10):
  my_account.deposit(1000)
my_account.deposit(-1000)
my_account.withdraw(3000000)
my_account.withdraw(3000)
print()

my_account.deposit_history()
print('-'*50)
my_account.withdraw_history()
