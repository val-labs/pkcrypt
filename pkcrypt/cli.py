#!/usr/bin/env python
from pkcrypt import *

def cli(argv=sys.argv):
    eol, fname = '\n', ''

    def getarg2(name):
        try:
            if sys.argv[2] == name:
                sys.argv.pop(2)
                return 1
        except:
            return

    def output(msg):
        with open(fname,'w') if fname else sys.stdout as f:
            f.write(msg + eol)

    if getarg2('-no'): eol = ''; fname = sys.argv.pop(2)
    if getarg2('-n'):  eol = ''
    if getarg2('-o'):            fname = sys.argv.pop(2)

    if   sys.argv[1] == 'gensk':
        output(sk2str(gen_sk()))

    elif sys.argv[1] == 'getvk':
        output(vk2str(get_vk(fload_sk())))
        
    elif sys.argv[1] == 'genkey':
        output('%s\n%s' % gen_keys())
    
    elif sys.argv[1] == 'sign':
        output(sig2str(sign_with(fload_sk(), load_msg())))

    elif sys.argv[1] == 'verify':
        if invalid_sig(fload_vk(), load_sig(), load_msg()):
            print("NOT VALID")
            exit(1)
      
    else:
        print("BAD ARGS")
        raise exit(2)

if __name__ == '__main__': cli()
