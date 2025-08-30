x = 4
from functools import lru_cache


@lru_cache
def ys(thing: str):
    return thing + 2


print("hello")

thing = {
    "fdsa": "fdsa",
    "asdf": "asdf",
    "qwer": "qwer",
    "ytre": "ytre",
}


class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def greet(self):
        print(f"Hello, my name is {self.name} and I am {self.age} years old.")
