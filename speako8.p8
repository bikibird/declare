pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5

--Todd 10, tat 5, cut 0, caught -6,cow -3,tide 5,ted 2,curt -2,tate -4,kit -4,peat 5,coat 1,toy -2,could 3,two -12
do

data=split("aa=1320,1,500,4,3,0,.10,2600,160,1220,70,700,130,-250,100;ae=1270,1,1000,1,2,0,.05,2430,320,1660,150,620,170,-250,100;ah=660,1,1000,4,3,0,0,2550,140,1220,50,620,80,-250,100;ao=1320,1,1000,4,3,0,-.06,2570,80,990,100,600,90,-250,100;aw=720,1,1000,4,3,0,-.03,2550,140,1220,50,620,80,-250,100/720,1,1000,4,0,0,-.03,2960,400,2020,100,310,70,-250,100;ay=690,1,1000,4,3,0,.05,2550,200,1200,70,660,100,-250,100/690,1,1000,4,2,0,.05,2550,200,1880,100,400,70,-250,100;eh=830,1,1000,4,3,0,.02,2520,200,1720,100,480,70,-250,100;er=740,1,1000,4,2,0,-.02,1540,110,1270,60,470,100,-250,100/740,1,1000,4,2,0,-.02,1540,110,1310,60,420,100,-250,100;ey=520,1,500,4,3,0,-.04,2520,200,1720,100,480,70,-250,100/520,1,500,4,0,0,-.04,2600,200,2020,100,330,50,-250,100;ih=720,1,1000,4,3,0,-.04,2570,140,1800,100,400,50,-250,100;iy=880,1,1000,4,3,0,.05,2960,400,2020,100,310,70,-250,100;ow=1210,1,1000,4,3,0,.01,2300,70,1100,70,540,80,-250,100;oy=513,1,1000,3,3,0,-.02,2400,130,960,50,550,60,-250,100/513,1,1000,0,1,0,-.02,2400,130,1820,50,360,80,-250,100/513,1,1000,0,1,0,-.02,2400,130,1820,50,360,80,-250,100;uh=880,1,1000,4,3,0,.03,2350,80,1100,100,450,80,-250,100;uw=390,1,1000,3,3,0,-.12,2200,140,1250,110,350,70,-250,100/390,1,1000,0,1,0,-.12,2200,140,900,110,320,70,-250,100/390,1,1000,0,0,0,-.12,2200,140,900,110,320,70,-250,100;l=440,1,1000,4,3,0,0,2880,280,1050,100,310,50,-250,100;r=440,1,1000,2,3,0,0,1380,120,1060,100,310,70,-250,100,m=390,1,1000,4,3,0,0,2150,200,1100,150,400,300,-450,100;n=360,1,1000,4,3,0,0,2600,170,1600,100,200,60,-450,100;ng=440,1,1000,0,0,0,0,2850,280,1990,150,200,60,-450,100;ch=230,0,200,3,0,1,0,2820,300,1800,90,350,200,-250,100/100,0,100,1,0,1,0,2820,300,1800,90,350,200,-250,100;jh=1,1,1000,0,0,1,0,2820,270,1800,80,260,60,-250,100/330,1,500,1,0,1,0,2820,270,1800,80,260,60,-250,100;dh=275,1,250,0,0,.5,0,2540,170,1290,80,270,60,-250,100;f=1,0,15,0,0,1,0,2080,150,1100,120,340,200,-250,100/660,0,25,1,0,1,0,2080,150,1100,120,340,200,-250,100;s=1,0,20,0,0,1,0,2530,200,1390,80,320,200,-250,100/690,0,40,1,0,1,0,2530,200,1390,80,320,200,-250,100;sh=1,0,40,0,0,1,0,2750,300,1840,100,300,200,-250,100/690,0,40,3,0,1,0,2750,300,1840,100,300,200,-250,100;zh=1,1,250,0,0,.5,0,2750,300,1840,100,300,200,-250,100/385,1,400,1,0,.5,0,2750,300,1840,100,300,200,-250,100;k=50,0,100,0,0,1,0,2850,330,1900,160,300,250,-250,100/250,0,5,1,0,1,0,2850,330,1900,160,300,250,-250,100;p=50,0,50,0,0,1,0,2150,220,1100,150,400,300,-250,100/225,0,2,1,0,1,0,2150,220,1100,150,400,300,-250,100;t=50,0,100,0,0,2,0,2600,250,1600,120,400,300,-250,100/270,0,5,0,0,1,0,2600,250,1600,120,400,300,-250,100;g=90,1,1000,0,0,1,0,2850,280,1990,150,200,60,-250,100;b=440,1,100,0,1,0,0,2150,220,1100,150,400,300,-250,100/70,1,1000,0,0,1,0,2150,220,1100,150,400,300,-250,100;d=70,1,1000,0,0,1,0,2600,170,1600,100,200,60,-250,100;th=606,0,10,0,0,1,0,2540,200,1290,90,320,200,-250,100;v=330,1,1000,0,0,.5,0,2080,120,1100,90,220,60,-250,100;z=410,1,1000,0,1,.5,0,2530,180,1390,60,240,70,-250,100;w=440,1,260,4,4,0,.1,2150,60,610,80,290,50,-250,100;y=440,1,1000,0,3,0,0,3020,500,2070,250,260,40,-250,100;",";")
phone={}
for phoneme in all(data) do
	local p=split(phoneme,"=")
	local key,frames=p[1],split(p[2],"/")
	phone[key]={}
	for f in all(frames) do
		local frame_data=split(f)
		local frame={unpack(frame_data,1,7)}
		frame[8]={}
		for i=8,14,2 do
			add(frame[8],{unpack(frame_data,i,i+1)})
		end
		add(phone[key],frame)
	end
end

	






	poke(0x5f36,@0x5f36^^0x20) --turn off PCM channel dampening

	
	local yzc,ylnz1c,ylnz2c,ypc,ylnp1c,ylnp2c,sample,x0,t,duration,buffer,b100,c100 ,v,v_step,v_max,f_step,bw_step,c2,source=unpack(split"0,0,0,0,0,0,0,0,0,0,0x8000,0x1.233b,-0x.52d4")
	
	local sounds,cascade={},{}
	

	-- b coefficient first factor = =2*exp(-pi()*bandwidth/5512.5)  
	b_factor=split"2,0x1.fd17,0x1.fa32,0x1.f752,0x1.f475,0x1.f19d,0x1.eec9,0x1.ebfa,0x1.e92e,0x1.e666,0x1.e3a3,0x1.e0e3,0x1.de27,0x1.db70,0x1.d8bc,0x1.d60c,0x1.d360,0x1.d0b9,0x1.ce14,0x1.cb74,0x1.c8d8,0x1.c63f,0x1.c3aa,0x1.c119,0x1.be8c,0x1.bc02,0x1.b97c,0x1.b6fa,0x1.b47b,0x1.b200,0x1.af89,0x1.ad15,0x1.aaa5,0x1.a838,0x1.a5cf,0x1.a369,0x1.a107,0x1.9ea9,0x1.9c4d,0x1.99f6,0x1.97a1,0x1.9550,0x1.9302,0x1.90b8,0x1.8e71,0x1.8c2e,0x1.89ed,0x1.87b0,0x1.8576,0x1.8340,0x1.810c,0x1.7edc,0x1.7caf,0x1.7a85,0x1.785f,0x1.763b,0x1.741b,0x1.71fd,0x1.6fe3,0x1.6dcc,0x1.6bb8,0x1.69a7,0x1.6798,0x1.658d,0x1.6385,0x1.6180,0x1.5f7e,0x1.5d7e,0x1.5b82,0x1.5988,0x1.5792,0x1.559e,0x1.53ad,0x1.51bf,0x1.4fd3,0x1.4deb,0x1.4c05,0x1.4a22,0x1.4842,0x1.4664,0x1.4489,0x1.42b1,0x1.40dc,0x1.3f09,0x1.3d39,0x1.3b6b,0x1.39a0,0x1.37d8,0x1.3612,0x1.344f,0x1.328f,0x1.30d1,0x1.2f15,0x1.2d5c,0x1.2ba6,0x1.29f2,0x1.2841,0x1.2692,0x1.24e5,0x1.233b,0x1.2193,0x1.1fee,0x1.1e4b,0x1.1cab,0x1.1b0c,0x1.1971,0x1.17d7,0x1.1640,0x1.14ab,0x1.1319,0x1.1189,0x1.0ffb,0x1.0e6f,0x1.0ce5,0x1.0b5e,0x1.09d9,0x1.0857,0x1.06d6,0x1.0558,0x1.03db,0x1.0261,0x1.00e9,0x.ff74,0x.fe00,0x.fc8f,0x.fb1f,0x.f9b2,0x.f847,0x.f6dd,0x.f576,0x.f411,0x.f2ae,0x.f14d,0x.efee,0x.ee91,0x.ed36,0x.ebdd,0x.ea86,0x.e930,0x.e7dd,0x.e68c,0x.e53c,0x.e3ef,0x.e2a3,0x.e15a,0x.e012,0x.decc,0x.dd88,0x.dc45,0x.db05,0x.d9c6,0x.d889,0x.d74e,0x.d615,0x.d4de,0x.d3a8,0x.d274,0x.d142,0x.d012,0x.cee3,0x.cdb6,0x.cc8b,0x.cb61,0x.ca39,0x.c913,0x.c7ee,0x.c6cc,0x.c5aa,0x.c48b,0x.c36d,0x.c251,0x.c136,0x.c01d,0x.bf05,0x.bdef,0x.bcdb,0x.bbc8,0x.bab7,0x.b9a7,0x.b899,0x.b78d,0x.b682,0x.b578,0x.b470,0x.b36a,0x.b265,0x.b161,0x.b05f,0x.af5f,0x.ae5f,0x.ad62,0x.ac66,0x.ab6b,0x.aa71,0x.a979,0x.a883,0x.a78e,0x.a69a,0x.a5a8,0x.a4b7,0x.a3c7,0x.a2d9,0x.a1ec,0x.a100,0x.a016,0x.9f2d,0x.9e45,0x.9d5f,0x.9c7a,0x.9b97,0x.9ab4,0x.99d3,0x.98f3,0x.9815,0x.9738,0x.965c,0x.9581,0x.94a7,0x.93cf,0x.92f8,0x.9222,0x.914e,0x.907a,0x.8fa8,0x.8ed7,0x.8e07,0x.8d39,0x.8c6b,0x.8b9f,0x.8ad4,0x.8a0a,0x.8941,0x.8879,0x.87b3,0x.86ed,0x.8629,0x.8566,0x.84a4,0x.83e3,0x.8323,0x.8264,0x.81a7,0x.80ea,0x.802e,0x.7f74,0x.7eba,0x.7e02,0x.7d4b,0x.7c94,0x.7bdf,0x.7b2b,0x.7a78,0x.79c6,0x.7915,0x.7864,0x.77b5,0x.7707,0x.765a,0x.75ae,0x.7503,0x.7458,0x.73af,0x.7307,0x.725f,0x.71b9,0x.7114,0x.706f,0x.6fcb,0x.6f29,0x.6e87,0x.6de6,0x.6d46,0x.6ca7,0x.6c09,0x.6b6c,0x.6ad0,0x.6a35"


	-- c coefficient = exp(-2*pi()*bandwidth/5512.5)  final value needs to be negative
	c_factor=split"1,0x.fd19,0x.fa3a,0x.f764,0x.f497,0x.f1d1,0x.ef13,0x.ec5e,0x.e9b0,0x.e70a,0x.e46c,0x.e1d5,0x.df46,0x.dcbe,0x.da3d,0x.d7c4,0x.d552,0x.d2e7,0x.d083,0x.ce26,0x.cbd0,0x.c981,0x.c738,0x.c4f6,0x.c2bb,0x.c086,0x.be57,0x.bc2f,0x.ba0d,0x.b7f1,0x.b5dc,0x.b3cc,0x.b1c2,0x.afbf,0x.adc1,0x.abc9,0x.a9d6,0x.a7e9,0x.a602,0x.a421,0x.a244,0x.a06e,0x.9e9c,0x.9cd0,0x.9b09,0x.9947,0x.978a,0x.95d3,0x.9420,0x.9272,0x.90c9,0x.8f25,0x.8d86,0x.8beb,0x.8a55,0x.88c4,0x.8737,0x.85af,0x.842b,0x.82ac,0x.8130,0x.7fba,0x.7e47,0x.7cd9,0x.7b6e,0x.7a08,0x.78a6,0x.7748,0x.75ee,0x.7498,0x.7346,0x.71f7,0x.70ad,0x.6f66,0x.6e22,0x.6ce3,0x.6ba7,0x.6a6f,0x.693a,0x.6809,0x.66db,0x.65b0,0x.6489,0x.6366,0x.6245,0x.6128,0x.600e,0x.5ef7,0x.5de4,0x.5cd3,0x.5bc6,0x.5abc,0x.59b5,0x.58b0,0x.57af,0x.56b1,0x.55b5,0x.54bc,0x.53c7,0x.52d4,0x.51e3,0x.50f6,0x.500b,0x.4f22,0x.4e3d,0x.4d5a,0x.4c79,0x.4b9c,0x.4ac0,0x.49e7,0x.4911,0x.483d,0x.476b,0x.469c,0x.45cf,0x.4505,0x.443c,0x.4376,0x.42b3,0x.41f1,0x.4132,0x.4075,0x.3fba,0x.3f01,0x.3e4a,0x.3d95,0x.3ce3,0x.3c32,0x.3b83,0x.3ad7,0x.3a2c,0x.3983,0x.38dc,0x.3837,0x.3794,0x.36f3,0x.3653,0x.35b6,0x.351a,0x.3480,0x.33e8,0x.3351,0x.32bc,0x.3229,0x.3197,0x.3107,0x.3079,0x.2fed,0x.2f62,0x.2ed8,0x.2e50,0x.2dca,0x.2d45,0x.2cc2,0x.2c40,0x.2bbf,0x.2b40,0x.2ac3,0x.2a47,0x.29cc,0x.2953,0x.28db,0x.2864,0x.27ef,0x.277b,0x.2709,0x.2698,0x.2628,0x.25b9,0x.254b,0x.24df,0x.2474,0x.240a,0x.23a2,0x.233b,0x.22d4,0x.226f,0x.220b,0x.21a9,0x.2147,0x.20e6,0x.2087,0x.2029,0x.1fcb,0x.1f6f,0x.1f14,0x.1eba,0x.1e60,0x.1e08,0x.1db1,0x.1d5b,0x.1d06,0x.1cb2,0x.1c5e,0x.1c0c,0x.1bbb,0x.1b6a,0x.1b1b,0x.1acc,0x.1a7e,0x.1a31,0x.19e5,0x.199a,0x.1950,0x.1907,0x.18be,0x.1876,0x.182f,0x.17e9,0x.17a4,0x.175f,0x.171b,0x.16d8,0x.1696,0x.df50,0x.1614,0x.15d3,0x.1594,0x.1556,0x.1518,0x.14da,0x.149e,0x.cbd9,0x.1427,0x.13ec,0x.13b3,0x.137a,0x.1341,0x.1309,0x.12d2,0x.ba15,0x.1265,0x.1230,0x.11fb,0x.11c7,0x.1193,0x.1160,0x.112e,0x.a9de,0x.10cb,0x.109a,0x.106a,0x.103a,0x.100b,0x.0fdd,0x.0faf,0x.9b10,0x.0f54,0x.0f28,0x.0efc,0x.0ed0,0x.0ea5,0x.0e7b,0x.0e51,0x.8d8c,0x.0dfe,0x.0dd6,0x.0dad,0x.0d86,0x.0d5e,0x.0d38,0x.0d11,0x.8136,0x.0cc6,0x.0ca1,0x.0c7c,0x.0c58,0x.0c34,0x.0c11,0x.0bee,0x.0bcb,0x.0ba9,0x.0b87,0x.0b66,0x.0b45,0x.0b24,0x.0b03"

	
	function say(speech)
		local phonemes=split(speech,"/")
		local onset,c,f_glide,bw_glide,d,source,volume,velocity,shift,frication,pitch,cascade,d2,rate
		local c1,c2={},{}
		local v_stress, d_stress, p_stress,v1,v2,h_phone=unpack(split("1,1,0,0,0")) 
		for i,phoneme in pairs(phonemes) do
			local stress=tonum(phoneme)
			if stress then
				local abs_stress=abs(stress)
				local sign,stress_type,magnitude=sgn(stress),abs_stress\1,abs_stress & 0x.ffff
				-- -.25 == 25% slower == 1-.25== .75 +.25 ==25% faster 1.25 
				if (stress_type==1) d_stress=1+sign*magnitude
				if (stress_type==2) v_stress=1+sign*magnitude
				if (stress_type==3) p_stress=spk8_intonation*sign*magnitude
			elseif phoneme=="HH" then
				h_phone=true
		--	elseif phoneme=="-" then
		--		onset=true
			elseif phoneme=="_"then
				add(sounds,{1100*d_stress*spk8_speed})
			else
				for frame in all(phone[phoneme]) do
					d,source,volume,velocity,shift,frication,pitch,cascade=unpack(frame)
					if (volume==0)glottal_stop=true
					c,f_glide,bw_glide,d2,c1,v1,c2,v2={},{},{},d*d_stress,c2,v2,cascade,volume
					p_stress+=pitch*spk8_intonation
					--if onset then
					--	c1,v1=c2,0
					--	add(sounds,{1100})
					--	onset=false
					--end
					if (velocity == 0) v1=volume
					if (shift == 0) c1=cascade
					if (#c1 != #c2) c1=cascade
					for m=1,#c1 do
						add(c,{unpack(c1[m])})
						local cm,c2m=c[m],c2[m]
						cm.y0,cm.y1,cm.y2=0,0,0
						add(f_glide,shift*(c2m[1]-cm[1])/d)
						add(bw_glide,shift*(c2m[2]-cm[2])/d)
					end
					if  h_phone then  -- get hh cascade
						add(sounds,{200,2,0,1,0,1,pitch,c,f_glide,bw_glide,c2,v_stress,p_stress})
						h_phone=false --,onset=true
					end
					add(sounds,{d2,source,frication,v1,velocity*(v2-v1)/d,v2,pitch,c,f_glide,bw_glide,c2,v_stress,p_stress})
				end
					v_stress, d_stress, p_stress=1,1,0 
			end	
		end	
	end

function speako8()
	function set_voice()
		w0=5512.5\((1+p_stress+spk8_vibrato*sin(time()*5.5))*spk8_f0)
	end
	if #sounds >0 then
		while stat(108)<1920 do
			for i=0,127 do
				current_sound=sounds[1]
				if current_sound then
					if duration < 1 then
						duration,source,frication,v,v_step,v_max,pitch,cascade,f_step,bw_step,c2,v_stress,p_stress=unpack(current_sound)
					end
					if source then  --if not silence
						set_voice()
						open,sample,_source = spk8_quality*w0,v/10,source*spk8_whisper  -- 0-->0 1-->2 2-->4
						if _source ==1 then --voiced
							if t % w0 ==0 then  
								x0,b,t =-v/8/(w0-1),-v/8/open/open,0
								a = -b * open / 3
								set_voice()
							end
							if (t > open) then
								x0 = -v/8/(w0-1)
							else
								a+=b
								x0-=a 
							end
							sample=x0
						elseif _source > 1 then --aspirated (gaussian noise)
							sample=-8
							for i=1,16 do 
								sample+=rnd()
							end  --sample centered over -8,8
							if (t>w0\2) sample/=2 -- now centered over -4,4
						end
						for k,resonator in pairs(cascade) do
							local f,bw,a0,b0,c0=resonator[1],resonator[2]\10+1
							b1=cos(f/spk8_tract/5512.5)
							if f >0 then -- formant
								b0,c0=b_factor[bw]*b1,-c_factor[bw]
								resonator.y2,resonator.y1,resonator.y0=resonator.y1,resonator.y0
								resonator.y0=(1-b0-c0)*sample + b0*resonator.y1 + c0*resonator.y2
								sample=resonator.y0
							elseif f<0 then  -- nasal
								b0=b100*b1  -- calculate b coefficient
								local a0 =1-b0-c100
						
								yzc=sample/a0 - b0*ylnz1c/a0 - c100*ylnz2c/a0
								ylnz2c,ylnz1c,b0=ylnz1c,sample,b100*cos(0x.0c89)  -- calculate b coefficient cos(270/5512.5)
								ypc=(1-b0-c100)*yzc+b0*ylnp1c+ c100*ylnp2c

								ylnp2c,ylnp1c=ylnp1c,ypc
								sample=ypc
							end
					
							local c2k=c2[k]
							if (f\10 !=c2k[1]\10) resonator[1]+=f_step[k] --increment frequency
							if (bw-1 != c2k[2]\10) resonator[2]+=bw_step[k] --increment bandwidth
						end
						sample*=frication/2-1+rnd(frication)  -- fricatives
						if (abs(v-v_max) > abs(v_step)) v+=v_step
					else
						sample,v_stress=0,1
					end	
					t+=1
					duration -=1
					poke(buffer+i,sample*spk8_volume*v_stress+128)
					if duration < 1 then
						deli(sounds,1)
						if #sounds == 0 then
							serial(0x808,buffer,i+1)
							return
						end
					end
				end	
			end
			serial(0x808,buffer,128)	
		end
	end	
end	
end
function _init()
	vowel_list=split"aa,ae,ah,ao,aw,ay,eh,er,ey,ih,iy,ow,oy,uh,uw"
	phone_index=0
	phone_list=split"AA,AE,AH,AO,AW,AY,EH,ER,EY,IH,IY,OW,OY,UH,UW"
	words=split"odd,at,hut,ought,cow,hide,ed,hurt,ate,it,eat,oat,toy,hood,two"
	spk8_vibrato=.04  --0 monotone through 3 sing-songy recommended: .75  -- vibrato how much pitch variation. Recommend between .02 and .04
	spk8_intonation=1--the impact of stress 3 pitch <1 less >1 more
	spk8_speed=1 --duration multiplier for voiced sounds. <below 1 faster, above 1 slower
	spk8_tract=1  --vocal tract higher for men 1 is average, lower for women .85 average for woment, children
	spk8_f0=140 --voicing pitch 140 man, 200 woman
	spk8_volume=1
	spk8_whisper=1 --1 normal, 2 whisper
	spk8_quality=.5 --.1 creaky, 1 breathy,2 weak
end
function _update()
	speako8()
	if (btnp(right)) spk8_quality+=.05
	if (btnp(left)) spk8_quality-=.05	
	if (phone_index<0)	phone_index=#phone_list-1

	if (btnp(fire2)) then
		
		sounds={}
--	print(phone_list[phone_index+1])	
--say(phone_list[phone_index+1])
--say"L OY1 AH0 L . R UH1 ER0 AH0 L . L AO1 Y ER0 . L EH1 ER0 IY0 . ."
--say"M AO ER N IH NG _ N AO ER M AH L _ N AO ER M IH N ."

--say"R AH1 B ER0 . B EY1 B IY0 . B AH1 G IY0 . B AH1 M P ER0 Z ."
--say"SH IY _ S EH L Z _ S IY _ SH EH L Z _ AA N _ DH AH _ S IY _ SH AO ER ."
--say"DH AH0 _ B EY1 ZH _ HH Y UW1 _ AA1 N _ DH AH0 _ W AO1 T ER0 Z _ AH1 V _ DH AH0 _ L AA1 K _ IH2 M P R EH1 S T _ AO1 L , IH2 N K L UW1 D IH0 NG _ DH AH0 _ F R EH1 N CH _ K W IY1 N , B IY0 F AO1 R _ SH IY1 _ HH ER1 D _ DH AE1 T _ S IH1 M F AH0 N IY0 _ AH0 G EH1 N , JH AH1 S T _ AE1 Z _ Y AH1 NG _ AA1 R TH ER0 _ W AO1 N T IH0 D ." 

--say"SH AH0 K AA1 G OW2 . CH ER1 CH . B R AH1 N CH ."
--say"CH ER CH . B R AH N CH ."
--say"JH AH M P IH NG . JH AH JH . JH EY M IY ."
--say"F AY1 N . F AY1 F . B AH1 F AH0 T ."
--say"S IH1 M P AH0 L . S AY1 M AH0 N . B AE1 S ."
--say"SH EH1 L IY0 . P UH1 SH AH0 Z . K AE1 SH ."
--say"K AY1 AE0 K . K IH1 K ER0 . N UH1 K L ."
--say"K AE1 M P . P IH1 NG K . P AA1 P IY0 . P R IH1 N S ."
--say"T EY1 K . T OW1 T AH0 M . K EY1 T ."
--say"B AA1 B . B EY1 B IY0 . R AA1 B AH0 N ."
--say"G OW1 . G IH1 G AH0 L . G EY1 G ."
--say"D AE1 P ER0 . D UW1 D . P AE1 D IH0 NG ."
--say"TH IH1 N . TH IH1 NG . B EH1 TH AH0 N IY0 . B EH1 TH"
--say"Z IY1 B R AH0 . P IY1 T S AH0 . JH AE1 Z Z ."
--say"R IH1 V ER0 . V AE1 L IY0 . R EY1 V ."
--say"N AE1 N IY0 . N AH1 N . N IH1 K AH0 L . N UW1 N ."
--say"M AY1 T IY0 _ P AE1 M _ L EH1 M AH0 N ."

--say"DH/AH/_/B/EY/ZH/_/HH/Y/3.03/UW/_/2.2/AA/N/_/DH/AH/_/W/2.2/AO/T/ER/Z/_/2.2/AH/V/_/DH/AH/_/L/2.2/3.03/AA/K/_/IH/M/P/R/1.2/EH/S/D/_/2.2/AO/L/,/IH/N/K/L/1.2/UW/D/IY/NG/_/DH/AH/_/F/R/2.2/EH/N/CH/_/K/W/2.2/1.2/3.03/IY/N/,/B/IH/F/2.2/AO/R/_/SH/2.2/IY/_/HH/ER/D/_/DH/2.2/AE/T/_/S/1.2/3.03/IH/M/F/AH/N/IY/_/AH/G/EH/N/,/JH/1.2/AH/S/T/_/2.2/AE/Z/_/Y/1.2AH/NG/_/2.2/3.03/AA/R/TH/ER/_/W/2.2/AO/N/T/-2.2/-3.03/IH/D/." 

--say"DH AH0 _ B EY ZH _ HH Y UW _ AA N _ DH AH0 _ W AO T ER0 Z _ AH V _ DH AH0 _ L AA K _ IH M P R EH S T _ AO L , IH N K L UW D IH0 N G _ DH AH0 _ F R EH N CH _ K W IY N , B IY0 F AO R _ SH IY _ HH ER D _ DH AE T _ S IH M F AH0 N IY0 _ AH G EH N , JH AH S T _ AE Z _ Y AH N G _ AA R TH ER0 _ W AO N T IH D ."

--say"B AE NG K ER0 . G OW IH NG . G OW IH NG ."
--say"G UH D . M AO R N IH NG . D AO N ."
--say"S/AH/M/2.2/AE/NG/G/R/IY/B/2.2/3.02/AE/NG/K/ER/Z/_/G/OW/IH/NG/B/2.2/AA/NG/K/ER/Z/S/OW/2.2/V/ER/B/IH/T/K/-2.2/-3.02/OY/N"
--1 duration, 2 volume, 3 pitch
--say"K/2.2/3.04/EY/T/_/T/UH/K/_/DH/-2.2/AH/_/P/2.2/AA/P/S/IH/K/-2.1/AH/L/."
--say"D/2.2/3.04/EY/V/IH/D/_/B/AA/T/_/G/R/-2.2/-3.02/EY/P/S/."
--say"D/EY/V/1/IH/D/./D/EY/V/IH/D/."
--say"0/AE/M/B/AE/S/0/AH/D/0/ER/SH/1/IH/P"
--say"0/AE/M/B/AE/S/0/AH/D/0/ER/SH/1/IH/P"
--say"AH"
--say"0/AH/G/EH/N/././1/AH/G/EH/N/././3/AH/G/EH/N/././4/AH/G/EH/N/."
--say"-3.05/AH/_/AH/_/3.05/AH/_/3.10/AH"
--say"K/3.05/EY/T/_/T/UH/K/_/DH/AH/_/P/AA/P/S/IH/K/AH/L/."
--say"HH/UH"
--say"s/ah/m/2.2/ae/ng/r/iy/b/2.2/3.02/ae/ng/k/er--/z"--/_/G/OW/IH/NG/B/2.2/AA/NG/K/ER/Z/S/OW/2.2/V/ER/B/IH/T/K/-2.2/-3.02/OY/N"
--say"s/ah/m/-/ae/ng/r/iy/-/b/ae/ng/k/er"
--say"r/iy"
--say"hh/ah/l/ow/w/er/l/d/"
--say"n/-1.6538/ao/-1.6538/er/m/-1.048/ih/1.4/n/_"

--ih*=1.4*.8*.85 = .952=-1.048
--ao er *=.6*.85*.8*.7 =-1.6538
say'-/r/-1.58/ah/-1.60/_/b/-1.62/er/-1.60/_/b/-1.59/ey/-1.60/_/b/-1.52/iy/-1.60/_/b/-1.58/ah/-1.67/_/g/-1.52/iy/-1.60/_/b/-1.58/ah/m/-1.57/_/p/1.12/er/1.40/z'
	end	
end
function _draw()
cls()

	line(0,64,127,64,7)
	for i=1,127 do
		line(i,127-peek(0x8000+i-1)/2,i,127-peek(0x8000+i)/2,8)
	end
--	print((phone_index+1).." "..phone_list[phone_index+1].."   "..words[phone_index+1],0,0,7)
end