class Thing:
    def thing(self) -> int:
        return 2


class Container:
    thing: Thing

    def func(self) -> int:
        return self.thing.thing()


def greet(name: str) -> str:
    return f"Hello, {name}"


result = greet("world")
print(result)

thing = Thing()

thing.thing()
thing.thing()
