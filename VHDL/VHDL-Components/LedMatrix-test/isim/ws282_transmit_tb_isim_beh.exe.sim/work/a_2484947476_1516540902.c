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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Tim/Documents/School/Digitale systemen/Project-LedMatrix/ws282_transmit.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

unsigned char ieee_p_1242562249_sub_1781507893_1035706684(char *, char *, char *, int );
char *ieee_p_1242562249_sub_180853171_1035706684(char *, char *, int , int );
char *ieee_p_1242562249_sub_1919437128_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_2484947476_1516540902_p_0(char *t0)
{
    char t19[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    int t14;
    int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    static char *nl0[] = {&&LAB6, &&LAB7, &&LAB8, &&LAB9, &&LAB10, &&LAB11};

LAB0:    xsi_set_current_line(39, ng0);
    t1 = (t0 + 1152U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 5040);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(40, ng0);
    t3 = (t0 + 1832U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t3 = (char *)((nl0) + t5);
    goto **((char **)t3);

LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(42, ng0);
    t6 = (t0 + 5136);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(43, ng0);
    t1 = (t0 + 2472U);
    t3 = *((char **)t1);
    t5 = *((unsigned char *)t3);
    t11 = (t5 == (unsigned char)3);
    if (t11 == 1)
        goto LAB15;

LAB16:    t2 = (unsigned char)0;

LAB17:    if (t2 != 0)
        goto LAB12;

LAB14:
LAB13:    goto LAB5;

LAB7:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 5136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(51, ng0);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t1 = (t0 + 2152U);
    t4 = *((char **)t1);
    t14 = *((int *)t4);
    t15 = (t14 - 23);
    t16 = (t15 * -1);
    xsi_vhdl_check_range_of_index(23, 0, -1, t14);
    t17 = (1U * t16);
    t18 = (0 + t17);
    t1 = (t3 + t18);
    t2 = *((unsigned char *)t1);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB18;

LAB20:    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t1 = (t0 + 2152U);
    t4 = *((char **)t1);
    t14 = *((int *)t4);
    t15 = (t14 - 23);
    t16 = (t15 * -1);
    xsi_vhdl_check_range_of_index(23, 0, -1, t14);
    t17 = (1U * t16);
    t18 = (0 + t17);
    t1 = (t3 + t18);
    t2 = *((unsigned char *)t1);
    t5 = (t2 == (unsigned char)2);
    if (t5 != 0)
        goto LAB23;

LAB24:
LAB19:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 5264);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB8:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 2312U);
    t3 = *((char **)t1);
    t1 = (t0 + 8992U);
    t2 = ieee_p_1242562249_sub_1781507893_1035706684(IEEE_P_1242562249, t3, t1, 0);
    if (t2 != 0)
        goto LAB27;

LAB29:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 2312U);
    t3 = *((char **)t1);
    t1 = (t0 + 8992U);
    t4 = ieee_p_1242562249_sub_1919437128_1035706684(IEEE_P_1242562249, t19, t3, t1, 1);
    t6 = (t19 + 12U);
    t16 = *((unsigned int *)t6);
    t17 = (1U * t16);
    t2 = (16U != t17);
    if (t2 == 1)
        goto LAB37;

LAB38:    t7 = (t0 + 5328);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t21 = *((char **)t10);
    memcpy(t21, t4, 16U);
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(70, ng0);
    t1 = (t0 + 5136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB28:    goto LAB5;

LAB9:    xsi_set_current_line(74, ng0);
    t1 = (t0 + 2312U);
    t3 = *((char **)t1);
    t1 = (t0 + 8992U);
    t2 = ieee_p_1242562249_sub_1781507893_1035706684(IEEE_P_1242562249, t3, t1, 0);
    if (t2 != 0)
        goto LAB39;

LAB41:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 2312U);
    t3 = *((char **)t1);
    t1 = (t0 + 8992U);
    t4 = ieee_p_1242562249_sub_1919437128_1035706684(IEEE_P_1242562249, t19, t3, t1, 1);
    t6 = (t19 + 12U);
    t16 = *((unsigned int *)t6);
    t17 = (1U * t16);
    t2 = (16U != t17);
    if (t2 == 1)
        goto LAB45;

LAB46:    t7 = (t0 + 5328);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t21 = *((char **)t10);
    memcpy(t21, t4, 16U);
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(84, ng0);
    t1 = (t0 + 5136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB40:    goto LAB5;

LAB10:    xsi_set_current_line(88, ng0);
    t1 = (t0 + 1992U);
    t3 = *((char **)t1);
    t14 = *((int *)t3);
    t2 = (t14 == 0);
    if (t2 != 0)
        goto LAB47;

LAB49:    xsi_set_current_line(94, ng0);
    t14 = (24 * 1);
    t15 = (t14 - 1);
    t1 = (t0 + 5392);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = t15;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(95, ng0);
    t1 = (t0 + 1992U);
    t3 = *((char **)t1);
    t14 = *((int *)t3);
    t15 = (t14 - 1);
    t1 = (t0 + 5456);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t15;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(96, ng0);
    t1 = (t0 + 5136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB48:    goto LAB5;

LAB11:    xsi_set_current_line(99, ng0);
    t1 = (t0 + 5136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB5;

LAB12:    xsi_set_current_line(45, ng0);
    t1 = (t0 + 5200);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(46, ng0);
    t1 = (t0 + 5264);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB13;

LAB15:    t1 = (t0 + 1352U);
    t4 = *((char **)t1);
    t12 = *((unsigned char *)t4);
    t13 = (t12 == (unsigned char)3);
    t2 = t13;
    goto LAB17;

LAB18:    xsi_set_current_line(52, ng0);
    t6 = (t0 + 3248U);
    t7 = *((char **)t6);
    t20 = *((int *)t7);
    t6 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t19, t20, 16);
    t11 = (16U != 16U);
    if (t11 == 1)
        goto LAB21;

LAB22:    t8 = (t0 + 5328);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t21 = (t10 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t6, 16U);
    xsi_driver_first_trans_fast(t8);
    goto LAB19;

LAB21:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB22;

LAB23:    xsi_set_current_line(55, ng0);
    t6 = (t0 + 3008U);
    t7 = *((char **)t6);
    t20 = *((int *)t7);
    t6 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t19, t20, 16);
    t11 = (16U != 16U);
    if (t11 == 1)
        goto LAB25;

LAB26:    t8 = (t0 + 5328);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t21 = (t10 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t6, 16U);
    xsi_driver_first_trans_fast(t8);
    goto LAB19;

LAB25:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB26;

LAB27:    xsi_set_current_line(61, ng0);
    t4 = (t0 + 1032U);
    t6 = *((char **)t4);
    t4 = (t0 + 2152U);
    t7 = *((char **)t4);
    t14 = *((int *)t7);
    t15 = (t14 - 23);
    t16 = (t15 * -1);
    xsi_vhdl_check_range_of_index(23, 0, -1, t14);
    t17 = (1U * t16);
    t18 = (0 + t17);
    t4 = (t6 + t18);
    t5 = *((unsigned char *)t4);
    t11 = (t5 == (unsigned char)3);
    if (t11 != 0)
        goto LAB30;

LAB32:    xsi_set_current_line(64, ng0);
    t1 = (t0 + 3128U);
    t3 = *((char **)t1);
    t14 = *((int *)t3);
    t1 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t19, t14, 16);
    t2 = (16U != 16U);
    if (t2 == 1)
        goto LAB35;

LAB36:    t4 = (t0 + 5328);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 16U);
    xsi_driver_first_trans_fast(t4);

LAB31:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 5136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(67, ng0);
    t1 = (t0 + 5264);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB28;

LAB30:    xsi_set_current_line(62, ng0);
    t8 = (t0 + 3368U);
    t9 = *((char **)t8);
    t20 = *((int *)t9);
    t8 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t19, t20, 16);
    t12 = (16U != 16U);
    if (t12 == 1)
        goto LAB33;

LAB34:    t10 = (t0 + 5328);
    t21 = (t10 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t8, 16U);
    xsi_driver_first_trans_fast(t10);
    goto LAB31;

LAB33:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB34;

LAB35:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB36;

LAB37:    xsi_size_not_matching(16U, t17, 0);
    goto LAB38;

LAB39:    xsi_set_current_line(75, ng0);
    t4 = (t0 + 2152U);
    t6 = *((char **)t4);
    t14 = *((int *)t6);
    t15 = (t14 - 1);
    t4 = (t0 + 5392);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t15;
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(76, ng0);
    t1 = (t0 + 5136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(77, ng0);
    t1 = (t0 + 2152U);
    t3 = *((char **)t1);
    t14 = *((int *)t3);
    t2 = (t14 != 0);
    if (t2 != 0)
        goto LAB42;

LAB44:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 5264);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);

LAB43:    goto LAB40;

LAB42:    xsi_set_current_line(78, ng0);
    t1 = (t0 + 5264);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB43;

LAB45:    xsi_size_not_matching(16U, t17, 0);
    goto LAB46;

LAB47:    xsi_set_current_line(89, ng0);
    t1 = (t0 + 3488U);
    t4 = *((char **)t1);
    t15 = *((int *)t4);
    t1 = (t0 + 5456);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((int *)t9) = t15;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(90, ng0);
    t14 = (24 - 1);
    t15 = (t14 * 1);
    t1 = (t0 + 5392);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((int *)t7) = t15;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(91, ng0);
    t1 = (t0 + 5200);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(92, ng0);
    t1 = (t0 + 5264);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB48;

}

static void work_a_2484947476_1516540902_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(103, ng0);

LAB3:    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 5520);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 5056);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2484947476_1516540902_init()
{
	static char *pe[] = {(void *)work_a_2484947476_1516540902_p_0,(void *)work_a_2484947476_1516540902_p_1};
	xsi_register_didat("work_a_2484947476_1516540902", "isim/ws282_transmit_tb_isim_beh.exe.sim/work/a_2484947476_1516540902.didat");
	xsi_register_executes(pe);
}
