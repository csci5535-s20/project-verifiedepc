#include "uplink_nas_transport_test.h"

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
typedef uplink_nas_transport_test ivy_class;
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

void uplink_nas_transport_test::install_reader(reader *r) {
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

void uplink_nas_transport_test::install_thread(reader *r) {
    install_reader(r);
}

void uplink_nas_transport_test::install_timer(timer *r) {
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
    void uplink_nas_transport_test::__lock() { WaitForSingleObject(mutex,INFINITE); }
    void uplink_nas_transport_test::__unlock() { ReleaseMutex(mutex); }
#else
    void uplink_nas_transport_test::__lock() { pthread_mutex_lock(&mutex); }
    void uplink_nas_transport_test::__unlock() { pthread_mutex_unlock(&mutex); }
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

std::ostream &operator <<(std::ostream &s, const uplink_nas_transport_test::message_enum &t);
template <>
uplink_nas_transport_test::message_enum _arg<uplink_nas_transport_test::message_enum>(std::vector<ivy_value> &args, unsigned idx, long long bound);
template <>
void  __ser<uplink_nas_transport_test::message_enum>(ivy_ser &res, const uplink_nas_transport_test::message_enum&);
template <>
void  __deser<uplink_nas_transport_test::message_enum>(ivy_deser &inp, uplink_nas_transport_test::message_enum &res);
std::ostream &operator <<(std::ostream &s, const uplink_nas_transport_test::nas_pdu_string &t);
template <>
uplink_nas_transport_test::nas_pdu_string _arg<uplink_nas_transport_test::nas_pdu_string>(std::vector<ivy_value> &args, unsigned idx, long long bound);
template <>
void  __ser<uplink_nas_transport_test::nas_pdu_string>(ivy_ser &res, const uplink_nas_transport_test::nas_pdu_string&);
template <>
void  __deser<uplink_nas_transport_test::nas_pdu_string>(ivy_deser &inp, uplink_nas_transport_test::nas_pdu_string &res);
int uplink_nas_transport_test::___ivy_choose(int rng,const char *name,int id) {
        return 0;
    }
uplink_nas_transport_test::message_enum uplink_nas_transport_test::ext__uplink_nas_transport__recv(){
    uplink_nas_transport_test::message_enum y;
    y = (message_enum)___ivy_choose(0,"fml:y",0);
    y = (((uplink_nas_transport__msg == message_enum__initial_message) && (uplink_nas_transport__pcode == (13 & 255)) && (0 < uplink_nas_transport__mme_ue_s1ap_id) && (0 < uplink_nas_transport__enb_ue_s1ap_id) && !(uplink_nas_transport__nas_pdu == nas_pdu_string__0) && ((0 & 16777215) < uplink_nas_transport__plmn_identity1) && ((0 & 65535) < uplink_nas_transport__tac) && ((0 & 16777215) < uplink_nas_transport__plmn_identity2) && ((0 & 268435455) < uplink_nas_transport__cell_identity)) ? message_enum__successful_outcome : message_enum__unsuccessful_outcome);
    return y;
}
void uplink_nas_transport_test::__init(){
    {
        {
            uplink_nas_transport__pcode = (0 & 255);
            uplink_nas_transport__msg = message_enum__unsuccessful_outcome;
            uplink_nas_transport__mme_ue_s1ap_id = 0;
            uplink_nas_transport__enb_ue_s1ap_id = 0;
            uplink_nas_transport__nas_pdu = nas_pdu_string__0;
            uplink_nas_transport__plmn_identity1 = (0 & 16777215);
            uplink_nas_transport__tac = (0 & 65535);
            uplink_nas_transport__plmn_identity2 = (0 & 16777215);
            uplink_nas_transport__cell_identity = (0 & 268435455);
        }
    }
}
bool uplink_nas_transport_test::ext__ask_and_check_pcode(){
    bool ok;
    ok = (bool)___ivy_choose(0,"fml:ok",0);
    {
        unsigned loc__0;
    loc__0 = (unsigned)___ivy_choose(0,"loc:0",10);
        {
            loc__0 = ext__ask();
            ok = (loc__0 == (13 & 255));
        }
    }
    return ok;
}
void uplink_nas_transport_test::ext__uplink_nas_transport__send(unsigned x, message_enum y, int m, int e, nas_pdu_string n, unsigned a, unsigned b, unsigned c, unsigned d){
    {
        uplink_nas_transport__pcode = x;
        uplink_nas_transport__msg = y;
        uplink_nas_transport__mme_ue_s1ap_id = m;
        uplink_nas_transport__enb_ue_s1ap_id = e;
        uplink_nas_transport__nas_pdu = n;
        uplink_nas_transport__plmn_identity1 = a;
        uplink_nas_transport__tac = b;
        uplink_nas_transport__plmn_identity2 = c;
        uplink_nas_transport__cell_identity = d;
    }
}
unsigned uplink_nas_transport_test::ext__ask(){
    unsigned x;
    x = (unsigned)___ivy_choose(0,"fml:x",0);
    x = imp__ask();
    return x;
}
unsigned uplink_nas_transport_test::imp__ask(){
    unsigned x;
    x = (unsigned)___ivy_choose(0,"fml:x",0);
    {
    }
    return x;
}
void uplink_nas_transport_test::__tick(int __timeout){
}
uplink_nas_transport_test::uplink_nas_transport_test(){
#ifdef _WIN32
mutex = CreateMutex(NULL,FALSE,NULL);
#else
pthread_mutex_init(&mutex,NULL);
#endif
__lock();
    __CARD__pcode_bits = 256;
    __CARD__plmn_octet = 16777216;
    __CARD__tac_octet = 65536;
    __CARD__cell_bits = 268435456;
    __CARD__cid = 0;
    _generating = (bool)___ivy_choose(0,"init",0);
    uplink_nas_transport__cell_identity = (unsigned)___ivy_choose(0,"init",0);
    uplink_nas_transport__plmn_identity1 = (unsigned)___ivy_choose(0,"init",0);
    uplink_nas_transport__enb_ue_s1ap_id = (int)___ivy_choose(0,"init",0);
    uplink_nas_transport__plmn_identity2 = (unsigned)___ivy_choose(0,"init",0);
    uplink_nas_transport__msg = (message_enum)___ivy_choose(0,"init",0);
    uplink_nas_transport__nas_pdu = (nas_pdu_string)___ivy_choose(0,"init",0);
    uplink_nas_transport__mme_ue_s1ap_id = (int)___ivy_choose(0,"init",0);
    uplink_nas_transport__tac = (unsigned)___ivy_choose(0,"init",0);
    uplink_nas_transport__pcode = (unsigned)___ivy_choose(0,"init",0);
}
uplink_nas_transport_test::~uplink_nas_transport_test(){
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
std::ostream &operator <<(std::ostream &s, const uplink_nas_transport_test::message_enum &t){
    if (t == uplink_nas_transport_test::message_enum__initial_message) s<<"initial_message";
    if (t == uplink_nas_transport_test::message_enum__successful_outcome) s<<"successful_outcome";
    if (t == uplink_nas_transport_test::message_enum__unsuccessful_outcome) s<<"unsuccessful_outcome";
    return s;
}
template <>
void  __ser<uplink_nas_transport_test::message_enum>(ivy_ser &res, const uplink_nas_transport_test::message_enum&t){
    __ser(res,(int)t);
}
std::ostream &operator <<(std::ostream &s, const uplink_nas_transport_test::nas_pdu_string &t){
    if (t == uplink_nas_transport_test::nas_pdu_string__0) s<<"0";
    if (t == uplink_nas_transport_test::nas_pdu_string__a) s<<"a";
    if (t == uplink_nas_transport_test::nas_pdu_string__b) s<<"b";
    if (t == uplink_nas_transport_test::nas_pdu_string__c) s<<"c";
    if (t == uplink_nas_transport_test::nas_pdu_string__d) s<<"d";
    if (t == uplink_nas_transport_test::nas_pdu_string__e) s<<"e";
    if (t == uplink_nas_transport_test::nas_pdu_string__f) s<<"f";
    if (t == uplink_nas_transport_test::nas_pdu_string__g) s<<"g";
    if (t == uplink_nas_transport_test::nas_pdu_string__h) s<<"h";
    if (t == uplink_nas_transport_test::nas_pdu_string__i) s<<"i";
    if (t == uplink_nas_transport_test::nas_pdu_string__j) s<<"j";
    if (t == uplink_nas_transport_test::nas_pdu_string__k) s<<"k";
    if (t == uplink_nas_transport_test::nas_pdu_string__l) s<<"l";
    if (t == uplink_nas_transport_test::nas_pdu_string__m) s<<"m";
    if (t == uplink_nas_transport_test::nas_pdu_string__n) s<<"n";
    if (t == uplink_nas_transport_test::nas_pdu_string__o) s<<"o";
    if (t == uplink_nas_transport_test::nas_pdu_string__p) s<<"p";
    if (t == uplink_nas_transport_test::nas_pdu_string__q) s<<"q";
    if (t == uplink_nas_transport_test::nas_pdu_string__r) s<<"r";
    if (t == uplink_nas_transport_test::nas_pdu_string__s) s<<"s";
    if (t == uplink_nas_transport_test::nas_pdu_string__t) s<<"t";
    if (t == uplink_nas_transport_test::nas_pdu_string__u) s<<"u";
    if (t == uplink_nas_transport_test::nas_pdu_string__v) s<<"v";
    if (t == uplink_nas_transport_test::nas_pdu_string__w) s<<"w";
    if (t == uplink_nas_transport_test::nas_pdu_string__x) s<<"x";
    if (t == uplink_nas_transport_test::nas_pdu_string__y) s<<"y";
    if (t == uplink_nas_transport_test::nas_pdu_string__z) s<<"z";
    return s;
}
template <>
void  __ser<uplink_nas_transport_test::nas_pdu_string>(ivy_ser &res, const uplink_nas_transport_test::nas_pdu_string&t){
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



    class uplink_nas_transport_test_repl : public uplink_nas_transport_test {

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
    uplink_nas_transport_test_repl() : uplink_nas_transport_test(){}
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
uplink_nas_transport_test::message_enum _arg<uplink_nas_transport_test::message_enum>(std::vector<ivy_value> &args, unsigned idx, long long bound){
    ivy_value &arg = args[idx];
    if (arg.atom.size() == 0 || arg.fields.size() != 0) throw out_of_bounds(idx,arg.pos);
    if(arg.atom == "initial_message") return uplink_nas_transport_test::message_enum__initial_message;
    if(arg.atom == "successful_outcome") return uplink_nas_transport_test::message_enum__successful_outcome;
    if(arg.atom == "unsuccessful_outcome") return uplink_nas_transport_test::message_enum__unsuccessful_outcome;
    throw out_of_bounds("bad value: " + arg.atom,arg.pos);
}
template <>
void __deser<uplink_nas_transport_test::message_enum>(ivy_deser &inp, uplink_nas_transport_test::message_enum &res){
    int __res;
    __deser(inp,__res);
    res = (uplink_nas_transport_test::message_enum)__res;
}
template <>
uplink_nas_transport_test::nas_pdu_string _arg<uplink_nas_transport_test::nas_pdu_string>(std::vector<ivy_value> &args, unsigned idx, long long bound){
    ivy_value &arg = args[idx];
    if (arg.atom.size() == 0 || arg.fields.size() != 0) throw out_of_bounds(idx,arg.pos);
    if(arg.atom == "0") return uplink_nas_transport_test::nas_pdu_string__0;
    if(arg.atom == "a") return uplink_nas_transport_test::nas_pdu_string__a;
    if(arg.atom == "b") return uplink_nas_transport_test::nas_pdu_string__b;
    if(arg.atom == "c") return uplink_nas_transport_test::nas_pdu_string__c;
    if(arg.atom == "d") return uplink_nas_transport_test::nas_pdu_string__d;
    if(arg.atom == "e") return uplink_nas_transport_test::nas_pdu_string__e;
    if(arg.atom == "f") return uplink_nas_transport_test::nas_pdu_string__f;
    if(arg.atom == "g") return uplink_nas_transport_test::nas_pdu_string__g;
    if(arg.atom == "h") return uplink_nas_transport_test::nas_pdu_string__h;
    if(arg.atom == "i") return uplink_nas_transport_test::nas_pdu_string__i;
    if(arg.atom == "j") return uplink_nas_transport_test::nas_pdu_string__j;
    if(arg.atom == "k") return uplink_nas_transport_test::nas_pdu_string__k;
    if(arg.atom == "l") return uplink_nas_transport_test::nas_pdu_string__l;
    if(arg.atom == "m") return uplink_nas_transport_test::nas_pdu_string__m;
    if(arg.atom == "n") return uplink_nas_transport_test::nas_pdu_string__n;
    if(arg.atom == "o") return uplink_nas_transport_test::nas_pdu_string__o;
    if(arg.atom == "p") return uplink_nas_transport_test::nas_pdu_string__p;
    if(arg.atom == "q") return uplink_nas_transport_test::nas_pdu_string__q;
    if(arg.atom == "r") return uplink_nas_transport_test::nas_pdu_string__r;
    if(arg.atom == "s") return uplink_nas_transport_test::nas_pdu_string__s;
    if(arg.atom == "t") return uplink_nas_transport_test::nas_pdu_string__t;
    if(arg.atom == "u") return uplink_nas_transport_test::nas_pdu_string__u;
    if(arg.atom == "v") return uplink_nas_transport_test::nas_pdu_string__v;
    if(arg.atom == "w") return uplink_nas_transport_test::nas_pdu_string__w;
    if(arg.atom == "x") return uplink_nas_transport_test::nas_pdu_string__x;
    if(arg.atom == "y") return uplink_nas_transport_test::nas_pdu_string__y;
    if(arg.atom == "z") return uplink_nas_transport_test::nas_pdu_string__z;
    throw out_of_bounds("bad value: " + arg.atom,arg.pos);
}
template <>
void __deser<uplink_nas_transport_test::nas_pdu_string>(ivy_deser &inp, uplink_nas_transport_test::nas_pdu_string &res){
    int __res;
    __deser(inp,__res);
    res = (uplink_nas_transport_test::nas_pdu_string)__res;
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
    uplink_nas_transport_test_repl &ivy;    

    cmd_reader(uplink_nas_transport_test_repl &_ivy) : ivy(_ivy) {
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
    
                if (action == "uplink_nas_transport.recv") {
                    check_arity(args,0,action);
                    __ivy_out  << "= " << ivy.ext__uplink_nas_transport__recv() << std::endl;
                }
                else
    
                if (action == "uplink_nas_transport.send") {
                    check_arity(args,9,action);
                    ivy.ext__uplink_nas_transport__send(_arg<unsigned>(args,0,256),_arg<uplink_nas_transport_test::message_enum>(args,1,3),_arg<int>(args,2,0),_arg<int>(args,3,0),_arg<uplink_nas_transport_test::nas_pdu_string>(args,4,27),_arg<unsigned>(args,5,16777216),_arg<unsigned>(args,6,65536),_arg<unsigned>(args,7,16777216),_arg<unsigned>(args,8,268435456));
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
        std::cerr << "usage: uplink_nas_transport_test \n";
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
    uplink_nas_transport_test_repl ivy;
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
