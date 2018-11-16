#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include <limits.h>

#define CROSSOVER_POINT 30

// A struct to represent the tuple
typedef struct {
	unsigned left;
	unsigned right;
	int sum;
} max_subarray;

// The brute force approach
// high must greater than low
max_subarray find_maximum_subarray_brute(int A[], unsigned low, unsigned high) {
	max_subarray result = {0, 0, INT_MIN};

	for (int i = low; i < high; i++) {
		int current_sum = 0;
		for (int j = i; j < high; j++) {
			current_sum += A[j];
			if (result.sum < current_sum) {
				result.left = i;
				result.right = j + 1;
				result.sum = current_sum;
			}
		}
	}

	return result;
}

// The divide-and-conquer solution
max_subarray find_max_crossing_subarray(int A[], unsigned low, unsigned mid, unsigned high) {
	max_subarray result = {-1, -1, 0};
	int sum = 0,
		left_sum = INT_MIN,
		right_sum = INT_MIN;

	for (int i = mid - 1; i >= (int) low; i--) {
		sum += A[i];
		if (sum > left_sum) {
			left_sum = sum;
			result.left = i;
		}
	}

	sum = 0;

	for (int j = mid; j < high; j++) {
		sum += A[j];
		if (sum > right_sum) {
			right_sum = sum;
			result.right = j + 1;
		}
	}

	result.sum = left_sum + right_sum;
	return result;
}

max_subarray find_maximum_subarray(int A[], unsigned low, unsigned high) {
	if (high == low + 1) {
		max_subarray result = {low, high, A[low]};
		return result;
	} else {
		unsigned mid = (low + high) / 2;
		max_subarray left = find_maximum_subarray(A, low, mid);
		max_subarray right = find_maximum_subarray(A, mid, high);
		max_subarray cross = find_max_crossing_subarray(A, low, mid, high);

		if (left.sum >= right.sum && left.sum >= cross.sum) {
			return left;
		} else if (right.sum >= left.sum && right.sum >= cross.sum) {
			return right;
		} else {
			return cross;
		}
	}
}

// The mixed algorithm
max_subarray find_maximum_subarray_mixed(int A[], unsigned low, unsigned high) {
	if (high - low < CROSSOVER_POINT) {
		return find_maximum_subarray_brute(A, low, high);
	}
	else {
		unsigned mid = (low + high) / 2;
		max_subarray left = find_maximum_subarray_mixed(A, low, mid);
		max_subarray right = find_maximum_subarray_mixed(A, mid, high);
		max_subarray cross = find_max_crossing_subarray(A, low, mid, high);

		if (left.sum >= right.sum && left.sum >= cross.sum) {
			return left;
		} else if (right.sum >= left.sum && right.sum >= cross.sum) {
			return right;
		} else {
			return cross;
		}
	}
}

static int A[100] = {};

static inline struct timespec get_time()
{
	struct timespec ret = { 0, 0, };
	int sys_ret = clock_gettime(CLOCK_MONOTONIC, &ret);
	if (sys_ret < 0) {
		perror("clock_gettime");
	}

	return ret;
}

static inline struct timespec time_sub(struct timespec * low, struct timespec * high)
{
	struct timespec ret = { 0, 0, };

	ret.tv_sec = high->tv_sec - low->tv_sec;
	ret.tv_nsec = high->tv_nsec - low->tv_nsec;
	if (high->tv_nsec < low->tv_nsec) {
		--ret.tv_sec;
		ret.tv_nsec += 1000000000L;
	}

	return ret;
}

static inline void time_add(struct timespec * dst, struct timespec * high)
{
	dst->tv_sec += high->tv_sec;
	dst->tv_nsec += high->tv_nsec;

	if (dst->tv_nsec > 1000000000L) {
		++dst->tv_sec;
		dst->tv_nsec -= 1000000000L;
	}
}

static void init_data(void)
{
	srand(time(NULL));	//use current time as seed for random generator
	for (int i = 0; i < sizeof(A)/sizeof(A[0]); ++i) {
		A[i] = rand() / 256;
	}
}

int main(void)
{
	for (int i = 1; i < sizeof(A)/sizeof(A[0]); ++i) {
		init_data();
		struct timespec sub0 = {0,0}, sub1 = {0,0};
		for (int j = 0; j < 100000; ++j) {
			struct timespec ts0 = get_time();
			find_maximum_subarray_brute(A, 0, i);
			struct timespec ts1 = get_time();
			find_maximum_subarray_mixed(A, 0, i);
			struct timespec ts2 = get_time();

			struct timespec _sub0 = time_sub(&ts0, &ts1);
			struct timespec _sub1 = time_sub(&ts1, &ts2);

			time_add(&sub0, &_sub0);
			time_add(&sub1, &_sub1);
		}
		printf("%li.%09li   %li.%09li", sub0.tv_sec, sub0.tv_nsec, sub1.tv_sec, sub1.tv_nsec);

		printf("    %02d ", i);
		if (sub0.tv_sec > sub1.tv_sec
			|| (sub0.tv_sec == sub1.tv_sec && sub0.tv_nsec > sub1.tv_nsec)) {
			printf("****");
		}

		printf("\n");
	}

	return 0;
}
