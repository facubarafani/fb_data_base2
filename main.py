import redis
r = redis.Redis(
    host='localhost',
    port=9000,)
r.set('xd','ndea')
r.append('hola','xaaaaaa')
print(r.get('hola'))
print(r.get('xd'))