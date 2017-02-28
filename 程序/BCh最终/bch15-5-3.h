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

	//������15��5��3�ı����
	bool encode(int watermarking[]);

	bool decode(int watermarking[]);

	//������
	bool StringTo65Int(string str , int data[]);
	bool IntTo195String(int data[], string &str);

	//������
	bool StringTo195Int(string str, int data[]);
	bool IntTo64String(int data[], string &str);

	//������ת16����
	bool check(char a, int b, int &num);

	bool coverS02ToS16(string &a, string &b, bool mode);

	bool coverS16ToS02(string &a, string &b, bool mode);
}

