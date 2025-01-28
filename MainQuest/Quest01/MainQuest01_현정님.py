import random

class Account:
    account_count = 0  # 총 계좌 개수를 세요

    def __init__(self, name, balance):
        self.name = name
        self.balance = balance
        self.bank = "SC은행"
        # 계좌번호가 001-01-000001 일 경우 빈 자릿수를 0으로 채우는 기능도 예시 답안에는 구현되어 있습니다. 저는 예시를 보고 해서 혼자 이렇게 하라면 시간이 걸렸을 것 같습니다. 참고 바랍니다.
        # https://wikidocs.net/7037
        self.account_number = f"{random.randint(0, 999):03}-{random.randint(0, 99):02}-{random.randint(0, 999999):06}"
        self.transaction_log = []
        Account.account_count += 1

    @classmethod
    def get_account_num(cls):
        print(f"총 계좌 개수: {cls.account_count}")

    def deposit(self, amount):
        if amount >= 1:
            self.balance += amount
            self.transaction_log.append(("입금", amount, self.balance))
            print(f"{amount:,}원이 입금되었습니다. 잔액: {self.balance:,}원")
        else:
            print("입금은 최소 1원 이상만 가능합니다.")

    def withdraw(self, amount):
        if amount <= self.balance:
            self.balance -= amount
            self.transaction_log.append(("출금", amount, self.balance))
            print(f"{amount:,}원이 출금되었습니다. 잔액: {self.balance:,}원")
        else:
            print("잔액이 부족합니다.")

    def add_interest(self, rate):
        interest = round(self.balance * rate / 100)  # round를 사용해 정확한 계산
        self.balance += interest
        self.transaction_log.append(("이자지급", interest, self.balance))
        print(f"{interest:,}원의 이자가 지급되었습니다. 잔액: {self.balance:,}원")

    def display_info(self):
        print(f"은행: {self.bank}, 예금주: {self.name}, 계좌번호: {self.account_number}, 잔액: {self.balance:,.0f}원")

    def show_transactions(self):
        print("거래 내역:")
        for i, (t_type, amount, balance) in enumerate(self.transaction_log, 1):
            print(f"{i}회: {t_type:<8} 금액: {amount:<6,} 잔액: {balance:<6,}")

if __name__ == "__main__":
    my_account = Account('차정은', 1000)

    # 입금 5회
    for _ in range(5):
        my_account.deposit(1000)

    # 이자 지급 (6%)
    my_account.add_interest(6)

    # 입금 4회 (조정)
    for _ in range(4):
        my_account.deposit(1000)

    # 출금 3,000원 (조정 후 이자 지급 전 수행)
    my_account.withdraw(3000)

    # 이자 지급 (11%)
    my_account.add_interest(11)

    # 거래 내역 출력
    my_account.show_transactions()

    print('-' * 50)
    my_account.display_info()

    # 계좌 리스트 생성
    account_list = [
        Account('박광석', 30000000),
        Account('조웅제', 50000000),
        my_account
    ]

    # 100만원 이상 계좌 정보 리스트 출력
    print("\n100만원 이상 계좌 정보:")
    filtered_accounts = [account for account in account_list if account.balance >= 1000000]
    for account in filtered_accounts:
        account.display_info()
