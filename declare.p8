pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
buffer=0x8000

-- see https://www.fon.hum.uva.nl/david/ma_ssp/doc/Klatt-1980-JAS000971.pdf for background

impulse=1000 --for glottal click train
w0=5512.5\175 --voice fundemental wavelength
--for vocal fold filter
rgp={y0=0,y1=0,y2=0}	--{y0=0,y1=128\w0,y2=256\w0} 
rgz={y0=0,y1=0,y2=0}
rgs={y0=0,y1=0,y2=0}
uglotx=0
volume=1
aspiration=1
duration,av,ah,af,av_step,ah_step,_af_step=0,0,0,0,0,0,0

sounds={}

--cascade formants
vowel_formants=
{
	--f_start,step, bw_start,step
	aa={{1300,240},{830,220}},
	ae={{2060,200},{670,50}},
	ay={{1450,330,2040,300},{870,310,590,140}},
--[[	ah={{},{}},
	ao={{},{}},
	aw={{},{}},
	ay={{},{}},
	eh={{},{}},
	er={{},{}},
	ey={{},{}},
	ih={{},{}},
	iy={{},{}},
	ow={{},{}},
	oy={{},{}},
	uh={{},{}},
	uw={{},{}},
]]	
}
offglide=
{
	--f_step, bw_step
	aa={{0,0},{0.0}},
	ae={{-0.2176870748,0.09070294785},{0.126984127,0.08163265306}},
	ay={{0.7644962747,-0.03887269193},{-0.3628117914,-0.2202785876}},


--[[	
	ah={{},{}},
	ao={{},{}},
	aw={{},{}},
	ay={{},{}},
	eh={{},{}},
	er={{},{}},
	ey={{},{}},
	ih={{},{}},
	iy={{},{}},
	ow={{},{}},
	oy={{},{}},
	uh={{},{}},
	uw={{},{}},
]]	
}
phonemes={}
for p,f in pairs(vowel_formants) do
	phonemes[p]={}
	add(phonemes[p],
	{
		cascade={unpack(f)},
		frames=
		{
			{300,0,0,0,2,0,0,{0,0},{0,0}},
			{600,2000,2000,0,0,0,0,unpack(offglide[p])},
			{200,2000,1000,0,0,0,0,unpack(offglide[p])},
			{320,1000,0,0,0,0,0,{0,0},{0,0}},
		}
	})
end

-- b coefficient first factor = =2*exp(-pi()*bandwidth/5512.5)  
b_factor=split"2,1.988634349,1.977333287,1.966096446,1.954923463,1.943813974,1.932767618,1.921784037,1.910862873,1.900003773,1.889206383,1.878470352,1.867795333,1.857180978,1.846626942,1.836132883,1.82569846,1.815323335,1.805007169,1.794749628,1.784550379,1.77440909,1.764325433,1.754299079,1.744329703,1.734416982,1.724560592,1.714760215,1.705015532,1.695326226,1.685691983,1.676112489,1.666587434,1.657116509,1.647699404,1.638335816,1.629025439,1.619767972,1.610563113,1.601410564,1.592310027,1.583261207,1.574263809,1.565317543,1.556422116,1.54757724,1.538782629,1.530037996,1.521343057,1.512697529,1.504101133,1.495553589,1.487054618,1.478603946,1.470201298,1.4618464,1.453538982,1.445278774,1.437065506,1.428898914,1.42077873,1.412704693,1.404676538,1.396694007,1.388756838,1.380864775,1.373017561,1.365214942,1.357456664,1.349742474,1.342072123,1.334445361,1.326861941,1.319321616,1.311824141,1.304369274,1.29695677,1.289586391,1.282257897,1.274971049,1.267725611,1.260521347,1.253358024,1.246235409,1.239153271,1.232111379,1.225109504,1.218147421,1.211224901,1.204341722,1.197497658,1.190692487,1.18392599,1.177197945,1.170508134,1.16385634,1.157242348,1.150665941,1.144126907,1.137625034,1.131160109,1.124731924,1.118340268,1.111984935,1.105665719,1.099382414,1.093134815,1.08692272,1.080745928,1.074604238,1.068497449,1.062425364,1.056387786,1.050384519,1.044415367,1.038480136,1.032578635,1.026710671,1.020876053,1.015074592,1.0093061,1.00357039,0.9978672744,0.9921965687,0.9865580886,0.9809516511,0.9753770739,0.9698341761,0.9643227776,0.9588426995,0.9533937636,0.9479757931,0.942588612,0.9372320453,0.9319059191,0.9266100603,0.9213442969,0.9161084579,0.9109023733,0.905725874,0.9005787918,0.8954609596,0.8903722111,0.8853123811,0.8802813053,0.8752788201,0.8703047632,0.865358973,0.8604412889,0.8555515511,0.8506896009,0.8458552802,0.8410484322,0.8362689006,0.8315165303,0.8267911669,0.8220926569,0.8174208477,0.8127755875,0.8081567256,0.8035641119,0.7989975972,0.7944570332,0.7899422724,0.7854531683,0.7809895749,0.7765513473,0.7721383415,0.7677504139,0.7633874222,0.7590492246,0.7547356803,0.750446649,0.7461819916,0.7419415695,0.7377252449,0.733532881,0.7293643416,0.7252194912,0.7210981953,0.71700032,0.7129257323,0.7088742996,0.7048458906,0.7008403744,0.6968576207,0.6928975004,0.6889598848,0.6850446459,0.6811516566,0.6772807906,0.6734319219,0.6696049258,0.6657996778,0.6620160543,0.6582539325,0.6545131902,0.6507937059,0.6470953588,0.6434180287,0.6397615963,0.6361259427,0.6325109499,0.6289165005,0.6253424777,0.6217887654,0.6182552483,0.6147418116,0.6112483411,0.6077747233,0.6043208456,0.6008865956,0.5974718619,0.5940765335,0.5907005001,0.5873436522,0.5840058807,0.5806870771,0.5773871337,0.5741059433,0.5708433994,0.5675993959,0.5643738275,0.5611665895,0.5579775776,0.5548066883,0.5516538187,0.5485188663,0.5454017292,0.5423023063,0.5392204969,0.5361562008,0.5331093186,0.5300797513,0.5270674006,0.5240721684,0.5210939577,0.5181326716,0.515188214,0.5122604892,0.5093494022,0.5064548584,0.5035767638,0.5007150248,0.4978695487,0.4950402428,0.4922270155,0.4894297752,0.4866484311,0.483882893,0.4811330709,0.4783988755,0.4756802182,0.4729770104,0.4702891646,0.4676165933,0.4649592097,0.4623169276,0.4596896612,0.457077325,0.4544798343,0.4518971046,0.4493290522,0.4467755935,0.4442366458,0.4417121264,0.4392019534,0.4367060453,0.434224321,0.4317566999,0.4293031019,0.4268634472,0.4244376567,0.4220256515,0.4196273533,0.4172426843,0.4148715669"

-- c coefficient = -exp(-2*pi()*bandwidth/5512.5)
c_factor=split"-1,-0.9886666433,-0.9774617316,-0.9663838091,-0.9554314367,-0.9446031914,-0.9338976665,-0.9233134711,-0.9128492302,-0.9025035843,-0.8922751893,-0.8821627163,-0.8721648515,-0.8622802962,-0.852507766,-0.8428459914,-0.8332937171,-0.8238497022,-0.8145127197,-0.8052815565,-0.7961550134,-0.7871319046,-0.778211058,-0.7693913145,-0.7606715283,-0.7520505665,-0.7435273092,-0.735100649,-0.7267694911,-0.7185327532,-0.7103893652,-0.7023382692,-0.694378419,-0.6865087807,-0.6787283318,-0.6710360616,-0.6634309705,-0.6559120707,-0.6484783852,-0.6411289484,-0.6338628053,-0.626679012,-0.6195766353,-0.6125547522,-0.6056124507,-0.5987488288,-0.5919629948,-0.585254067,-0.5786211739,-0.5720634537,-0.5655800546,-0.5591701341,-0.5528328595,-0.5465674075,-0.5403729641,-0.5342487246,-0.5281938932,-0.5222076834,-0.5162893174,-0.5104380265,-0.5046530502,-0.4989336372,-0.4932790443,-0.487688537,-0.4821613888,-0.4766968818,-0.471294306,-0.4659529595,-0.4606721484,-0.4554511867,-0.4502893959,-0.4451861056,-0.4401406526,-0.4351523816,-0.4302206445,-0.4253448004,-0.4205242161,-0.4157582652,-0.4110463284,-0.4063877938,-0.401782056,-0.3972285166,-0.3927265841,-0.3882756737,-0.383875207,-0.3795246123,-0.3752233245,-0.3709707847,-0.3667664405,-0.3626097456,-0.35850016,-0.3544371498,-0.3504201872,-0.3464487502,-0.3425223229,-0.3386403953,-0.3348024629,-0.3310080271,-0.3272565951,-0.3235476794,-0.3198807981,-0.3162554749,-0.3126712388,-0.3091276242,-0.3056241705,-0.3021604228,-0.2987359309,-0.2953502501,-0.2920029403,-0.2886935669,-0.2854216997,-0.2821869138,-0.2789887888,-0.2758269093,-0.2727008646,-0.2696102484,-0.2665546593,-0.2635337003,-0.2605469789,-0.257594107,-0.2546747011,-0.2517883819,-0.2489347743,-0.2461135077,-0.2433242156,-0.2405665354,-0.2378401091,-0.2351445823,-0.2324796049,-0.2298448306,-0.2272399171,-0.2246645261,-0.2221183229,-0.2196009767,-0.2171121605,-0.2146515509,-0.2122188283,-0.2098136767,-0.2074357834,-0.2050848397,-0.2027605401,-0.2004625825,-0.1981906686,-0.195944503,-0.1937237941,-0.1915282532,-0.1893575952,-0.1872115381,-0.1850898029,-0.1829921142,-0.1809181993,-0.1788677888,-0.1768406163,-0.1748364185,-0.172854935,-0.1708959084,-0.1689590841,-0.1670442106,-0.1651510389,-0.1632793233,-0.1614288205,-0.1595992901,-0.1577904944,-0.1560021984,-0.1542341699,-0.152486179,-0.1507579988,-0.1490494046,-0.1473601745,-0.1456900891,-0.1440389313,-0.1424064868,-0.1407925433,-0.1391968911,-0.1376193231,-0.1360596342,-0.1345176219,-0.1329930857,-0.1314858276,-0.1299956518,-0.1285223647,-0.1270657749,-0.1256256932,-0.1242019324,-0.1227943076,-0.1214026359,-0.1200267365,-0.1186664307,-0.1173215417,-0.1159918948,-0.1146773173,-0.1133776384,-0.1120926892,-0.1108223027,-0.109566314,-0.1083245599,-0.107096879,-0.1058831119,-0.1046831008,-0.1034966899,-0.102323725,-0.1011640537,-0.1000175254,-0.09888399114,-0.09776330359,-0.0966553172,-0.09555988802,-0.09447687372,-0.09340613361,-0.09234752858,-0.0913009211,-0.09026617519,-0.08924315643,-0.08823173191,-0.8723177022,-0.08624314145,-0.08526571716,-0.08429937038,-0.08334397554,-0.08239940854,-0.08146554665,-0.08054226855,-0.7962945429,-0.07872698529,-0.07783474428,-0.07695261536,-0.07608048392,-0.07521823666,-0.07436576155,-0.07352294785,-0.7268968606,-0.07186586792,-0.0710513864,-0.0702461357,-0.06945001118,-0.06866290943,-0.06788472819,-0.06711536635,-0.6635472396,-0.06560270221,-0.06485920338,-0.0641241309,-0.06339738925,-0.06267888402,-0.06196852187,-0.06126621051,-0.6057185869,-0.05988537621,-0.05920667388,-0.05853566353,-0.05787225797,-0.05721637103,-0.05656791749,-0.0559268131,-0.5529297458,-0.05466631958,-0.05404676668,-0.05343423539,-0.05282864614,-0.05222992025,-0.05163797994,-0.05105274829,-0.5047414928,-0.04990210775,-0.04933654936,-0.04877740065,-0.04822458897,-0.0476780425,-0.04713769024,-0.04660346198,-0.04607528832,-0.04555310064,-0.04503683111,-0.04452641263,-0.04402177892,-0.04352286439,-0.04302960425"
	function gaussian_noise()
		local n=0
		--   pseudo gausian noise
		 for i=1,16 do 
			 n+=rnd()
		 end
		 n -= 8 -- subtract dc  now centered over -8, 8 
		 if (t>w0\2) n/=2  -- now centered over -4,4
		
		 -- low pass noise at -6db/ocatve to simulate source impedance
		-- high pass noiseHIGH-PASS nois at  +6 db/octave for radiation effect
		-- two effects cancel one another 

		 return n
	end
	function glottis()	
		-- create impulse train for fundamental frequency.
		if t%w0==0 then
			x0=av
			t=0
		else
			x0=-av/(w0-1)
		end
		--x0*=noise(t)/8	
		t+=1
		
		-- rgp filter
		-- "As a special case, the frequency F of a digital resonator can be set to zero, producing, in effect, a lowpass
		-- filter which has a nominal attentuation skirt of -12 dB per octave of frequency increase and a 3 dB
		-- down break frequency equal to BW/2. The voicing source contains a digital resonator RGP used as a lowpass 
		-- filter that transforms a glottal impulse into a pulse having a waveform and spectrum similar to normal voicing."

		local b,c=b_factor[11],c_factor[11]  --b and c coefficients for frequency zero, bandwidth 100
		rgp.y0=(1-b-c)*x0+b*rgp.y1+ c*rgp.y2
		rgp.y2,rgp.y1=rgp.y1,rgp.y0
		-- rgz filter
		-- "The antiresonator RGZ is used to modify the detailed shape of the spectrum of the voicing source for particular 
		-- individuals with greater precision that would be possible using only a single low-pass filter."
		-- frequency 1500, bandwith 6000
		rgz.y0=0.9899658832*rgp.y0 + 0.008973522614*rgz.y1 +0.00108220316*rgz.y2
		rgz.y2,rgz.y1=rgz.y1,rgz.y0
		

		-- rgs filter frequency 0, bandwidth 200
		b,c=b_factor[21],c_factor[21]
		rgs.y0=(1-b-c)*x0+b*rgs.y1+c*rgs.y2
		rgs.y2,rgs.y1=rgs.y1,rgs.y0

		uglot2=rgz.y0+rgs.y0
	
		noise=gaussian_noise()
			-- radiaion characteristic is a zero at the origin
		uglot=uglot2-uglotx + ah*noise
		uglotx=uglot2

		return uglot
	end
	function formant(x,s) --s[1]=f s[2] =bw
		local b=b_factor[s[2]\10+1]*cos(-s[1]/5512.5)  -- calculate b coefficient

		local c=c_factor[s[2]\10+1] -- look up c coefficient
		s.y2=s.y1
		s.y1=s.y0
		s.y0=(1-b-c)*x + b*s.y1 + c*s.y2
		return s.y0
	end
	function declare()
		if #sounds >0 then
			while stat(108)<1536 do
				for i=0,512 do
					if duration < 1 then
						duration,av,av_step,ah,ah_step,af,af_step,cascade,f_step,bw_step=unpack(sounds[1])
					--	stop()
					end	 
					sample=glottis()
					for i=1,#cascade do
						sample=formant(sample,cascade[i])
						if (flr(cascade[i][1])!=cascade[i][3]) cascade[i][1]+=f_step[i] --increment frequency
						if (flr(cascade[i][2])!=cascade[i][4]) cascade[i][2]+=bw_step[i] --increment bandwidth
					end

					poke(buffer+i,sample*volume+128)
				--	av,ah,af+=av_step,ah_step,af_step
					av+=av_step
					ah+=ah_step
					af+=af_step
					duration -=1
					if duration < 1 then
						deli(sounds,1)
						if #sounds == 0 then
							serial(0x808,buffer,i+1)
							return
						end
						--duration,av,av_step,ah,ah_step,af,af_step,cascade=unpack(sounds[0])
					end
				--printh(sample,"log.txt")
				end
				serial(0x808,buffer,512)	
			end
		end	
	end
function _init()
	t=0
end
function _update()
	declare()
	while stat(30) do
		keypress(stat(31))
	end
--	if (btnp(right)) then
--		phone_index=(phone_index+1)%#phone_reference
--		phoneme=phone_reference[phone_index+1]
--		synthesizer[phonemes[phoneme][1]](unpack(phonemes[phoneme],2))
--	end
--	if btnp(left) then
--		phone_index-=1
--		if (phone_index <0)  phone_index=#phone_reference-1
--		phoneme=phone_reference[phone_index+1]
--		synthesizer[phonemes[phoneme][1]](unpack(phonemes[phoneme],2))
--	end

	if (btnp(fire2)) then
		sounds={}
		for s in all(phonemes.ay) do
			local cascade={}
			for c in all(s.cascade) do
				add(cascade,{unpack(c)})
				cascade[#cascade].y0=0
				cascade[#cascade].y1=0
				cascade[#cascade].y2=0
			end	
			for f in all(s.frames) do
				local d=f[1] --duration
				-- add {duration,av,av_step,ah,ah_step,af,af_step,cascade}
				add(sounds,{d,f[2],(f[3]-f[2])/d,f[4],(f[5]-f[4])/d,f[6],(f[7]-f[6])/d,cascade,f[8],f[9]})
			end	
			--stop()
		end		
	end	
end
function _draw()
	cls()
	line(0,64,127,64,7)
	for i=1,127 do
		line(i,127-peek(buffer+i-1)/2,i,127-peek(buffer+i)/2,8)
	end
end