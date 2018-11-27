
// count the arguments
#define PP_NARG(...) PP_NARG_(__VA_ARGS__)
#define PP_NARG_(...) \
	PP_NARG__(x, ##__VA_ARGS__, PP_RSEQ_N())
#define PP_NARG__(...) \
	PP_ARG_N(__VA_ARGS__)
#define PP_ARG_N( \
	 _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, \
	_10,_11,_12,_13,_14,_15,_16,_17,_18,_19, \
	_20,_21,_22,_23,_24,_25,_26,_27,_28,_29, \
	_30,_31,_32,_33,_34,_35,_36,_37,_38,_39, \
	_40,_41,_42,_43,_44,_45,_46,_47,_48,_49, \
	_50,_51,_52,_53,_54,_55,_56,_57,_58,_59, \
	_60,_61,_62,_63,_64,N,...) N
#define PP_RSEQ_N() \
	64,63,62,61,60,                   \
	59,58,57,56,55,54,53,52,51,50, \
	49,48,47,46,45,44,43,42,41,40, \
	39,38,37,36,35,34,33,32,31,30, \
	29,28,27,26,25,24,23,22,21,20, \
	19,18,17,16,15,14,13,12,11,10, \
	9,8,7,6,5,4,3,2,1,0

// concatenate two str
#define PP_CONCATENATE(arg1, arg2) PP_CONCATENATE_(arg1, arg2)
#define PP_CONCATENATE_(arg1, arg2) PP_CONCATENATE__(arg1, arg2)
#define PP_CONCATENATE__(arg1, arg2) arg1##arg2

// forward / backward traverse
#define SRD_FW(x, y, ...) x; y, ##__VA_ARGS__
#define SRD_BW(x, y, ...) y, ##__VA_ARGS__; x

// recurrence of bit-fields
#define SRD_FOREACH_16(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_15(dir, type, __VA_ARGS__))
#define SRD_FOREACH_15(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_14(dir, type, __VA_ARGS__))
#define SRD_FOREACH_14(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_13(dir, type, __VA_ARGS__))
#define SRD_FOREACH_13(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_12(dir, type, __VA_ARGS__))
#define SRD_FOREACH_12(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_11(dir, type, __VA_ARGS__))
#define SRD_FOREACH_11(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_10(dir, type, __VA_ARGS__))
#define SRD_FOREACH_10(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_9(dir, type, __VA_ARGS__))
#define SRD_FOREACH_9(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_8(dir, type, __VA_ARGS__))
#define SRD_FOREACH_8(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_7(dir, type, __VA_ARGS__))
#define SRD_FOREACH_7(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_6(dir, type, __VA_ARGS__))
#define SRD_FOREACH_6(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_5(dir, type, __VA_ARGS__))
#define SRD_FOREACH_5(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_4(dir, type, __VA_ARGS__))
#define SRD_FOREACH_4(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_3(dir, type, __VA_ARGS__))
#define SRD_FOREACH_3(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_2(dir, type, __VA_ARGS__))
#define SRD_FOREACH_2(dir, type, x, ...) SRD_##dir( \
		SRD_FOREACH_1(dir, type, x), \
		SRD_FOREACH_1(dir, type, __VA_ARGS__))
#define SRD_FOREACH_1(dir, type, x) type x

// traverse bit-fields by specific direction (backward or forward)
#define SRD_FOREACH(dir, type, x, ...) \
	PP_CONCATENATE(SRD_FOREACH_, PP_NARG(x, ##__VA_ARGS__)) \
		(dir, type, x, ##__VA_ARGS__)

// used to define bit-fields, assume listed from msb to lsb
#if __BYTE_ORDER == __LITTLE_ENDIAN
# define SRD_REG_BF(type, x, ...) SRD_FOREACH(BW, type, x, ##__VA_ARGS__)
#elif __BYTE_ORDER == __BIG_ENDIAN
# define SRD_REG_BF(type, x, ...) SRD_FOREACH(FW, type, x, ##__VA_ARGS__)
#else
#error "I don't know the endian mode"
#endif

//example

#define SRD_TEST_REG(name, bf, ...) \
	union { \
		volatile u_int16_t v; \
		struct { \
			SRD_REG_BF(volatile u_int16_t, bf, ##__VA_ARGS__); \
		} _bf; \
	} name

struct test_chip_t {
	SRD_TEST_REG(test_reg1,
		a : 3,
		b : 4,
		c : 5,
		d : 4);
	SRD_TEST_REG(test_reg2,
		a : 3,
		b : 4,
		c : 5,
		d : 4);
};


