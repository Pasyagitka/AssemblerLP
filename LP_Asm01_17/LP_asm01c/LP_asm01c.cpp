#include <iostream>
#pragma comment (lib, "..\\Debug\\LP_asm01a.lib")

extern "C"
{
	int __stdcall getmin(int*, int);
	int __stdcall getmax(int*, int);
}

int main()
{
	int MyArray[] = { 79, 4, 38, 91, 6, 12, 16, 54, -3, 8 };
	int max = getmax(MyArray, sizeof(MyArray) / sizeof(int));
	int min = getmin(MyArray, sizeof(MyArray) / sizeof(int));
	std::cout << "getmax-getmin=" << max - min << std::endl;
}