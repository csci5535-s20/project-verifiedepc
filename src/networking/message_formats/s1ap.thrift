package s1ap

/*
other tools used: 
https://crates.io/crates/asn1rs


Reference: 
1. https://thrift.apache.org/docs/idl
2. https://github.com/apache/thrift/blob/af7ecd6a2b15efe5c6b742cf4a9ccb31bcc1f362/doc/specs/thrift-protocol-spec.md

Definition      ::=  Const | Typedef | Enum | Senum | Struct | Union | Exception | Service

BaseType        ::=  'bool' | 'byte' | 'i8' | 'i16' | 'i32' | 'i64' | 'double' | 'string' | 'binary' | 'slist'

ContainerType   ::=  MapType | SetType | ListType

ConstValue      ::=  IntConstant | DoubleConstant | Literal | Identifier | ConstList | ConstMap


Thrift maps the various base and container types to C++ types as follows:

    bool: bool

    binary: std::string

    byte: int8_t

    i16: int16_t

    i32: int32_t

    i64: int64_t

    double: double

    string: std::string

    slist

    list<t1>: std::vector<t1>

    set<t1>: std::set<t1>

    map<t1,t2>: std::map<T1, T2>


You can define enums, which are just 32 bit integers. Values are optional
 * and start at 1 

 Questions: 
 1. When to use bool, byte, binary, string, slist BaseTypes? 
 2. 

*/


 // -----------------------
 // S1AP specification
 // -- TS 36.413 V8.10.0 (2010-06)

// Include all the files that need to be compiled together

include "s1ap_constants.thrift"
include "s1ap_containers.thrift"
include "ie_definitions.thrift"
include "s1ap_common_datatypes.thrift"
include "s1ap_pdu_contents.thrift"
include "s1ap_pdu_descriptions.thrift"