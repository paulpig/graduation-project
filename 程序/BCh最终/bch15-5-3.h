#include <string>
#include <iostream>
#pragma once
using namespace std;

namespace bch
{
	void read_p();

	void generate_gf();

	void gen_poly();
	
	void init();

	bool encode_bch(int data[], int bb[]);

	bool decode_bch(int data[]);

	//适用于15，5，3的编解码
	bool encode(int watermarking[]);

	bool decode(int watermarking[]);

	//编码用
	bool StringTo65Int(string str , int data[]);
	bool IntTo195String(int data[], string &str);

	//解码用
	bool StringTo195Int(string str, int data[]);
	bool IntTo64String(int data[], string &str);

	//二进制转16进制
	bool check(char a, int b, int &num);

	bool coverS02ToS16(string &a, string &b, bool mode);

	bool coverS16ToS02(string &a, string &b, bool mode);
}

