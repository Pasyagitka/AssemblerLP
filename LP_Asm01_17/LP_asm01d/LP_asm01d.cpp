extern "C"
{
	int getmin(int* array, int arraylength)
	{
		int min = array[0];
		for (int i = 0; i < arraylength; i++)
			if (array[i] < min)
				min = array[i];
		return min;
	}
	int getmax(int* array, int arraylength)
	{
		int max = array[0];
		for (int i = 0; i < arraylength; i++)
			if (array[i] > max)
				max = array[i];
		return max;
	}
}