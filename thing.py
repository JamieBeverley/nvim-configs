x = 4
from functools import lru_cache


@lru_cache
def ys(thing: str):
    return thing + 2


print("hello")
