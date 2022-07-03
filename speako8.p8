pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
buffer=0x8000

-- see https://www.fon.hum.uva.nl/david/ma_ssp/doc/Klatt-1980-JAS000971.pdf for background

impulse=1000 --for glottal click train

--for vocal fold filter
voicing_f0={[0]=140,154,147}
voicing_tone=0
voicing_intonation=-1
voicing_breathiness=0
voice_x=0

--voicing_stress={0,.02,.01,}
--w0=5512.5\(voicing_f0)--140--140--175 --voice fundemental wavelength
rgp_y0,rgp_y1,rgp_y2,rnp_y0,rnp_y1,rnp_y2,rnz_y0,rnz_y1,rnz_y2,rgz_y0,rgz_y1,rgz_y2,rgs_y0,rgs_y1,rgs_y2,rgs_y3,rgs_y4=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

ygp,ylgp1,ylgp2,ygz,ylgz1,ylgz2,ygs,ylgs1,ylgs2,ylgs3,ylgs4,yzc,ylnz1c,ylnz2c,ypc,ylnp1c,ylnp2c=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

			

uglotx=0
volume=1
aspiration=1
duration,av,ah,af,av_step,ah_step,_af_step=0,0,0,0,0,0,0
vowel_list=split"aa,ae,ah,ao,aw,ay,eh,er,ey,ih,iy,ow,oy,uh,uw"
sounds={}
cascade,old_cascade={},{}
_noise=0
sample=0
--cascade formants
--[[formants=
{
	{
		aa={2600,160,1220,70,700,130},
		ae={2430,320,1660,150,620,70},
		ah={2550,140,1220,50,620,80},
		ao={2570,80,990,100,600,90},
		aw={2350,80,1100,70,540,80},
		ay={2550,200,1200,70,660,100},
		eh={2520,200,1720,100,480,70},
		er={1540,110,1270,60,470,100},
		ey={2520,200,1720,100,480,70},
		ih={2570,140,1800,100,400,50},
		iy={2960,400,2020,100,310,70},
		ow={2300,70,1100,70,540,80},
		oy={2400,130,960,50,550,60},
		r={1380,120,1060,100,310,70},
		uh={2350,80,1100,100,450,80},
		uw={2200,140,1250,110,350,70},
		y={3020,500,2070,250,260,40},
		w={2150,60,610,80,290,50}
	},
	{
		ao={2570,80,1040,100,630,90},
		aw={2350,80,900,70,450,80},
		ay={2550,200,1880,100,400,70},
		eh={2520,200,1220,100,330,50},
		er={1540,110,1310,60,420,100},
		ey={2600,200,2020,100,330,50},
		ih={2570,140,1600,100,470,50},
		iy={2960,400,2070,100,290,50},
		ow={2300,70,900,70,450,80},
		oy={2400,130,1820,50,360,80},
		uh={2350,80,1180,100,500,80},
		uw={2200,140,900,110,320,70},
	},

}]]
--blend= 0 (sonorant) 1 (HH) 2(no blend)
phone=
{
	AH=
	{
		{{136,1000,0,0,0,0,0,0,{{2550,140},{1220,50},{620,80},{-250,100}}}},
		{{680,1000,4,0,0,0,0,2,{{2550,140},{1220,50},{620,80},{-250,100}}}},
		{{227,1000,4,0,0,0,0,0,{{2550,140},{1220,50},{620,80},{-250,100}}}},
	},
	AO=
	{
		{{76,1000,0,0,0,0,0,0,{{2570,80},{990,100},{600,90},{-250,100}}}},
		{{380,1000,4,0,0,0,0,2,{{2570,80},{990,100},{600,90},{-250,100}}}},
		{{127,1000,4,0,0,0,0,0,{{2570,80},{990,100},{600,90},{-250,100}}}},
	},
	AW= 
	{
		{{70,1000,0,0,0,0,0,0,{{2550,140},{1220,50},{620,80},{-250,100}}}},
		{
			{350,1000,4,0,0,0,0,2,{{2550,140},{1220,50},{620,80},{-250,100}}},
			{350,1000,4,0,0,0,0,0,{{2350,80},{900,70},{450,80},{-250,100}}},
		},	
		{{117,1000,4,0,0,0,0,0,{{2350,80},{900,70},{450,80},{-250,100}}}},
	},
	AY=
	{
		{{70,1000,0,0,0,0,0,0,{{2550,200},{1200,70},{660,100},{-250,100}}}},
		{
			{350,1000,4,0,0,0,0,2,{{2550,200},{1200,70},{660,100},{-250,100}}},
			{350,1000,4,0,0,0,0,0,{{2550,200},{1880,100},{400,70},{-250,100}}},
		},	
		{{117,1000,4,0,0,0,0,0,{{2550,200},{1880,100},{400,70},{-250,100}}}},
	},
	EH=
	{
		{{76,1000,0,0,0,0,0,0,{{2520,200},{1720,100},{480,70},{-250,100}}}},
		{{380,1000,4,0,0,0,0,2,{{2520,200},{1720,100},{480,70},{-250,100}}}},
		{{127,1000,4,0,0,0,0,0,{{2520,200},{1720,100},{480,70},{-250,100}}}},
	},
	ER=
	{
		{{62,1000,0,0,0,0,0,0,{{1540,110},{1270,60},{470,100},{-250,100}}}},
		{
			{310,1000,4,0,0,0,0,2,{{1540,110},{1270,60},{470,100},{-250,100}}},
			{320,1000,4,0,0,0,0,0,{{1540,110},{1310,60},{420,100},{-250,100}}},
		},	
		{{107,1000,4,0,0,0,0,0,{{1540,110},{1310,60},{420,100},{-250,100}}}},
	},
	EY= 
	{
		{{64,1000,0,0,0,0,0,0,{{2520,200},{1720,100},{480,70},{-250,100}}}},
		{
			{320,1000,4,0,0,0,0,2,{{2520,200},{1720,100},{480,70},{-250,100}}},
			{320,1000,4,0,0,0,0,0,{{2600,200},{2020,100},{330,50},{-250,100}}},
		},	
		{{107,1000,4,0,0,0,0,0,{{2600,200},{2020,100},{330,50},{-250,100}}}},
	},	
	
	IH= 
	{
		{{40,1000,0,0,0,0,0,0,{{2570,140},{1800,100},{400,50},{-250,100}}}},
		{
			{400,1000,4,0,0,0,0,2,{{2570,140},{1800,100},{400,50},{-250,100}}},
		},	
		{{67,1000,4,0,0,0,0,0,{{2570,140},{1600,100},{470,50},{-250,100}}}},
	},
	IY= 
	{
		{{56,1000,0,0,0,0,0,0,{{2960,400},{2020,100},{310,70},{-250,100}}}},
		{
			{560,1000,4,0,0,0,0,2,{{2960,400},{2020,100},{310,70},{-250,100}}},
			
		},	
		{{93,1000,4,0,0,0,0,1,{{2960,400},{2070,100},{290,50},{-250,100}}}},
	},
	OW= 
	{
		{{64,1000,0,0,0,0,0,0,{{2300,70},{1100,70},{540,80},{-250,100}}}},
		{
			{320,1000,4,0,0,0,0,2,{{2300,70},{1100,70},{540,80},{-250,100}}},
			{320,1000,4,0,0,0,0,0,{{2300,70},{900,70},{450,80},{-250,100}}},
		},	
		{{107,1000,4,0,0,0,0,0,{{2300,70},{900,70},{450,80},{-250,100}}}},
	},
	OY=
	{
		{{70,1000,0,0,0,0,0,0,{{2400,130},{960,50},{550,60},{-250,100}}}},
		{
			{350,1000,4,0,0,0,0,2,{{2400,130},{960,50},{550,60},{-250,100}}},
			{350,1000,4,0,0,0,0,0,{{2400,130},{1820,50},{360,80},{-250,100}}},
		},
		{{117,1000,4,0,0,0,0,0,{{2400,130},{1820,50},{360,80},{-250,100}}}},
	},
	UH=
	{
		{{40,1000,0,0,0,0,0,0,{{2350,80},{1100,100},{450,80},{-250,100}}}},
		{
			{200,1000,4,0,0,0,0,2,{{2350,80},{1100,100},{450,80},{-250,100}}},
			{200,1000,4,0,0,0,0,0,{{2350,80},{1180,100},{500,80},{-250,100}}},
		},	
		{{67,1000,4,0,0,0,0,0,{{2350,80},{1180,100},{500,80},{-250,100}}}},
	},
	UW=
	{
		{{54,1000,0,0,0,0,0,0,{{2200,140},{1250,110},{350,70},{-250,100}}}},
		{
			{270,1000,4,0,0,0,0,2,{{2200,140},{1250,110},{350,70},{-250,100}}},
			{270,1000,4,0,0,0,0,0,{{2200,140},{900,110},{320,70},{-250,100}}},
		},	
		{{90,1000,4,0,0,0,0,0,{{2200,140},{900,110},{320,70},{-250,100}}}},
	},
	HH=
	{
		{{400,0,0,0,2,0,0,0,nil}},
		{{30,0,0,2,2,0,0,1,nil}},
		{{100,0,0,2,0,0,0,1,nil}},
	},
	L=
	{
		{{100,1000,0,0,0,0,0,0,{{2880,280},{1050,100},{310,50},{-250,100}}}},
		{{300,1000,4,0,0,0,0,2.4,{{2880,280},{1050,100},{310,50},{-250,100}}}},
		{{500,500,4,0,0,0,0,0,{{2880,280},{1050,100},{310,50},{-250,100}}}},

	},
	LL=
	{
		{{1,1000,0,0,0,0,0,0,{{2880,280},{1050,100},{310,50},{-250,100}}}},
		{
			{100,1000,4,0,0,0,0,2.4,{{2880,280},{1050,100},{310,50},{-250,100}}},
			{200,750,4,0,0,0,0,0,{{2880,280},{850,100},{470,50},{-250,100}}},
		},	
		{
			{200,350,4,0,0,0,0,0,{{2880,280},{850,100},{470,50},{-250,100}}},
			{100,350,4,0,0,0,0,0,{{2550,140},{1220,50},{620,80},{-250,100}}},
		},
	
	},


	M=
	{
		{{130,1000,0,0,0,0,0,0,{{2150,200},{1100,150},{400,300},{-450,100}}}},
		{
			{250,1000,4,0,0,0,0,2.4,{{2150,200},{1100,150},{400,300},{-450,100}}},
		},	
		{
			{130,1000,4,0,0,0,0,0,{{2150,200},{1100,150},{400,300},{-450,100}}},
			{100,1000,4,0,0,0,0,0,{{2550,140},{1800,50},{620,80},{-250,0}}},

		},
	},

	N=
	{
		{{140,1000,0,0,0,0,0,0,{{2600,170},{1600,100},{200,60},{-450,100}}}},
		{
			{230,1000,4,0,0,0,0,2.4,{{2600,170},{1600,100},{200,60},{-450,100}}},
	
		},	
		{
			{140,1000,0,0,0,0,0,0,{{2600,170},{1600,100},{200,60},{-450,100}}},
			{100,1000,4,0,0,0,0,0,{{2550,140},{1800,50},{620,80},{-250,0}}},
		},
	},
	NG=
	{
		{{140,1000,0,0,0,0,0,0,{{2850,280},{1990,150},{200,60},{-450,0}}}},
		{
			{380,1000,4,0,0,0,0,2.4,{{2850,280},{1990,150},{200,60},{-450,0}}},
		},	
		{
			{140,1000,4,0,0,0,0,0,{{2850,280},{1990,150},{200,60},{-450,0}}},
			{100,1000,4,0,0,0,0,0,{{2550,140},{1800,50},{620,80},{-250,0}}},
		},
	},
	R=
	{
		{{200,1000,0,0,0,0,0,0,{{1380,120},{1060,100},{310,70},{-250,100}}}},
		{{390,1000,4,0,0,0,0,2,{{1380,120},{1060,100},{310,70},{-250,100}}}},
		{{200,800,4,0,0,0,0,0,{{1380,120},{1060,100},{310,70},{-250,100}}}},
	},
	W=
	{
		{{590,70,260,0,0,0,0,0,{{2150,60},{610,80},{290,50},{-250,100}}}},
		{{215,260,260,0,0,0,0,2,{{2150,60},{610,80},{290,50},{-250,100}}}},
		{{30,260,260,0,0,0,0,0,{{2150,60},{610,80},{290,50},{-250,100}}}},
	},
	WW=
	{
		{{40,260,260,0,0,0,0,0,{{2150,60},{610,80},{290,50},{-250,100}}}},
		{{40,260,260,0,0,0,0,2,{{2150,60},{610,80},{290,50},{-250,100}}}},
		{{40,260,260,0,0,0,0,0,{{2150,60},{610,80},{290,50},{-250,100}}}},
	},

	Y=
	{
		{{200,1000,1000,0,0,0,0,0,{{3020,500},{2070,250},{260,40},{-250,100}}}},
		{{400,1000,1000,0,0,0,0,2,{{3020,500},{2070,250},{260,40},{-250,100}}}},
		{{200,1000,0,0,0,0,0,0,{{3020,500},{2070,250},{260,40},{-250,100}}}},
	},
}
phone["_"]=1
phone[","]=2
phone["."]=3
-- b coefficient first factor = =2*exp(-pi()*bandwidth/5512.5)  
b_factor=split"2,0x1.fd17,0x1.fa32,0x1.f752,0x1.f475,0x1.f19d,0x1.eec9,0x1.ebfa,0x1.e92e,0x1.e666,0x1.e3a3,0x1.e0e3,0x1.de27,0x1.db70,0x1.d8bc,0x1.d60c,0x1.d360,0x1.d0b9,0x1.ce14,0x1.cb74,0x1.c8d8,0x1.c63f,0x1.c3aa,0x1.c119,0x1.be8c,0x1.bc02,0x1.b97c,0x1.b6fa,0x1.b47b,0x1.b200,0x1.af89,0x1.ad15,0x1.aaa5,0x1.a838,0x1.a5cf,0x1.a369,0x1.a107,0x1.9ea9,0x1.9c4d,0x1.99f6,0x1.97a1,0x1.9550,0x1.9302,0x1.90b8,0x1.8e71,0x1.8c2e,0x1.89ed,0x1.87b0,0x1.8576,0x1.8340,0x1.810c,0x1.7edc,0x1.7caf,0x1.7a85,0x1.785f,0x1.763b,0x1.741b,0x1.71fd,0x1.6fe3,0x1.6dcc,0x1.6bb8,0x1.69a7,0x1.6798,0x1.658d,0x1.6385,0x1.6180,0x1.5f7e,0x1.5d7e,0x1.5b82,0x1.5988,0x1.5792,0x1.559e,0x1.53ad,0x1.51bf,0x1.4fd3,0x1.4deb,0x1.4c05,0x1.4a22,0x1.4842,0x1.4664,0x1.4489,0x1.42b1,0x1.40dc,0x1.3f09,0x1.3d39,0x1.3b6b,0x1.39a0,0x1.37d8,0x1.3612,0x1.344f,0x1.328f,0x1.30d1,0x1.2f15,0x1.2d5c,0x1.2ba6,0x1.29f2,0x1.2841,0x1.2692,0x1.24e5,0x1.233b,0x1.2193,0x1.1fee,0x1.1e4b,0x1.1cab,0x1.1b0c,0x1.1971,0x1.17d7,0x1.1640,0x1.14ab,0x1.1319,0x1.1189,0x1.0ffb,0x1.0e6f,0x1.0ce5,0x1.0b5e,0x1.09d9,0x1.0857,0x1.06d6,0x1.0558,0x1.03db,0x1.0261,0x1.00e9,0x.ff74,0x.fe00,0x.fc8f,0x.fb1f,0x.f9b2,0x.f847,0x.f6dd,0x.f576,0x.f411,0x.f2ae,0x.f14d,0x.efee,0x.ee91,0x.ed36,0x.ebdd,0x.ea86,0x.e930,0x.e7dd,0x.e68c,0x.e53c,0x.e3ef,0x.e2a3,0x.e15a,0x.e012,0x.decc,0x.dd88,0x.dc45,0x.db05,0x.d9c6,0x.d889,0x.d74e,0x.d615,0x.d4de,0x.d3a8,0x.d274,0x.d142,0x.d012,0x.cee3,0x.cdb6,0x.cc8b,0x.cb61,0x.ca39,0x.c913,0x.c7ee,0x.c6cc,0x.c5aa,0x.c48b,0x.c36d,0x.c251,0x.c136,0x.c01d,0x.bf05,0x.bdef,0x.bcdb,0x.bbc8,0x.bab7,0x.b9a7,0x.b899,0x.b78d,0x.b682,0x.b578,0x.b470,0x.b36a,0x.b265,0x.b161,0x.b05f,0x.af5f,0x.ae5f,0x.ad62,0x.ac66,0x.ab6b,0x.aa71,0x.a979,0x.a883,0x.a78e,0x.a69a,0x.a5a8,0x.a4b7,0x.a3c7,0x.a2d9,0x.a1ec,0x.a100,0x.a016,0x.9f2d,0x.9e45,0x.9d5f,0x.9c7a,0x.9b97,0x.9ab4,0x.99d3,0x.98f3,0x.9815,0x.9738,0x.965c,0x.9581,0x.94a7,0x.93cf,0x.92f8,0x.9222,0x.914e,0x.907a,0x.8fa8,0x.8ed7,0x.8e07,0x.8d39,0x.8c6b,0x.8b9f,0x.8ad4,0x.8a0a,0x.8941,0x.8879,0x.87b3,0x.86ed,0x.8629,0x.8566,0x.84a4,0x.83e3,0x.8323,0x.8264,0x.81a7,0x.80ea,0x.802e,0x.7f74,0x.7eba,0x.7e02,0x.7d4b,0x.7c94,0x.7bdf,0x.7b2b,0x.7a78,0x.79c6,0x.7915,0x.7864,0x.77b5,0x.7707,0x.765a,0x.75ae,0x.7503,0x.7458,0x.73af,0x.7307,0x.725f,0x.71b9,0x.7114,0x.706f,0x.6fcb,0x.6f29,0x.6e87,0x.6de6,0x.6d46,0x.6ca7,0x.6c09,0x.6b6c,0x.6ad0,0x.6a35"


-- c coefficient = exp(-2*pi()*bandwidth/5512.5)  final value needs to be negative
c_factor=split"1,0x.fd19,0x.fa3a,0x.f764,0x.f497,0x.f1d1,0x.ef13,0x.ec5e,0x.e9b0,0x.e70a,0x.e46c,0x.e1d5,0x.df46,0x.dcbe,0x.da3d,0x.d7c4,0x.d552,0x.d2e7,0x.d083,0x.ce26,0x.cbd0,0x.c981,0x.c738,0x.c4f6,0x.c2bb,0x.c086,0x.be57,0x.bc2f,0x.ba0d,0x.b7f1,0x.b5dc,0x.b3cc,0x.b1c2,0x.afbf,0x.adc1,0x.abc9,0x.a9d6,0x.a7e9,0x.a602,0x.a421,0x.a244,0x.a06e,0x.9e9c,0x.9cd0,0x.9b09,0x.9947,0x.978a,0x.95d3,0x.9420,0x.9272,0x.90c9,0x.8f25,0x.8d86,0x.8beb,0x.8a55,0x.88c4,0x.8737,0x.85af,0x.842b,0x.82ac,0x.8130,0x.7fba,0x.7e47,0x.7cd9,0x.7b6e,0x.7a08,0x.78a6,0x.7748,0x.75ee,0x.7498,0x.7346,0x.71f7,0x.70ad,0x.6f66,0x.6e22,0x.6ce3,0x.6ba7,0x.6a6f,0x.693a,0x.6809,0x.66db,0x.65b0,0x.6489,0x.6366,0x.6245,0x.6128,0x.600e,0x.5ef7,0x.5de4,0x.5cd3,0x.5bc6,0x.5abc,0x.59b5,0x.58b0,0x.57af,0x.56b1,0x.55b5,0x.54bc,0x.53c7,0x.52d4,0x.51e3,0x.50f6,0x.500b,0x.4f22,0x.4e3d,0x.4d5a,0x.4c79,0x.4b9c,0x.4ac0,0x.49e7,0x.4911,0x.483d,0x.476b,0x.469c,0x.45cf,0x.4505,0x.443c,0x.4376,0x.42b3,0x.41f1,0x.4132,0x.4075,0x.3fba,0x.3f01,0x.3e4a,0x.3d95,0x.3ce3,0x.3c32,0x.3b83,0x.3ad7,0x.3a2c,0x.3983,0x.38dc,0x.3837,0x.3794,0x.36f3,0x.3653,0x.35b6,0x.351a,0x.3480,0x.33e8,0x.3351,0x.32bc,0x.3229,0x.3197,0x.3107,0x.3079,0x.2fed,0x.2f62,0x.2ed8,0x.2e50,0x.2dca,0x.2d45,0x.2cc2,0x.2c40,0x.2bbf,0x.2b40,0x.2ac3,0x.2a47,0x.29cc,0x.2953,0x.28db,0x.2864,0x.27ef,0x.277b,0x.2709,0x.2698,0x.2628,0x.25b9,0x.254b,0x.24df,0x.2474,0x.240a,0x.23a2,0x.233b,0x.22d4,0x.226f,0x.220b,0x.21a9,0x.2147,0x.20e6,0x.2087,0x.2029,0x.1fcb,0x.1f6f,0x.1f14,0x.1eba,0x.1e60,0x.1e08,0x.1db1,0x.1d5b,0x.1d06,0x.1cb2,0x.1c5e,0x.1c0c,0x.1bbb,0x.1b6a,0x.1b1b,0x.1acc,0x.1a7e,0x.1a31,0x.19e5,0x.199a,0x.1950,0x.1907,0x.18be,0x.1876,0x.182f,0x.17e9,0x.17a4,0x.175f,0x.171b,0x.16d8,0x.1696,0x.df50,0x.1614,0x.15d3,0x.1594,0x.1556,0x.1518,0x.14da,0x.149e,0x.cbd9,0x.1427,0x.13ec,0x.13b3,0x.137a,0x.1341,0x.1309,0x.12d2,0x.ba15,0x.1265,0x.1230,0x.11fb,0x.11c7,0x.1193,0x.1160,0x.112e,0x.a9de,0x.10cb,0x.109a,0x.106a,0x.103a,0x.100b,0x.0fdd,0x.0faf,0x.9b10,0x.0f54,0x.0f28,0x.0efc,0x.0ed0,0x.0ea5,0x.0e7b,0x.0e51,0x.8d8c,0x.0dfe,0x.0dd6,0x.0dad,0x.0d86,0x.0d5e,0x.0d38,0x.0d11,0x.8136,0x.0cc6,0x.0ca1,0x.0c7c,0x.0c58,0x.0c34,0x.0c11,0x.0bee,0x.0bcb,0x.0ba9,0x.0b87,0x.0b66,0x.0b45,0x.0b24,0x.0b03"

local b100,b200,c100,c200=b_factor[11],b_factor[21],-c_factor[11],-c_factor[21]
local a100,a200=1-b100-c100,1-b200-c200
function adjust_glide(glide,factor)
	local result={}
	for i=1,#glide do
		add(result,glide[i]*factor)
	end
	return result
end
function gaussian_noise()
		local n=0
		--pseudo gausian noise
		for i=1,16 do 
			n+=rnd()
		end
			 n -= 8 -- subtract dc  now centered over -8, 8 
		 if (t>w0\2) n/=2  -- now centered over -4,4
		 return n
	end


function glottis()	
	-- create impulse train for fundamental frequency.
	if t%w0==0 then
		x0=av*10
		t=0
	else
		x0=-av*10/(w0-1)
	end
	--x0*=noise(t)/8	
	t+=1

	ygp=a100*x0 + b100*ylgp1 +c100*ylgp2
	ylgp2,ylgp1=ylgp1,ygp

--     GLOTTAL ZERO PAIR RGZ:
	ygz=0.9899658832*ygp + 0.008973522614*ylgz1 + 0.00108220316*ylgz2
	ylgz2, ylgz1=ylgz1,ygp
--     QUASI-SINUSOIDAL VOICING PRODUCED BY IMPULSE INTO RGP AND RGS:
	ygs=a200*x0 + b200*ylgs1 + c200*ylgs2
	ylgs2,ylgs1=ylgs1,ygs
	ygs=a100*ygs + b100*ylgs3 + c100*ylgs4
	ylgs4,ylgs3=ylgs3,ygs
--     GLOTTAL VOLUME VELOCITY IS THE SUM OF NORMAL AND
--     QUASI-SINUSOIDAL VOICING
	--uglot2=ygz + ygs
	uglot2=ygp + ygs
--     RADIATION CHARACTERISTIC IS A ZERO AT THE ORIGIN
	uglot=uglot2-uglotx
	uglotx=uglot2
	
	noise=gaussian_noise()

	uglot+= ah*noise +noise*voicing_breathiness
	return uglot
	end
	function formant(x0,s) --s[1]=f s[2] =bw
		local f,bw=s[1],s[2]\10+1
		local a,b,c=0,0,0
		if f >0 then -- formant
			local b=b_factor[bw]*cos(f/5512.5)  -- calculate b coefficient
			local c=-c_factor[bw] -- look up c coefficient
			s.y2=s.y1
			s.y1=s.y0
			s.y0=(1-b-c)*x0 + b*s.y1 + c*s.y2
			return s.y0
		elseif f<0 then  -- nasal
			
			local b0=b100*cos(f/5512.5)  -- calculate b coefficient
			local a0 =1-b0-c100
	
			yzc=x0/a0 - b0*ylnz1c/a0 - c100*ylnz2c/a0
			ylnz2c,ylnz1c=ylnz1c,x0

			b0=b100*cos(270/5512.5)  -- calculate b coefficient
			ypc=(1-b0-c100)*yzc+b0*ylnp1c+ c100*ylnp2c

			ylnp2c,ylnp1c=ylnp1c,ypc
        
		
			return ypc
			
		end	
		return x0  -- zero frequency: inactive	
	end

	function unpack_phoneme(p)
		if (not p) return
		local stress,phoneme=tonum(sub(p,#p))
		
		if stress then
			return sub(p,1,#p-1),stress
		else
			return p,0
		end 
	end
	function phonate(speech)
		voicing_duration=0
		local phonemes=split(speech," ")
		local attack,decay=1,1 --1/0 enable/disable attack, 0/1 enable/disable decay
		local c1,c2
		for i=1,#phonemes do
		
			local phoneme,stress=unpack_phoneme(phonemes[i])
			local p=phone[phoneme]
			if type(p)=="number" then
				add(sounds,{p*900+p*rnd(200),0,0,0,0,0,0,0,0,0,{},{},{},1,{}})
				attack,decay=1,1
			else
				
				if (p[1][8]==2)attack=1
				local next_phoneme=unpack_phoneme(phonemes[i+1])
				if (i==#phonemes or type(phone[next_phoneme])=="number") decay=0
				for j=2-attack,#p-decay do
					for f in all(p[j]) do
						local c,f_glide,bw_glide={},{},{}
						local d,blend,cascade=f[1],f[8],f[9]
						--c1 and c2
						if (j==1) then
							c1=f[9]  --attack, do not blend from prior
							av1=f[2]
						end		
						if not cascade then  -- hh blend
							c1=phone[next_phoneme][1][1][9]  --get cascade from first frame of next phoneme
							c2=c1
							
						end
						c2=f[9]
						av2=f[2]
						for k=1,#c1 do
							add(c,{unpack(c1[k])})
						
							c[k].y0=0
							c[k].y1=0
							c[k].y2=0
							add(f_glide,blend*(c2[k][1]-c[k][1])/d)
							add(bw_glide,blend*(c2[k][2]-c[k][2])/d)
						end

						local ah1,ah2,af1,af2=f[4],f[5],f[6],f[7]
						add(sounds,{d,av1,f[3]*(av2-av1)/d,av2,ah1,(ah2-ah1)/d,ah2,af1,(af2-af1)/d,ah2,c,f_glide,bw_glide,stress,c2,f[11]})
						c1=c2
						av1=av2
						voicing_duration+=d
					end
				end	
				attack, decay=0,1 --disable attack and decay
			end
		end	
		--w0=5512.5\voicing_f0
		--voicing_tone = w0*.1/voicing_duration
	end
	function speako8()
		if #sounds >0 then
			while stat(108)<1920 do
				for i=0,127 do
					if duration < 1 then
						old_cascade = cascade
						duration,av,av_step,av_max,ah,ah_step,ah_max,af,af_step,af_max,cascade,f_step,bw_step,stress,c2=unpack(sounds[1])
						
						w0=5512.5\(voicing_f0[stress])
					end
					sample=glottis()
					for i,c in pairs(cascade) do
						sample=formant(sample,c)
						local _c2=c2[i]
						if (c[1]\10 != _c2[1]\10) c[1]+=f_step[i] --increment frequency
						if (c[2]\10!=_c2[2]\10) c[2]+=bw_step[i] --increment bandwidth
					end
						if (av<av_max) av+=av_step
						if (ah<ah_max) ah+=ah_step
						if (ah<ah_max) af+=af_step
					--end	
					poke(buffer+i,sample*volume+128)
					duration -=1
					if duration < 1 then
						deli(sounds,1)
						if #sounds == 0 then
							serial(0x808,buffer,i+1)
							return
						end
					end
					end
				serial(0x808,buffer,128)	
			end
		end	

		
	end
function _init()
	t=0
	phone_index=0
	--phone_list=split"haa,hae,hah,hao,haw,hay,heh,her,hey,hih,hiy,how,hoy,huh,huw"
	phone_list=split"AA1,AE1,AH1,AO1,AW1,AY1,EH1,ER1,EY1,IH1,IY1,OW1,OY1,UH1,UW1"
	words=split"odd,at,hut,ought,cow,hide,ed,hurt,ate,it,eat,oat,toy,hood,two"
end
function _update()
	speako8()
	if (btnp(right)) phone_index=(phone_index+1)%#phone_list
	if (btnp(left)) phone_index-=1	
	if (phone_index<0)	phone_index=#phone_list-1

	if (btnp(fire2)) then
		sounds={}
		
--phonate(phone_list[phone_index+1])
phonate"L OY1 AH0 LL . R UH1 R AH0 LL . L AO1 Y ER0 . L EH1 R IY0 ."
--phonate". . M AO1 R N IH0 NG . N AO1 R M AH0 LL . N AO1 R M AH0 N"
--phonate". . N AO1 R M AH0 N . . N AO1 R M AH0 . . N AO1 R M AH0 N"
--
--phonate"N AO1 R M AH0 LL"
--phonate"AO1 M AY1 ."
--phonate"M . MM"
--phonate". M AO1 R N IY0 NG . N AO1 R M IY0 NG"
--phonate"W IY1 N . M EH1 N"
--phonate". N IH1 M . . M AE1 N . . M IY1 NG"
--phonate". . M M . . N N . . IY1 IY1"
	end	
end
function _draw()
	cls()
	line(0,64,127,64,7)
	for i=1,127 do
		line(i,127-peek(buffer+i-1)/2,i,127-peek(buffer+i)/2,8)
	end
	print((phone_index+1).." "..phone_list[phone_index+1].."   "..words[phone_index+1],0,0,7)
end