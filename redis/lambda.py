from conection_redis import store_token_in_redis, get_token_from_redis

def get_secret():
  return "1234"


def expire_in(ttl):
  return round(ttl * 0.9)


def get_token_for_redis():
  token = get_token_from_redis()
  if token is None:
    token = get_secret()
    store_token_in_redis(token, expire_in(120))
  return token

def main():
    print("TOKEN {}".format(get_token_for_redis()))


if __name__ == "__main__":
    main()