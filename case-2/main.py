class Employee:
    def __init__(self, name, base_salary):
        self.name = name
        self.base_salary = base_salary

    def role(self):
        return "Employee"

    def monthly_income(self):
        return self.base_salary

    def describe(self):
        return f"{self.role()}: {self.name}"

    def work(self):
        return f"{self.name} works"


class Developer(Employee):
    def __init__(self, name, base_salary, level, bonus):
        super().__init__(name, base_salary)
        self.level = level
        self.bonus = bonus

    def role(self):
        return f"Developer ({self.level})"

    def monthly_income(self):
        return self.base_salary + self.bonus

    def work(self):
        return f"{self.name} writes code"

    def write_code(self):
        return f"{self.name} implements a feature"


class Manager(Employee):
    def __init__(self, name, base_salary, team_size, bonus):
        super().__init__(name, base_salary)
        self.team_size = team_size
        self.bonus = bonus

    def role(self):
        return f"Manager (team {self.team_size})"

    def monthly_income(self):
        return self.base_salary + self.bonus

    def work(self):
        return f"{self.name} manages the team"

    def plan(self):
        return f"{self.name} plans the sprint"


def main():
    staff = [
        Employee("Alex", 70000),
        Developer("Nina", 120000, "Middle", 15000),
        Manager("Olga", 130000, 5, 20000),
    ]

    for person in staff:
        print(person.describe())
        print(person.monthly_income())
        print(person.work())
        print("---")

    developer = staff[1]
    manager = staff[2]
    print(developer.write_code())
    print(manager.plan())


if __name__ == "__main__":
    main()
