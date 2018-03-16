#!/usr/bin/env python

from distutils.core import setup

setup(name='pkcrypt',
      version='0.1.0',
      description='public key cryptography',
      author='Joel Ward',
      author_email='jmward@gmail.com',
      url='https://github.com/val-labs/pkcrypt/tree/master/pkcrypt',
      packages=['pkcrypt'],
      scripts=['bin/pkcrypt','bin/pkdcrypt','bin/pkecrypt'],
     )
