import redis


def conect():
  redis_host = "localhost"
  redis_port = "6379"
  redis_password = "Redis2019!"
  
  return redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)

def store_token_in_redis(token, token_ttl):
  r = conect()
  try:
    r.setex("sts_token", token_ttl, token)
  except redis.exceptions.ConnectionError as e:
    raise e


def get_token_from_redis():
  r = conect()
  try:
    token = r.get("sts_token")
  except redis.exceptions.ConnectionError as e:
    raise e

  return token

