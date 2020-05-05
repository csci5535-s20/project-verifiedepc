#include "s1_setup_test2.h"

#include <sstream>
#include <algorithm>

#include <iostream>
#include <stdlib.h>
#include <sys/types.h>          /* See NOTES */
#include <sys/stat.h>
#include <fcntl.h>
#ifdef _WIN32
#include <winsock2.h>
#include <WS2tcpip.h>
#include <io.h>
#define isatty _isatty
#else
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h> 
#include <sys/select.h>
#include <unistd.h>
#define _open open
#define _dup2 dup2
#endif
#include <string.h>
#include <stdio.h>
#include <string>
#if __cplusplus < 201103L
#else
#include <cstdint>
#endif
typedef s1_setup_test2 ivy_class;
std::ofstream __ivy_out;
std::ofstream __ivy_modelfile;
void __ivy_exit(int code){exit(code);}

class reader {
public:
    virtual int fdes() = 0;
    virtual void read() = 0;
    virtual void bind() {}
    virtual bool running() {return fdes() >= 0;}
    virtual ~reader() {}
};

class timer {
public:
    virtual int ms_delay() = 0;
    virtual void timeout(int) = 0;
    virtual ~timer() {}
};

#ifdef _WIN32
DWORD WINAPI ReaderThreadFunction( LPVOID lpParam ) 
{
    reader *cr = (reader *) lpParam;
    cr->bind();
    while (true)
        cr->read();
    return 0;
} 

DWORD WINAPI TimerThreadFunction( LPVOID lpParam ) 
{
    timer *cr = (timer *) lpParam;
    while (true) {
        int ms = cr->ms_delay();
        Sleep(ms);
        cr->timeout(ms);
    }
    return 0;
} 
#else
void * _thread_reader(void *rdr_void) {
    reader *rdr = (reader *) rdr_void;
    rdr->bind();
    while(rdr->running()) {
        rdr->read();
    }
    delete rdr;
    return 0; // just to stop warning
}

void * _thread_timer( void *tmr_void ) 
{
    timer *tmr = (timer *) tmr_void;
    while (true) {
        int ms = tmr->ms_delay();
        struct timespec ts;
        ts.tv_sec = ms/1000;
        ts.tv_nsec = (ms % 1000) * 1000000;
        nanosleep(&ts,NULL);
        tmr->timeout(ms);
    }
    return 0;
} 
#endif 

void s1_setup_test2::install_reader(reader *r) {
    #ifdef _WIN32

        DWORD dummy;
        HANDLE h = CreateThread( 
            NULL,                   // default security attributes
            0,                      // use default stack size  
            ReaderThreadFunction,   // thread function name
            r,                      // argument to thread function 
            0,                      // use default creation flags 
            &dummy);                // returns the thread identifier 
        if (h == NULL) {
            std::cerr << "failed to create thread" << std::endl;
            exit(1);
        }
        thread_ids.push_back(h);
    #else
        pthread_t thread;
        int res = pthread_create(&thread, NULL, _thread_reader, r);
        if (res) {
            std::cerr << "failed to create thread" << std::endl;
            exit(1);
        }
        thread_ids.push_back(thread);
    #endif
}      

void s1_setup_test2::install_thread(reader *r) {
    install_reader(r);
}

void s1_setup_test2::install_timer(timer *r) {
    #ifdef _WIN32

        DWORD dummy;
        HANDLE h = CreateThread( 
            NULL,                   // default security attributes
            0,                      // use default stack size  
            TimersThreadFunction,   // thread function name
            r,                      // argument to thread function 
            0,                      // use default creation flags 
            &dummy);                // returns the thread identifier 
        if (h == NULL) {
            std::cerr << "failed to create thread" << std::endl;
            exit(1);
        }
        thread_ids.push_back(h);
    #else
        pthread_t thread;
        int res = pthread_create(&thread, NULL, _thread_timer, r);
        if (res) {
            std::cerr << "failed to create thread" << std::endl;
            exit(1);
        }
        thread_ids.push_back(thread);
    #endif
}      


#ifdef _WIN32
    void s1_setup_test2::__lock() { WaitForSingleObject(mutex,INFINITE); }
    void s1_setup_test2::__unlock() { ReleaseMutex(mutex); }
#else
    void s1_setup_test2::__lock() { pthread_mutex_lock(&mutex); }
    void s1_setup_test2::__unlock() { pthread_mutex_unlock(&mutex); }
#endif

/*++
Copyright (c) Microsoft Corporation

This string hash function is borrowed from Microsoft Z3
(https://github.com/Z3Prover/z3). 

--*/


#define mix(a,b,c)              \
{                               \
  a -= b; a -= c; a ^= (c>>13); \
  b -= c; b -= a; b ^= (a<<8);  \
  c -= a; c -= b; c ^= (b>>13); \
  a -= b; a -= c; a ^= (c>>12); \
  b -= c; b -= a; b ^= (a<<16); \
  c -= a; c -= b; c ^= (b>>5);  \
  a -= b; a -= c; a ^= (c>>3);  \
  b -= c; b -= a; b ^= (a<<10); \
  c -= a; c -= b; c ^= (b>>15); \
}

#ifndef __fallthrough
#define __fallthrough
#endif

namespace hash_space {

// I'm using Bob Jenkin's hash function.
// http://burtleburtle.net/bob/hash/doobs.html
unsigned string_hash(const char * str, unsigned length, unsigned init_value) {
    register unsigned a, b, c, len;

    /* Set up the internal state */
    len = length;
    a = b = 0x9e3779b9;  /* the golden ratio; an arbitrary value */
    c = init_value;      /* the previous hash value */

    /*---------------------------------------- handle most of the key */
    while (len >= 12) {
        a += reinterpret_cast<const unsigned *>(str)[0];
        b += reinterpret_cast<const unsigned *>(str)[1];
        c += reinterpret_cast<const unsigned *>(str)[2];
        mix(a,b,c);
        str += 12; len -= 12;
    }

    /*------------------------------------- handle the last 11 bytes */
    c += length;
    switch(len) {        /* all the case statements fall through */
    case 11: 
        c+=((unsigned)str[10]<<24);
        __fallthrough;
    case 10: 
        c+=((unsigned)str[9]<<16);
        __fallthrough;
    case 9 : 
        c+=((unsigned)str[8]<<8);
        __fallthrough;
        /* the first byte of c is reserved for the length */
    case 8 : 
        b+=((unsigned)str[7]<<24);
        __fallthrough;
    case 7 : 
        b+=((unsigned)str[6]<<16);
        __fallthrough;
    case 6 : 
        b+=((unsigned)str[5]<<8);
        __fallthrough;
    case 5 : 
        b+=str[4];
        __fallthrough;
    case 4 : 
        a+=((unsigned)str[3]<<24);
        __fallthrough;
    case 3 : 
        a+=((unsigned)str[2]<<16);
        __fallthrough;
    case 2 : 
        a+=((unsigned)str[1]<<8);
        __fallthrough;
    case 1 : 
        a+=str[0];
        __fallthrough;
        /* case 0: nothing left to add */
    }
    mix(a,b,c);
    /*-------------------------------------------- report the result */
    return c;
}

}




struct ivy_value {
    int pos;
    std::string atom;
    std::vector<ivy_value> fields;
    bool is_member() const {
        return atom.size() && fields.size();
    }
};
struct deser_err {
};

struct ivy_ser {
    virtual void  set(long long) = 0;
    virtual void  set(bool) = 0;
    virtual void  setn(long long inp, int len) = 0;
    virtual void  set(const std::string &) = 0;
    virtual void  open_list(int len) = 0;
    virtual void  close_list() = 0;
    virtual void  open_list_elem() = 0;
    virtual void  close_list_elem() = 0;
    virtual void  open_struct() = 0;
    virtual void  close_struct() = 0;
    virtual void  open_field(const std::string &) = 0;
    virtual void  close_field() = 0;
    virtual void  open_tag(int, const std::string &) {throw deser_err();}
    virtual void  close_tag() {}
    virtual ~ivy_ser(){}
};
struct ivy_binary_ser : public ivy_ser {
    std::vector<char> res;
    void setn(long long inp, int len) {
        for (int i = len-1; i >= 0 ; i--)
            res.push_back((inp>>(8*i))&0xff);
    }
    void set(long long inp) {
        setn(inp,sizeof(long long));
    }
    void set(bool inp) {
        set((long long)inp);
    }
    void set(const std::string &inp) {
        for (unsigned i = 0; i < inp.size(); i++)
            res.push_back(inp[i]);
        res.push_back(0);
    }
    void open_list(int len) {
        set((long long)len);
    }
    void close_list() {}
    void open_list_elem() {}
    void close_list_elem() {}
    void open_struct() {}
    void close_struct() {}
    virtual void  open_field(const std::string &) {}
    void close_field() {}
    virtual void  open_tag(int tag, const std::string &) {
        set((long long)tag);
    }
    virtual void  close_tag() {}
};

struct ivy_deser {
    virtual void  get(long long&) = 0;
    virtual void  get(std::string &) = 0;
    virtual void  getn(long long &res, int bytes) = 0;
    virtual void  open_list() = 0;
    virtual void  close_list() = 0;
    virtual bool  open_list_elem() = 0;
    virtual void  close_list_elem() = 0;
    virtual void  open_struct() = 0;
    virtual void  close_struct() = 0;
    virtual void  open_field(const std::string &) = 0;
    virtual void  close_field() = 0;
    virtual int   open_tag(const std::vector<std::string> &) {throw deser_err();}
    virtual void  close_tag() {}
    virtual void  end() = 0;
    virtual ~ivy_deser(){}
};

struct ivy_binary_deser : public ivy_deser {
    std::vector<char> inp;
    int pos;
    std::vector<int> lenstack;
    ivy_binary_deser(const std::vector<char> &inp) : inp(inp),pos(0) {}
    virtual bool more(unsigned bytes) {return inp.size() >= pos + bytes;}
    virtual bool can_end() {return pos == inp.size();}
    void get(long long &res) {
       getn(res,8);
    }
    void getn(long long &res, int bytes) {
        if (!more(bytes))
            throw deser_err();
        res = 0;
        for (int i = 0; i < bytes; i++)
            res = (res << 8) | (((long long)inp[pos++]) & 0xff);
    }
    void get(std::string &res) {
        while (more(1) && inp[pos]) {
//            if (inp[pos] == '"')
//                throw deser_err();
            res.push_back(inp[pos++]);
        }
        if(!(more(1) && inp[pos] == 0))
            throw deser_err();
        pos++;
    }
    void open_list() {
        long long len;
        get(len);
        lenstack.push_back(len);
    }
    void close_list() {
        lenstack.pop_back();
    }
    bool open_list_elem() {
        return lenstack.back();
    }
    void close_list_elem() {
        lenstack.back()--;
    }
    void open_struct() {}
    void close_struct() {}
    virtual void  open_field(const std::string &) {}
    void close_field() {}
    int open_tag(const std::vector<std::string> &tags) {
        long long res;
        get(res);
        if (res >= tags.size())
            throw deser_err();
        return res;
    }
    void end() {
        if (!can_end())
            throw deser_err();
    }
};
struct ivy_socket_deser : public ivy_binary_deser {
      int sock;
    public:
      ivy_socket_deser(int sock, const std::vector<char> &inp)
          : ivy_binary_deser(inp), sock(sock) {}
    virtual bool more(unsigned bytes) {
        while (inp.size() < pos + bytes) {
            int oldsize = inp.size();
            int get = pos + bytes - oldsize;
            get = (get < 1024) ? 1024 : get;
            inp.resize(oldsize + get);
            int newbytes;
	    if ((newbytes = read(sock,&inp[oldsize],get)) < 0)
		 { std::cerr << "recvfrom failed\n"; exit(1); }
            inp.resize(oldsize + newbytes);
            if (newbytes == 0)
                 return false;
        }
        return true;
    }
    virtual bool can_end() {return true;}
};

struct out_of_bounds {
    std::string txt;
    int pos;
    out_of_bounds(int _idx, int pos = 0) : pos(pos){
        std::ostringstream os;
        os << "argument " << _idx+1;
        txt = os.str();
    }
    out_of_bounds(const std::string &s, int pos = 0) : txt(s), pos(pos) {}
};

template <class T> T _arg(std::vector<ivy_value> &args, unsigned idx, long long bound);
template <class T> T __lit(const char *);

template <>
bool _arg<bool>(std::vector<ivy_value> &args, unsigned idx, long long bound) {
    if (!(args[idx].atom == "true" || args[idx].atom == "false") || args[idx].fields.size())
        throw out_of_bounds(idx,args[idx].pos);
    return args[idx].atom == "true";
}

template <>
int _arg<int>(std::vector<ivy_value> &args, unsigned idx, long long bound) {
    std::istringstream s(args[idx].atom.c_str());
    s.unsetf(std::ios::dec);
    s.unsetf(std::ios::hex);
    s.unsetf(std::ios::oct);
    long long res;
    s  >> res;
    // int res = atoi(args[idx].atom.c_str());
    if (bound && (res < 0 || res >= bound) || args[idx].fields.size())
        throw out_of_bounds(idx,args[idx].pos);
    return res;
}

template <>
long long _arg<long long>(std::vector<ivy_value> &args, unsigned idx, long long bound) {
    std::istringstream s(args[idx].atom.c_str());
    s.unsetf(std::ios::dec);
    s.unsetf(std::ios::hex);
    s.unsetf(std::ios::oct);
    long long res;
    s  >> res;
//    long long res = atoll(args[idx].atom.c_str());
    if (bound && (res < 0 || res >= bound) || args[idx].fields.size())
        throw out_of_bounds(idx,args[idx].pos);
    return res;
}

template <>
unsigned long long _arg<unsigned long long>(std::vector<ivy_value> &args, unsigned idx, long long bound) {
    std::istringstream s(args[idx].atom.c_str());
    s.unsetf(std::ios::dec);
    s.unsetf(std::ios::hex);
    s.unsetf(std::ios::oct);
    unsigned long long res;
    s  >> res;
//    unsigned long long res = atoll(args[idx].atom.c_str());
    if (bound && (res < 0 || res >= bound) || args[idx].fields.size())
        throw out_of_bounds(idx,args[idx].pos);
    return res;
}

template <>
unsigned _arg<unsigned>(std::vector<ivy_value> &args, unsigned idx, long long bound) {
    std::istringstream s(args[idx].atom.c_str());
    s.unsetf(std::ios::dec);
    s.unsetf(std::ios::hex);
    s.unsetf(std::ios::oct);
    unsigned res;
    s  >> res;
//    unsigned res = atoll(args[idx].atom.c_str());
    if (bound && (res < 0 || res >= bound) || args[idx].fields.size())
        throw out_of_bounds(idx,args[idx].pos);
    return res;
}


std::ostream &operator <<(std::ostream &s, const __strlit &t){
    s << "\"" << t.c_str() << "\"";
    return s;
}

template <>
__strlit _arg<__strlit>(std::vector<ivy_value> &args, unsigned idx, long long bound) {
    if (args[idx].fields.size())
        throw out_of_bounds(idx,args[idx].pos);
    return args[idx].atom;
}

template <class T> void __ser(ivy_ser &res, const T &inp);

template <>
void __ser<int>(ivy_ser &res, const int &inp) {
    res.set((long long)inp);
}

template <>
void __ser<long long>(ivy_ser &res, const long long &inp) {
    res.set(inp);
}

template <>
void __ser<unsigned long long>(ivy_ser &res, const unsigned long long &inp) {
    res.set((long long)inp);
}

template <>
void __ser<unsigned>(ivy_ser &res, const unsigned &inp) {
    res.set((long long)inp);
}

template <>
void __ser<bool>(ivy_ser &res, const bool &inp) {
    res.set(inp);
}

template <>
void __ser<__strlit>(ivy_ser &res, const __strlit &inp) {
    res.set(inp);
}

template <class T> void __deser(ivy_deser &inp, T &res);

template <>
void __deser<int>(ivy_deser &inp, int &res) {
    long long temp;
    inp.get(temp);
    res = temp;
}

template <>
void __deser<long long>(ivy_deser &inp, long long &res) {
    inp.get(res);
}

template <>
void __deser<unsigned long long>(ivy_deser &inp, unsigned long long &res) {
    long long temp;
    inp.get(temp);
    res = temp;
}

template <>
void __deser<unsigned>(ivy_deser &inp, unsigned &res) {
    long long temp;
    inp.get(temp);
    res = temp;
}

template <>
void __deser<__strlit>(ivy_deser &inp, __strlit &res) {
    inp.get(res);
}

template <>
void __deser<bool>(ivy_deser &inp, bool &res) {
    long long thing;
    inp.get(thing);
    res = thing;
}

class gen;

std::ostream &operator <<(std::ostream &s, const s1_setup_test2::drx_enum &t);
template <>
s1_setup_test2::drx_enum _arg<s1_setup_test2::drx_enum>(std::vector<ivy_value> &args, unsigned idx, long long bound);
template <>
void  __ser<s1_setup_test2::drx_enum>(ivy_ser &res, const s1_setup_test2::drx_enum&);
template <>
void  __deser<s1_setup_test2::drx_enum>(ivy_deser &inp, s1_setup_test2::drx_enum &res);
std::ostream &operator <<(std::ostream &s, const s1_setup_test2::message_enum &t);
template <>
s1_setup_test2::message_enum _arg<s1_setup_test2::message_enum>(std::vector<ivy_value> &args, unsigned idx, long long bound);
template <>
void  __ser<s1_setup_test2::message_enum>(ivy_ser &res, const s1_setup_test2::message_enum&);
template <>
void  __deser<s1_setup_test2::message_enum>(ivy_deser &inp, s1_setup_test2::message_enum &res);
std::ostream &operator <<(std::ostream &s, const s1_setup_test2::supported_ta &t);
template <>
s1_setup_test2::supported_ta _arg<s1_setup_test2::supported_ta>(std::vector<ivy_value> &args, unsigned idx, long long bound);
template <>
void  __ser<s1_setup_test2::supported_ta>(ivy_ser &res, const s1_setup_test2::supported_ta&);
template <>
void  __deser<s1_setup_test2::supported_ta>(ivy_deser &inp, s1_setup_test2::supported_ta &res);
        template <typename T>
        T __array_segment(const T &a, long long lo, long long hi) {
            T res;
            lo = (lo < 0) ? 0 : lo;
            hi = (hi > a.size()) ? a.size() : hi;
            if (hi > lo) {
                res.resize(hi-lo);
                std::copy(a.begin()+lo,a.begin()+hi,res.begin());
            }
            return res;
        }
        	    std::ostream &operator <<(std::ostream &s, const s1_setup_test2::supported_ta__arr &a) {
	        s << '[';
		for (unsigned i = 0; i < a.size(); i++) {
		    if (i != 0)
		        s << ',';
		    s << a[i];
		}
	        s << ']';
		return s;
            }

	    template <>
	    s1_setup_test2::supported_ta__arr _arg<s1_setup_test2::supported_ta__arr>(std::vector<ivy_value> &args, unsigned idx, long long bound) {
	        ivy_value &arg = args[idx];
	        if (arg.atom.size()) 
	            throw out_of_bounds(idx);
	        s1_setup_test2::supported_ta__arr a;
	        a.resize(arg.fields.size());
		for (unsigned i = 0; i < a.size(); i++) {
		    a[i] = _arg<s1_setup_test2::supported_ta>(arg.fields,i,0);
	        }
	        return a;
	    }

	    template <>
	    void __deser<s1_setup_test2::supported_ta__arr>(ivy_deser &inp, s1_setup_test2::supported_ta__arr &res) {
	        inp.open_list();
	        while(inp.open_list_elem()) {
		    res.resize(res.size()+1);
	            __deser(inp,res.back());
		    inp.close_list_elem();
                }
		inp.close_list();
	    }

	    template <>
	    void __ser<s1_setup_test2::supported_ta__arr>(ivy_ser &res, const s1_setup_test2::supported_ta__arr &inp) {
	        int sz = inp.size();
	        res.open_list(sz);
	        for (unsigned i = 0; i < (unsigned)sz; i++) {
		    res.open_list_elem();
	            __ser(res,inp[i]);
		    res.close_list_elem();
                }
	        res.close_list();
	    }

	    #ifdef Z3PP_H_
	    template <>
            z3::expr __to_solver(gen& g, const z3::expr& z3val, s1_setup_test2::supported_ta__arr& val) {
	        z3::expr z3end = g.apply("supported_ta.arr.end",z3val);
	        z3::expr __ret = z3end  == g.int_to_z3(z3end.get_sort(),val.size());
	        unsigned __sz = val.size();
	        for (unsigned __i = 0; __i < __sz; ++__i)
		    __ret = __ret && __to_solver(g,g.apply("supported_ta.arr.value",z3val,g.int_to_z3(g.sort("supported_ta.idx"),__i)),val[__i]);
                return __ret;
            }

	    template <>
	    void  __from_solver<s1_setup_test2::supported_ta__arr>( gen &g, const  z3::expr &v,s1_setup_test2::supported_ta__arr &res){
	        unsigned long long __end;
	        __from_solver(g,g.apply("supported_ta.arr.end",v),__end);
	        unsigned __sz = (unsigned) __end;
	        res.resize(__sz);
	        for (unsigned __i = 0; __i < __sz; ++__i)
		    __from_solver(g,g.apply("supported_ta.arr.value",v,g.int_to_z3(g.sort("supported_ta.idx"),__i)),res[__i]);
	    }

	    template <>
	    void  __randomize<s1_setup_test2::supported_ta__arr>( gen &g, const  z3::expr &v){
	        unsigned __sz = rand() % 4;
                z3::expr val_expr = g.int_to_z3(g.sort("supported_ta.idx"),__sz);
                z3::expr pred =  g.apply("supported_ta.arr.end",v) == val_expr;
                g.add_alit(pred);
	        for (unsigned __i = 0; __i < __sz; ++__i)
	            __randomize<s1_setup_test2::supported_ta>(g,g.apply("supported_ta.arr.value",v,g.int_to_z3(g.sort("supported_ta.idx"),__i)));
	    }
	    #endif

	int s1_setup_test2::___ivy_choose(int rng,const char *name,int id) {
        return 0;
    }
s1_setup_test2::supported_ta s1_setup_test2::supported_ta__arr__value(const supported_ta__arr& a, unsigned long long i){
    s1_setup_test2::supported_ta val;
    val.tac = (unsigned)___ivy_choose(0,"ret:val",0);
    val.plmn_identity2 = (unsigned)___ivy_choose(0,"ret:val",0);
    val =  (0 <= i && i < a.size()) ? a[i] : val ;
    return val;
}
unsigned long long s1_setup_test2::supported_ta__arr__end(const supported_ta__arr& a){
    unsigned long long val;
    val = (unsigned long long)___ivy_choose(0,"ret:val",0);
    val =  a.size() ;
    return val;
}
int s1_setup_test2::ext__s1_setup__state(){
    int s;
    s = (int)___ivy_choose(0,"fml:s",0);
    s = s1_setup__packet_state;
    return s;
}
void s1_setup_test2::ext__s1_setup__send(unsigned x, message_enum y, unsigned a, unsigned b, drx_enum c){
    {
        s1_setup__packet_state = (s1_setup__packet_state + 1);
        s1_setup__pcode = x;
        s1_setup__msg = y;
        s1_setup__plmn_identity = a;
        s1_setup__global_choice_enb_id = b;
        s1_setup__default_paging_drx = c;
    }
}
s1_setup_test2::supported_ta__arr s1_setup_test2::ext__supported_ta__arr__empty(){
    s1_setup_test2::supported_ta__arr a;
    {
        
    }
    return a;
}
bool s1_setup_test2::ext__ask_and_check_pcode(){
    bool ok;
    ok = (bool)___ivy_choose(0,"fml:ok",0);
    {
        unsigned loc__0;
    loc__0 = (unsigned)___ivy_choose(0,"loc:0",21);
        {
            loc__0 = ext__ask();
            ok = (loc__0 == (17 & 255));
        }
    }
    return ok;
}
s1_setup_test2::message_enum s1_setup_test2::ext__s1_setup__recv(){
    s1_setup_test2::message_enum y;
    y = (message_enum)___ivy_choose(0,"fml:y",0);
    y = (((s1_setup__msg == message_enum__initial_message) && (s1_setup__pcode == (17 & 255)) && ((0 & 16777215) < s1_setup__plmn_identity) && ((0 & 16777215) < s1_setup__global_choice_enb_id) && !(s1_setup__default_paging_drx == drx_enum__0)) ? message_enum__successful_outcome : message_enum__unsuccessful_outcome);
    return y;
}
void s1_setup_test2::__init(){
    {
        {
            s1_setup__packet_state = 0;
            s1_setup__pcode = (0 & 255);
            s1_setup__msg = message_enum__unsuccessful_outcome;
            s1_setup__plmn_identity = (0 & 16777215);
            s1_setup__global_choice_enb_id = (0 & 16777215);
            s1_setup__default_paging_drx = drx_enum__0;
            s1_setup__supported_tas = ext__supported_ta__arr__empty();
        }
    }
}
unsigned s1_setup_test2::ext__ask(){
    unsigned x;
    x = (unsigned)___ivy_choose(0,"fml:x",0);
    x = imp__ask();
    return x;
}
unsigned s1_setup_test2::imp__ask(){
    unsigned x;
    x = (unsigned)___ivy_choose(0,"fml:x",0);
    {
    }
    return x;
}
void s1_setup_test2::__tick(int __timeout){
}
s1_setup_test2::s1_setup_test2(){
#ifdef _WIN32
mutex = CreateMutex(NULL,FALSE,NULL);
#else
pthread_mutex_init(&mutex,NULL);
#endif
__lock();
    __CARD__pcode_bits = 256;
    __CARD__supported_ta__idx = 0;
    __CARD__cid = 0;
    __CARD__tac_octet = 65536;
    __CARD__plmn_octet = 16777216;
    s1_setup__plmn_identity = (unsigned)___ivy_choose(0,"init",0);
    s1_setup__msg = (message_enum)___ivy_choose(0,"init",0);
    s1_setup__pcode = (unsigned)___ivy_choose(0,"init",0);
    s1_setup__default_paging_drx = (drx_enum)___ivy_choose(0,"init",0);
    _generating = (bool)___ivy_choose(0,"init",0);
    s1_setup__global_choice_enb_id = (unsigned)___ivy_choose(0,"init",0);
    s1_setup__packet_state = (int)___ivy_choose(0,"init",0);
}
s1_setup_test2::~s1_setup_test2(){
    __lock(); // otherwise, thread may die holding lock!
    for (unsigned i = 0; i < thread_ids.size(); i++){
#ifdef _WIN32
       // No idea how to cancel a thread on Windows. We just suspend it
       // so it can't cause any harm as we destruct this object.
       SuspendThread(thread_ids[i]);
#else
        pthread_cancel(thread_ids[i]);
        pthread_join(thread_ids[i],NULL);
#endif
    }
    __unlock();
}
std::ostream &operator <<(std::ostream &s, const s1_setup_test2::supported_ta &t){
    s<<"{";
    s<< "tac:";
    s << t.tac;
    s<<",";
    s<< "plmn_identity2:";
    s << t.plmn_identity2;
    s<<"}";
    return s;
}
template <>
void  __ser<s1_setup_test2::supported_ta>(ivy_ser &res, const s1_setup_test2::supported_ta&t){
    res.open_struct();
    res.open_field("tac");
    __ser<unsigned>(res,t.tac);
    res.close_field();
    res.open_field("plmn_identity2");
    __ser<unsigned>(res,t.plmn_identity2);
    res.close_field();
    res.close_struct();
}
std::ostream &operator <<(std::ostream &s, const s1_setup_test2::drx_enum &t){
    if (t == s1_setup_test2::drx_enum__0) s<<"0";
    if (t == s1_setup_test2::drx_enum__32) s<<"32";
    if (t == s1_setup_test2::drx_enum__64) s<<"64";
    if (t == s1_setup_test2::drx_enum__128) s<<"128";
    if (t == s1_setup_test2::drx_enum__256) s<<"256";
    return s;
}
template <>
void  __ser<s1_setup_test2::drx_enum>(ivy_ser &res, const s1_setup_test2::drx_enum&t){
    __ser(res,(int)t);
}
std::ostream &operator <<(std::ostream &s, const s1_setup_test2::message_enum &t){
    if (t == s1_setup_test2::message_enum__initial_message) s<<"initial_message";
    if (t == s1_setup_test2::message_enum__successful_outcome) s<<"successful_outcome";
    if (t == s1_setup_test2::message_enum__unsuccessful_outcome) s<<"unsuccessful_outcome";
    return s;
}
template <>
void  __ser<s1_setup_test2::message_enum>(ivy_ser &res, const s1_setup_test2::message_enum&t){
    __ser(res,(int)t);
}


int ask_ret(long long bound) {
    int res;
    while(true) {
        __ivy_out << "? ";
        std::cin >> res;
        if (res >= 0 && res < bound) 
            return res;
        std::cerr << "value out of range" << std::endl;
    }
}



    class s1_setup_test2_repl : public s1_setup_test2 {

    public:

    virtual void ivy_assert(bool truth,const char *msg){
        if (!truth) {
            __ivy_out << "assertion_failed(\"" << msg << "\")" << std::endl;
            std::cerr << msg << ": error: assertion failed\n";
            
            __ivy_exit(1);
        }
    }
    virtual void ivy_assume(bool truth,const char *msg){
        if (!truth) {
            __ivy_out << "assumption_failed(\"" << msg << "\")" << std::endl;
            std::cerr << msg << ": error: assumption failed\n";
            
            __ivy_exit(1);
        }
    }
    s1_setup_test2_repl() : s1_setup_test2(){}
    virtual unsigned imp__ask(){
    __ivy_out  << "< ask" << std::endl;
    return ask_ret(__CARD__pcode_bits);
}

    };

// Override methods to implement low-level network service

bool is_white(int c) {
    return (c == ' ' || c == '\t' || c == '\n' || c == '\r');
}

bool is_ident(int c) {
    return c == '_' || c == '.' || (c >= 'A' &&  c <= 'Z')
        || (c >= 'a' &&  c <= 'z')
        || (c >= '0' &&  c <= '9');
}

void skip_white(const std::string& str, int &pos){
    while (pos < str.size() && is_white(str[pos]))
        pos++;
}

struct syntax_error {
    int pos;
    syntax_error(int pos) : pos(pos) {}
};

void throw_syntax(int pos){
    throw syntax_error(pos);
}

std::string get_ident(const std::string& str, int &pos) {
    std::string res = "";
    while (pos < str.size() && is_ident(str[pos])) {
        res.push_back(str[pos]);
        pos++;
    }
    if (res.size() == 0)
        throw_syntax(pos);
    return res;
}

ivy_value parse_value(const std::string& cmd, int &pos) {
    ivy_value res;
    res.pos = pos;
    skip_white(cmd,pos);
    if (pos < cmd.size() && cmd[pos] == '[') {
        while (true) {
            pos++;
            skip_white(cmd,pos);
            if (pos < cmd.size() && cmd[pos] == ']')
                break;
            res.fields.push_back(parse_value(cmd,pos));
            skip_white(cmd,pos);
            if (pos < cmd.size() && cmd[pos] == ']')
                break;
            if (!(pos < cmd.size() && cmd[pos] == ','))
                throw_syntax(pos);
        }
        pos++;
    }
    else if (pos < cmd.size() && cmd[pos] == '{') {
        while (true) {
            ivy_value field;
            pos++;
            skip_white(cmd,pos);
            field.atom = get_ident(cmd,pos);
            skip_white(cmd,pos);
            if (!(pos < cmd.size() && cmd[pos] == ':'))
                 throw_syntax(pos);
            pos++;
            skip_white(cmd,pos);
            field.fields.push_back(parse_value(cmd,pos));
            res.fields.push_back(field);
            skip_white(cmd,pos);
            if (pos < cmd.size() && cmd[pos] == '}')
                break;
            if (!(pos < cmd.size() && cmd[pos] == ','))
                throw_syntax(pos);
        }
        pos++;
    }
    else if (pos < cmd.size() && cmd[pos] == '"') {
        pos++;
        res.atom = "";
        while (pos < cmd.size() && cmd[pos] != '"') {
            char c = cmd[pos++];
            if (c == '\\') {
                if (pos == cmd.size())
                    throw_syntax(pos);
                c = cmd[pos++];
                c = (c == 'n') ? 10 : (c == 'r') ? 13 : (c == 't') ? 9 : c;
            }
            res.atom.push_back(c);
        }
        if(pos == cmd.size())
            throw_syntax(pos);
        pos++;
    }
    else 
        res.atom = get_ident(cmd,pos);
    return res;
}

void parse_command(const std::string &cmd, std::string &action, std::vector<ivy_value> &args) {
    int pos = 0;
    skip_white(cmd,pos);
    action = get_ident(cmd,pos);
    skip_white(cmd,pos);
    if (pos < cmd.size() && cmd[pos] == '(') {
        pos++;
        skip_white(cmd,pos);
        args.push_back(parse_value(cmd,pos));
        while(true) {
            skip_white(cmd,pos);
            if (!(pos < cmd.size() && cmd[pos] == ','))
                break;
            pos++;
            args.push_back(parse_value(cmd,pos));
        }
        if (!(pos < cmd.size() && cmd[pos] == ')'))
            throw_syntax(pos);
        pos++;
    }
    skip_white(cmd,pos);
    if (pos != cmd.size())
        throw_syntax(pos);
}

struct bad_arity {
    std::string action;
    int num;
    bad_arity(std::string &_action, unsigned _num) : action(_action), num(_num) {}
};

void check_arity(std::vector<ivy_value> &args, unsigned num, std::string &action) {
    if (args.size() != num)
        throw bad_arity(action,num);
}

template <>
s1_setup_test2::supported_ta _arg<s1_setup_test2::supported_ta>(std::vector<ivy_value> &args, unsigned idx, long long bound){
    s1_setup_test2::supported_ta res;
    ivy_value &arg = args[idx];
    if (arg.atom.size() || arg.fields.size() != 2) throw out_of_bounds("wrong number of fields",args[idx].pos);
    std::vector<ivy_value> tmp_args(1);
    if (arg.fields[0].is_member()){
        tmp_args[0] = arg.fields[0].fields[0];
        if (arg.fields[0].atom != "tac") throw out_of_bounds("unexpected field: " + arg.fields[0].atom,arg.fields[0].pos);
    }
    else{
        tmp_args[0] = arg.fields[0];
    }
    try{
        res.tac = _arg<unsigned>(tmp_args,0,65536);
;
    }
    catch(const out_of_bounds &err){
        throw out_of_bounds("in field tac: " + err.txt,err.pos);
    }
    if (arg.fields[1].is_member()){
        tmp_args[0] = arg.fields[1].fields[0];
        if (arg.fields[1].atom != "plmn_identity2") throw out_of_bounds("unexpected field: " + arg.fields[1].atom,arg.fields[1].pos);
    }
    else{
        tmp_args[0] = arg.fields[1];
    }
    try{
        res.plmn_identity2 = _arg<unsigned>(tmp_args,0,16777216);
;
    }
    catch(const out_of_bounds &err){
        throw out_of_bounds("in field plmn_identity2: " + err.txt,err.pos);
    }
    return res;
}
template <>
void __deser<s1_setup_test2::supported_ta>(ivy_deser &inp, s1_setup_test2::supported_ta &res){
    inp.open_struct();
    inp.open_field("tac");
    __deser(inp,res.tac);
    inp.close_field();
    inp.open_field("plmn_identity2");
    __deser(inp,res.plmn_identity2);
    inp.close_field();
    inp.close_struct();
}
template <>
s1_setup_test2::drx_enum _arg<s1_setup_test2::drx_enum>(std::vector<ivy_value> &args, unsigned idx, long long bound){
    ivy_value &arg = args[idx];
    if (arg.atom.size() == 0 || arg.fields.size() != 0) throw out_of_bounds(idx,arg.pos);
    if(arg.atom == "0") return s1_setup_test2::drx_enum__0;
    if(arg.atom == "32") return s1_setup_test2::drx_enum__32;
    if(arg.atom == "64") return s1_setup_test2::drx_enum__64;
    if(arg.atom == "128") return s1_setup_test2::drx_enum__128;
    if(arg.atom == "256") return s1_setup_test2::drx_enum__256;
    throw out_of_bounds("bad value: " + arg.atom,arg.pos);
}
template <>
void __deser<s1_setup_test2::drx_enum>(ivy_deser &inp, s1_setup_test2::drx_enum &res){
    int __res;
    __deser(inp,__res);
    res = (s1_setup_test2::drx_enum)__res;
}
template <>
s1_setup_test2::message_enum _arg<s1_setup_test2::message_enum>(std::vector<ivy_value> &args, unsigned idx, long long bound){
    ivy_value &arg = args[idx];
    if (arg.atom.size() == 0 || arg.fields.size() != 0) throw out_of_bounds(idx,arg.pos);
    if(arg.atom == "initial_message") return s1_setup_test2::message_enum__initial_message;
    if(arg.atom == "successful_outcome") return s1_setup_test2::message_enum__successful_outcome;
    if(arg.atom == "unsuccessful_outcome") return s1_setup_test2::message_enum__unsuccessful_outcome;
    throw out_of_bounds("bad value: " + arg.atom,arg.pos);
}
template <>
void __deser<s1_setup_test2::message_enum>(ivy_deser &inp, s1_setup_test2::message_enum &res){
    int __res;
    __deser(inp,__res);
    res = (s1_setup_test2::message_enum)__res;
}


class stdin_reader: public reader {
    std::string buf;
    std::string eof_flag;

public:
    bool eof(){
      return eof_flag.size();
    }
    virtual int fdes(){
        return 0;
    }
    virtual void read() {
        char tmp[257];
        int chars = ::read(0,tmp,256);
        if (chars == 0) {  // EOF
            if (buf.size())
                process(buf);
            eof_flag = "eof";
        }
        tmp[chars] = 0;
        buf += std::string(tmp);
        size_t pos;
        while ((pos = buf.find('\n')) != std::string::npos) {
            std::string line = buf.substr(0,pos+1);
            buf.erase(0,pos+1);
            process(line);
        }
    }
    virtual void process(const std::string &line) {
        __ivy_out << line;
    }
};

class cmd_reader: public stdin_reader {
    int lineno;
public:
    s1_setup_test2_repl &ivy;    

    cmd_reader(s1_setup_test2_repl &_ivy) : ivy(_ivy) {
        lineno = 1;
        if (isatty(fdes()))
            __ivy_out << "> "; __ivy_out.flush();
    }

    virtual void process(const std::string &cmd) {
        std::string action;
        std::vector<ivy_value> args;
        try {
            parse_command(cmd,action,args);
            ivy.__lock();

                if (action == "ask_and_check_pcode") {
                    check_arity(args,0,action);
                    __ivy_out  << "= " << ivy.ext__ask_and_check_pcode() << std::endl;
                }
                else
    
                if (action == "s1_setup.recv") {
                    check_arity(args,0,action);
                    __ivy_out  << "= " << ivy.ext__s1_setup__recv() << std::endl;
                }
                else
    
                if (action == "s1_setup.send") {
                    check_arity(args,5,action);
                    ivy.ext__s1_setup__send(_arg<unsigned>(args,0,256),_arg<s1_setup_test2::message_enum>(args,1,3),_arg<unsigned>(args,2,16777216),_arg<unsigned>(args,3,16777216),_arg<s1_setup_test2::drx_enum>(args,4,5));
                }
                else
    
                if (action == "s1_setup.state") {
                    check_arity(args,0,action);
                    __ivy_out  << "= " << ivy.ext__s1_setup__state() << std::endl;
                }
                else
    
            {
                std::cerr << "undefined action: " << action << std::endl;
            }
            ivy.__unlock();
        }
        catch (syntax_error& err) {
            ivy.__unlock();
            std::cerr << "line " << lineno << ":" << err.pos << ": syntax error" << std::endl;
        }
        catch (out_of_bounds &err) {
            ivy.__unlock();
            std::cerr << "line " << lineno << ":" << err.pos << ": " << err.txt << " bad value" << std::endl;
        }
        catch (bad_arity &err) {
            ivy.__unlock();
            std::cerr << "action " << err.action << " takes " << err.num  << " input parameters" << std::endl;
        }
        if (isatty(fdes()))
            __ivy_out << "> "; __ivy_out.flush();
        lineno++;
    }
};



int main(int argc, char **argv){
        int test_iters = 100;
        int runs = 1;

    int seed = 1;
    int sleep_ms = 10;
    int final_ms = 0; 
    
    std::vector<char *> pargs; // positional args
    pargs.push_back(argv[0]);
    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        size_t p = arg.find('=');
        if (p == std::string::npos)
            pargs.push_back(argv[i]);
        else {
            std::string param = arg.substr(0,p);
            std::string value = arg.substr(p+1);

            if (param == "out") {
                __ivy_out.open(value.c_str());
                if (!__ivy_out) {
                    std::cerr << "cannot open to write: " << value << std::endl;
                    return 1;
                }
            }
            else if (param == "iters") {
                test_iters = atoi(value.c_str());
            }
            else if (param == "runs") {
                runs = atoi(value.c_str());
            }
            else if (param == "seed") {
                seed = atoi(value.c_str());
            }
            else if (param == "delay") {
                sleep_ms = atoi(value.c_str());
            }
            else if (param == "wait") {
                final_ms = atoi(value.c_str());
            }
            else if (param == "modelfile") {
                __ivy_modelfile.open(value.c_str());
                if (!__ivy_modelfile) {
                    std::cerr << "cannot open to write: " << value << std::endl;
                    return 1;
                }
            }
            else {
                std::cerr << "unknown option: " << param << std::endl;
                return 1;
            }
        }
    }
    srand(seed);
    if (!__ivy_out.is_open())
        __ivy_out.basic_ios<char>::rdbuf(std::cout.rdbuf());
    argc = pargs.size();
    argv = &pargs[0];
    if (argc == 2){
        argc--;
        int fd = _open(argv[argc],0);
        if (fd < 0){
            std::cerr << "cannot open to read: " << argv[argc] << "\n";
            __ivy_exit(1);
        }
        _dup2(fd, 0);
    }
    if (argc != 1){
        std::cerr << "usage: s1_setup_test2 \n";
        __ivy_exit(1);
    }
    std::vector<std::string> args;
    std::vector<ivy_value> arg_values(0);
    for(int i = 1; i < argc;i++){args.push_back(argv[i]);}

#ifdef _WIN32
    // Boilerplate from windows docs

    {
        WORD wVersionRequested;
        WSADATA wsaData;
        int err;

    /* Use the MAKEWORD(lowbyte, highbyte) macro declared in Windef.h */
        wVersionRequested = MAKEWORD(2, 2);

        err = WSAStartup(wVersionRequested, &wsaData);
        if (err != 0) {
            /* Tell the user that we could not find a usable */
            /* Winsock DLL.                                  */
            printf("WSAStartup failed with error: %d\n", err);
            return 1;
        }

    /* Confirm that the WinSock DLL supports 2.2.*/
    /* Note that if the DLL supports versions greater    */
    /* than 2.2 in addition to 2.2, it will still return */
    /* 2.2 in wVersion since that is the version we      */
    /* requested.                                        */

        if (LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 2) {
            /* Tell the user that we could not find a usable */
            /* WinSock DLL.                                  */
            printf("Could not find a usable version of Winsock.dll\n");
            WSACleanup();
            return 1;
        }
    }
#endif
    s1_setup_test2_repl ivy;
    for(unsigned i = 0; i < argc; i++) {ivy.__argv.push_back(argv[i]);}
    ivy.__init();


    ivy.__unlock();

    cmd_reader *cr = new cmd_reader(ivy);

    // The main thread runs the console reader

    while (!cr->eof())
        cr->read();
    return 0;

    return 0;
}
