#include <stdio.h>
#include "bch15-5-3.h"
using namespace bch;
int main()
{
	string  watermarking="C80DE1AE2F6B61C3";
	string  startwatermarking;
	string  encodewatermarking;
	string  decodewatermarking="________________________________________________________________";
	string  Ifwatermarking;
	int  water[200];
	int encodewater[200];
	int  i;
	bool mode = true;

	coverS16ToS02(watermarking, startwatermarking, mode);
	
	//string תint[]
	StringTo65Int(startwatermarking, water);
	//��ʼ��
	init();
	//����
	encode(water);

	printf("�����:\n");
	for (i = 0; i < 13 * 15; i++)
	{
		printf("%1d ", water[i]);
	}
	printf("\n");

	IntTo195String(water, encodewatermarking);
	StringTo195Int(encodewatermarking, encodewater);

	
	 //�������7
	encodewater[0] ^= 1;
	encodewater[1] ^= 1;
	encodewater[2] ^= 1;
//	encodewater[14] ^= 1;

	encodewater[15] ^= 1;
	encodewater[16] ^= 1;
	encodewater[29] ^= 1;

	encodewater[30] ^= 1;
	encodewater[44] ^= 1;

	encodewater[45] ^= 1;
	encodewater[59] ^= 1;

	encodewater[60] ^= 1;
	encodewater[74] ^= 1;

//	encodewater[20] = 0;

//	encodewater[35] = 1;

	printf("�����:\n");
	for (i = 0; i < 13 * 15; i++)
	{
		printf("%1d ", encodewater[i]);
	}
	printf("\n");




	//����
	//�ڵ���������߽���ʱ��  ��Ҫ��ʼ��
	decode(encodewater);
    printf("�����:\n");
	for (i = 0; i < 65; i++)
	{
		printf("%d ", encodewater[i]);
	}
	printf("\n");



	IntTo64String(encodewater, decodewatermarking);
	printf("�����string:\n");
	int l = decodewatermarking.length();
	for (int j = 0; j < l; j++)
		cout << decodewatermarking[j];
	printf("\n");


	//2ת16
	coverS02ToS16(decodewatermarking, Ifwatermarking, mode);

	printf("�����ifwatermarking:\n");
	int leng = Ifwatermarking.length();
	for (int j = 0; j < leng; j++)
		cout << Ifwatermarking[j];


	printf("\n");
	
	return 1;
}