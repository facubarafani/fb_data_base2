import redis
r = redis.Redis(
    host='localhost',
    port=9000,)

print(r.get('hola'))