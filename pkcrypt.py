#!/usr/bin/env python
"""
pkcrypt - public key cryptography
"""
import os, sys, json, time, datetime, traceback as tb
from fastecdsa import ecdsa, keys, curve
from fastecdsa.point import Point

def _str2sk((t, sk)):      return int(sk,16)
def str2sk (st):           return _str2sk(st.split(','))
def sk2str ((sk)):         return "P,%x" % (sk)

def _str2vk((t, x, y)):    return Point(int(x,16), int(y,16), curve.P256)
def str2vk (st):           return _str2vk(st.split(','))
def vk2str ((vk)):         return "V,%x,%x" % (vk.x, vk.y)

def _str2sig((t, r, s)):   return int(r,16), int(s,16)
def str2sig (st):          return _str2sig(st.split(','))
def sig2str ((r, s)):      return "S,%x,%x" % (r, s)

def gen_sk():   return ( keys.gen_private_key(curve.P256) )
def get_vk(sk): return ( keys.get_public_key(sk, curve.P256) )

def load_sk (f=sys.stdin): return str2sk( f.readlines()[-1])
def load_vk (f=sys.stdin): return str2vk( f.readline())
def load_sig(f=sys.stdin): return str2sig(f.readline ())
def load_msg(f=sys.stdin): return ''.join(f.readlines())

def fload_sk (fn=''):       return load_sk( open(fn or sys.argv[2]) )
def fload_vk (fn=''):       return load_vk( open(fn or sys.argv[2]) )

def sign_with  (sk,      msg): return ecdsa.sign(msg, sk)
def valid_sig  (vk, sig, msg): return ecdsa.verify(sig, msg, vk)
def invalid_sig(vk, sig, msg): return not valid_sig(vk, sig, msg)

def main():
    if   sys.argv[1] == 'gensk':
        print(sk2str(gen_sk()))

    elif sys.argv[1] == 'genvk':
        print(vk2str(get_vk(fload_sk())))
        
    elif sys.argv[1] == 'sign':
        print(sig2str(sign_with(fload_sk(), load_msg())))

    elif sys.argv[1] == 'verify':
        if invalid_sig(fload_vk(), load_sig(), load_msg()):
            print("NOT VALID")
            exit(1)
       
    else:
        print("BAD ARGS")
        raise exit(2)

if __name__ == '__main__': main()
