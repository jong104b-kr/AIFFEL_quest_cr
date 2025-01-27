# Account 클래스
# 생성자 - 은행 이름, 예금주, 잔액, 입출금 내역 기록 리스트
# 은행 - SC은행, 계좌번호- 3자리-2자리-6자리 랜덤 생성 (은행이름: SC은행, 계좌번호: 111-11-111111)

import random as r, math

# Q1 Account 클래스
class Account():
    cnt_accounts = 0 # 생성된 계좌 개수
    cnt_transaction = 0 # 입출금(이자 지급 포함) 거래 횟수

    def __init__(self, holder, balance):
        self.bank = "SC은행" # 은행 이름
        self.holder = holder # 예금주
        # 계좌번호가 001-01-000001 일 경우 빈 자릿수를 0으로 채우는 기능도 예시 답안에는 구현되어 있습니다. 저는 예시를 보고 해서 혼자 이렇게 하라면 시간이 걸렸을 것 같습니다. 참고 바랍니다.
        # https://wikidocs.net/7037
        self.account_num = f'{r.randint(100,999)}-{r.randint(10,99)}-{r.randint(100000,999999)}' # 계좌번호
        self.balance = balance # 잔액
        self.dep_history = [] # 입금 내역 기록용
        self.wd_history = [] # 출금 내역 기록용
        self.cnt_deposit = 0

        #Q2 클래스 변수
        Account.cnt_accounts += 1

    #Q3 클래스 변수 출력
    @classmethod
    def get_account_num(cls):
        print("생성된 계좌의 총 개수: ", cls.cnt_accounts) # 데코레이터 활용한 cls 매개변수 전달, 클래스 변수, https://wwhitelife.tistory.com/188 참고

    #Q4 입금 메서드, Q7. 이자 지급하기
    def deposit(self, money):
        if money < 1:
            print('입금은 최소 1원 이상만 가능합니다. ')
            return

        Account.cnt_transaction += 1
        self.cnt_deposit += 1
        self.balance += money
        self.dep_history.append((Account.cnt_transaction, '입금', money, self.balance))

        if self.cnt_deposit % 5 == 0:
            Account.cnt_transaction += 1 # 이자 지급시 입출금 내역 횟수 한번 더해줌
            interest = math.floor(self.balance * 0.01)
            self.balance += interest
            self.dep_history.append((Account.cnt_transaction, '이자지급', interest, self.balance))
            print(f'{interest}의 이자가 입금되었습니다.')

    # Q5 출금 메서드
    def withdraw(self, money):

        if money <= 0:
            print("출금은 0원 이상이어야 합니다.") # x > 0 이면 초과라고 한다고 배웠습니다.
            return

        if self.balance < money:
            print('계좌 잔고 이상으로 출금할 수 없습니다. ')
            return
        Account.cnt_transaction += 1
        self.balance -= money
        self.wd_history.append((Account.cnt_transaction, '출금', money, self.balance))

    # Q6 정보 출력 메서드
    def display_info(self):
        print(f'은행 이름: {self.bank}, 예금주: {self.holder}, 계좌번호: {self.account_num}, 잔고: {format(self.balance, ",d")}원')

    # Q10 입금 내역 기록
    def deposit_history(self):
        for cnt, history_type, money, balance in self.dep_history:
            print(f'{cnt}회:{history_type:<10}금액:{money:<10}잔액:{balance}')

    def withdraw_history(self):
        for cnt, history_type, money, balance in self.wd_history:
            print(f'{cnt}회:{history_type:<10}금액:{money:<10}잔액:{balance}')


# 채점 기준) Account 클래스로부터 생성된 계좌의 개수 출력, 잔고 100만원 이상 고객 정보만 출력
# Q8 여러 객체 생성
# Q9 잔고가 100만원 이상인 고객의 정보만 출력

first_account = Account('차정은', 1000)
second_account = Account('박광석', 30000000)
third_account = Account('조웅제', 50000000)

accounts = [first_account, second_account, third_account]

Account.get_account_num()
for account in accounts:
    if account.balance >= 1000000:
        account.display_info()

print()
#############################################

# 채점 기준) 입금 메서드, 출금 메서드, 이자 지급 기능 완성
my_account = Account('차정은', 1000)
for i in range(10):
    my_account.deposit(1000)
my_account.deposit(-1000)
my_account.withdraw(3000000)
my_account.withdraw(3000)

print()
#############################################

# 채점 기준) 입금과 출금 내역 출력에 성공
my_account.deposit_history()
print('-'*50)
my_account.withdraw_history()
