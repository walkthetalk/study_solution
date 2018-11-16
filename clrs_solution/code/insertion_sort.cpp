#include <vector>
#include <iostream>

/// @CLRS \name INSERTION -SORT(A)
void non_inc_insertion_sort(std::vector<int> & A)
{
	/// @CLRS for j = 2 to A.length
	for (std::size_t j = 1; j < A.size(); ++j) {
		/// @CLRS key = A[j]
		auto key = A[j];
		/// @CLRS // Insert A[j] into the sorted sequence A[1 .. j-1].
		/// @CLRS i = j - 1
		auto i = j;
		/// @CLRS while i > 0 and A[i] > key
		while (i > 0 && A[i-1] > key) {
			/// @CLRS A[i + 1] = A[i]
			A[i] = A[i-1];
			/// @CLRS i = i - 1
			--i;
		}
		/// @CLRS A[i + 1] = key
		A[i] = key;
	}
}

void non_dec_insertion_sort(std::vector<int> & A)
{
	for (std::size_t j = 1; j < A.size(); ++j) {
		auto key = A[j];
		// Insert A[j] into the sorted sequence A[0 .. j-1].
		auto i = j;
		while (i > 0 && A[i-1] < key) {
			A[i] = A[i-1];
			--i;
		}
		A[i] = key;
	}
}

int main(void)
{
	std::vector<int> A = {5,2,4,6,1,3};
	//std::vector<int> A = {31, 41, 59, 26, 41, 58};
	non_inc_insertion_sort(A);
	//non_dec_insertion_sort(A);
	for (auto & i : A) {
		std::cout << i << " ";
	}
	std::cout << std::endl;

	return 0;
}
