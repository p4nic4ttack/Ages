/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif



static void work_a_1335952598_1516540902_p_0(char *t0)
{
    char *t1;

LAB0:    t1 = (t0 + 3984);
    *((int *)t1) = 1;

LAB1:    return;
}


extern void work_a_1335952598_1516540902_init()
{
	static char *pe[] = {(void *)work_a_1335952598_1516540902_p_0};
	xsi_register_didat("work_a_1335952598_1516540902", "isim/top_tb_isim_beh.exe.sim/work/a_1335952598_1516540902.didat");
	xsi_register_executes(pe);
}
