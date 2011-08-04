
typedef struct packed
{
	bit [8:0]	__reserved_0;
	bit	[2:0]	tc;
	bit [3:0]	__reserved_1;
	bit			td;
	bit			ep;
	bit [1:0]	attr;
	bit [1:0]	__reserved_2;
	bit [9:0]	length;
	bit [15:0]	requester_id;
	bit [7:0]	tag;
	bit [3:0]	last_be;
	bit [3:0]	first_be;
	bit [29:0]	address;
	bit [1:0]	__reserved_3;
	bit [31:0]	__reserved_4;
} tlp_mem_rd_32_struct;


typedef struct packed
{
	bit [8:0]	__reserved_0;	//0x080
	bit [2:0]	tc;
	bit [3:0]	__reserved_1;
	bit			td;
	bit			ep;
	bit [1:0]	attr;
	bit [1:0]	__reserved_2;
	bit [9:0]	length;
	bit [15:0]	requester_id;
	bit [7:0]	tag;
	bit [3:0]	last_be;
	bit [3:0]	first_be;
	bit [29:0]	address;
	bit [1:0]	__reserved_3;
	bit [31:0]	__reserved_4;
} tlp_mem_wr_32_struct;

typedef struct packed
{
	bit [8:0]	__reserved_0;	//0x94
	bit [2:0]	tc;
	bit [3:0]	__reserved_1;
	bit			td;
	bit			ep;
	bit [1:0]	attr;
	bit [1:0]	__reserved_2;
	bit [9:0]	length;
	bit [15:0]	completer_id;
	bit [2:0]	status;
	bit			b;
	bit [11:0]	byte_count;
	bit [15:0]	requester_id;
	bit [7:0]	tag;
	bit			__reserved_3;
	bit [6:0]	lower_address;
	bit [31:0]	__reserved_4;
} tlp_cpl_with_data_struct;

typedef struct packed
{
	bit [31:0] dw0;
	bit [31:0] dw1;
	bit [31:0] dw2;
	bit [31:0] dw3;
} tlp_cpl_payload;

