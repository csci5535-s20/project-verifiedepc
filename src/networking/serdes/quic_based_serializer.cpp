// Example program
#include <iostream>
#include <string>
#include <iostream>
#include <stdlib.h>
#include <sys/types.h>          /* See NOTES */
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <iterator>
#include <fstream>


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

   class quic_ser : public ivy_binary_ser {
        enum {quic_s_init,
              quic_s_version,
	      quic_s_dcil,
	      quic_s_scil,
              quic_s_dcid,
              quic_s_scid,
              quic_s_retry_token_length,
              quic_s_retry_token,
	      quic_s_payload_length,
              quic_s_pkt_num,
              quic_s_payload,
              quic_stream_id,
              quic_stream_off,
              quic_stream_len,
              quic_stream_fin,
              quic_stream_offset,
              quic_stream_length,
              quic_stream_data,
              quic_crypto_offset,
              quic_crypto_length,
              quic_crypto_data,
              quic_ack_largest,
              quic_ack_delay,
              quic_ack_block_count,
              quic_ack_gap,
              quic_ack_block,
              quic_reset_stream_id,
              quic_reset_err_code,
              quic_reset_final_offset,
              quic_stop_sending_id,
              quic_stop_sending_err_code,
              quic_connection_close_err_code,
              quic_connection_close_frame_type,
              quic_connection_close_reason_length,
              quic_connection_close_reason,
              quic_application_close_err_code,
              quic_max_stream_data_id,
              quic_path_challenge_data,
              quic_new_connection_id_length,
              quic_new_connection_id_seq_num,
              quic_new_connection_id_retire_prior_to,
              quic_new_connection_id_scid,
              quic_new_connection_id_token,
              quic_retire_connection_id_seq_num,
              quic_s_done} state;
        bool long_format;
        char hdr_type;
        int dcil;
        int scil;
        char frame_type;
        int data_remaining;
       long long ack_blocks_expected;
        long long ack_block_count;
        int payload_length_pos;
        int fence;

    public:
        quic_ser() : state(quic_s_init) {
        }
        virtual void  set(long long res) {
            switch (state) {
            case quic_s_init:
            {
                long_format = res != 3;
                hdr_type = (long_format ? ((res & 3) << 4) : 0) | 0x43 ;
		setn(hdr_type | (long_format ? 0x80 : 0), 1);
                state = quic_s_version;
            }
            break;
            case quic_s_version:
            {
                if (long_format)
                    setn(res,4);
                state = quic_s_dcid;
            }
            break;
            case quic_s_dcid:
            {
                if (long_format) {
                    setn(8,1);
                }
		setn(res,8);
                state = quic_s_scid;
            }
            break;
            case quic_s_scid:
            {
                if (long_format) {
                    setn(8,1);
		    setn(res,8);
                }
                state = quic_s_retry_token_length;
            }
            break;
            case quic_s_pkt_num:
            {
                set_pkt_num(res);
                state = quic_s_payload;
            }
            break;
            case quic_stream_off:
            {
                frame_type |= res ? 0x04 : 0;
                state = quic_stream_len;
            }
            break;
            case quic_stream_len:
            {
                frame_type |= res ? 0x02 : 0;
                state = quic_stream_fin;
            }
            break;
            case quic_stream_fin:
            {
                frame_type |= res ? 0x01 : 0;
		setn(frame_type,1);
                state = quic_stream_id;
            }
            break;
            case quic_stream_id:
            {
                set_var_int(res);
                state = quic_stream_offset;
            }
            break;
            case quic_stream_offset:
            {
                if (0x04 & frame_type)
                    set_var_int(res);
                state = quic_stream_length;
            }
            break;
            case quic_stream_length:
            {
                if (0x02 & frame_type)
                    set_var_int(res);
                data_remaining = res;
                state = quic_stream_data;
            }
            break;
            case quic_crypto_offset:
            {
                set_var_int(res);
                state = quic_crypto_length;
            }
            break;
            case quic_crypto_length:
            {
                set_var_int(res);
                data_remaining = res;
                state = quic_crypto_data;
            }
            break;
            case quic_stream_data:
            case quic_crypto_data:
            case quic_connection_close_reason:
            case quic_path_challenge_data:
            case quic_s_retry_token:
            {
                setn(res,1);
            }
            break;
            case quic_ack_largest:
            {
                set_var_int(res);
                state = quic_ack_delay;
            }
            break;
            case quic_ack_delay:
            {
                set_var_int(res);
                state = quic_ack_block_count;
            }
            break;
            case quic_ack_gap:
            {
                if (ack_block_count == 0)
                    {} // first ack block has no gap
                else
                    set_var_int(res);
                state = quic_ack_block;
            }
            break;
            case quic_ack_block:
            {
                set_var_int(res);
                state = quic_ack_gap;
                ack_block_count++;
            }
            break;
            case quic_reset_stream_id:
            {
                set_var_int(res);
                state = quic_reset_err_code;
            }
            break;
            case quic_reset_err_code:
            {
                set_var_int(res);
                state = quic_reset_final_offset;
            }
            break;
            case quic_reset_final_offset:
            {
                set_var_int(res);
            }
            break;
            case quic_stop_sending_id:
            {
                set_var_int(res);
                state = quic_stop_sending_err_code;
            }
            break;
            case quic_stop_sending_err_code:
            {
                set_var_int(res);
            }
            break;
            case quic_connection_close_err_code:
            {
                set_var_int(res);
                state = quic_connection_close_frame_type;
            }
            break;
            case quic_connection_close_frame_type:
            {
                set_var_int(res);
                state = quic_connection_close_reason_length;
            }
            break;
            case quic_connection_close_reason_length:
            {
                set_var_int(res);
                data_remaining = res;
                state = quic_connection_close_reason;
            }
            break;
            case quic_application_close_err_code:
            {
                set_var_int(res);
                state = quic_connection_close_reason_length;
            }
            break;
            case quic_max_stream_data_id:
            {
                set_var_int(res);
                state = quic_reset_final_offset;
            }
            break;
            case quic_new_connection_id_length:
            {
                setn(res,1);
                scil = res;
                state = quic_new_connection_id_scid;
            }
            break;
            case quic_new_connection_id_seq_num:
            {
                set_var_int(res);
                state = quic_new_connection_id_retire_prior_to;
            }
            break;
            case quic_new_connection_id_retire_prior_to:
            {
                set_var_int(res);
                state = quic_new_connection_id_length;
            }
            break;
            case quic_new_connection_id_scid:
            {
                setn(res,scil);
                state = quic_new_connection_id_token;
            }
            break;
            case quic_new_connection_id_token:
            {
                setn(res,16);
            }
            break;
            case quic_retire_connection_id_seq_num:
            {
                set_var_int(res);
            }
            break;
            default:
            throw deser_err();
            }
        }

        void set_var_int(long long res) {
	    long long val = res & 0x3fffffffffffffff;
	    int bytecode = res <= 0x3f ? 0 : res <= 0x3fff ? 1 : res <= 0x3fffffff ? 2 : 3;
	    int bytes = 1 << bytecode;
            val |= bytecode << ((bytes << 3) - 2);
	    setn(val,bytes);
        }

        void set_pkt_num(long long &res) {
            // setn(0xc0000000 | (0x3fffffff & res),4);
            // pkt number length is low two bits of first packet byte, plus one 
            setn(res,(hdr_type & 3) + 1);
        }

        virtual void open_tag(int tag, const std::string &) {
            if (state == quic_s_payload) {
                if (tag == 0) {
		    frame_type = 0x08;
                    state = quic_stream_off;
                    return;
                }
                if (tag == 1) {
                    state = quic_ack_largest;
                    frame_type = 0x02;
                }
                else if (tag == 2) {
                    state = quic_reset_stream_id;
                    frame_type = 0x04;
                }
                else if (tag == 3) {
                    state = quic_reset_stream_id; // max_stream_id state equivalent to this
                    frame_type = 0x12;
                }
                else if (tag == 4) {
                    state = quic_connection_close_err_code;
                    frame_type = 0x1c;
                }
                else if (tag == 5) {
                    state = quic_max_stream_data_id;
                    frame_type = 0x11;
                }
                else if (tag == 6) {
                    state = quic_reset_final_offset;
                    frame_type = 0x16;
                }
                else if (tag == 7) {
                    frame_type = 0x06;
                    state = quic_crypto_offset;
                }
                else if (tag == 8) {
                    frame_type = 0x01;
                }
                else if (tag == 9) {
                    frame_type = 0x1d;
                    state = quic_application_close_err_code;
                }
                else if (tag == 10) {
                    frame_type = 0x18;
                    state = quic_new_connection_id_seq_num;
                }
                else if (tag == 11) {
                    frame_type = 0x1a;
                    state = quic_path_challenge_data;
                }
                else if (tag == 12) {
                    frame_type = 0x1b;
                    state = quic_path_challenge_data;
                }
                else if (tag == 13) {
                    frame_type = 0x07;
                    state = quic_crypto_length;  // new token equivalent to this
                }
                else if (tag == 14) {
                    frame_type = 0x10;  // max_data
                    state = quic_reset_final_offset;
                }
                else if (tag == 15) {
                    state = quic_max_stream_data_id;
                    frame_type = 0x15;
                }
                else if (tag == 16) {
                    state = quic_stop_sending_id;
                    frame_type = 0x05;
                }
                else if (tag == 17) {
                    state = quic_reset_final_offset;
                    frame_type = 0x14;
                }
                else if (tag == 18) {
                    state = quic_retire_connection_id_seq_num;
                    frame_type = 0x19;
                }
	        else {
                    std::cerr << "saw frame tag " << tag << std::endl;  
                    throw deser_err();
	        }
	        setn(frame_type,1);
	        return;
            }
            throw deser_err();
        }

        virtual void open_list_elem() {
        }

        void open_list(int len) {
	    ack_blocks_expected = len;
            if (state == quic_ack_block_count) {
                set_var_int(ack_blocks_expected - 1); // block count doesn't include first
                ack_block_count = 0;
                state = quic_ack_gap;
            } else if (state == quic_s_retry_token_length) {
                if (long_format & ((hdr_type & 0x30) == 0x00)) {
                    set_var_int(len);
                    data_remaining = len;
                }
                state = quic_s_retry_token;
            }
        }
        void close_list() {
            if (state == quic_s_payload) {
                if ((hdr_type & 0x30) == 0x00)
                    while (res.size() < 1200)
                        res.push_back(0);  // pad initial packet to 1200 bytes
                for(unsigned i = 0; i < 16; i++)
                    res.push_back(0);
                if (long_format) {
                    int len = res.size() - (payload_length_pos+2) ;
                    res[payload_length_pos] = 0x40 | ((len >> 8) & 0x3f);
                    res[payload_length_pos+1] = len & 0xff;
                    state = quic_s_init;
                }
            }
            else if (state == quic_s_retry_token) {
                payload_length_pos = this->res.size();
                if (long_format) {
                    setn(0,2);  // will fill in correct value later
                }
                state = quic_s_pkt_num;
            }
        }
        void close_list_elem() {}

        virtual void close_tag() {
            state = quic_s_payload;
        }

        ~quic_ser(){}
    };
