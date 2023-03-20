var phoneticize = function(passage)
{
	//http://www.viviancook.uk/Words/StructureWordsList.htm
	var functors="a,about,above,after,after,again,against,ago,ahead,all,almost,almost,along,already,also,although,always,am,among,an,and,any,are,aren't,around,as,at,away,backward,backwards,be,because,before,behind,below,beneath,beside,between,both,but,by,can,cannot,can't,cause,'cos,'cuz,could,couldn't,'d,despite,did,didn't,do,does,doesn't,don't,down,during,each,either,even,ever,every,except,for,forward,from,had,hadn't,has,hasn't,have,haven't,he,her,here,hers,herself,him,himself,his,how,however,i,if,in,inside,inspite,instead,into,is,isn't,it,its,itself,just,'ll,least,less,like,'m,many,may,mayn't,me,might,mightn't,mine,more,most,much,must,mustn't,my,myself,near,need,needn't,needs,neither,never,no,none,nor,not,now,of,off,often,on,once,only,onto,or,ought,oughtn't,our,ours,ourselves,out,outside,over,past,perhaps,quite,'re,rather,'s,seldom,several,shall,shan't,she,should,shouldn't,since,so,some,sometimes,soon,than,that,the,their,theirs,them,themselves,then,there,therefore,these,they,this,those,though,through,thus,till,to,together,too,towards,under,unless,until,up,upon,us,used,usedn't,usen't,usually,'ve,very,was,wasn't,we,well,were,weren't,what,when,where,whether,which,while,who,whom,whose,why,will,with,without,won't,would,wouldn't,yet,you,your,yours,yourself,yourselves".split(",")

	passage=passage.toLowerCase().replaceAll(/\s+/g, ' ').replace(";",".").trim().replaceAll(" -","-").replaceAll("- ","-").replaceAll(" ,",",").replaceAll(", ",",").replaceAll(" .",".").replaceAll(". ",".").replaceAll(" ?","?").replaceAll("? ","?").replaceAll("’","'")
	if (!passage[passage.length-1].match(/[\!\?\.]/g))passage+="."
	var words=[]
	var word={spelling:"",syntax:" ",pronunciations:[],functor:false} 
	function finalize(char)
	{
		word.syntax=char
		if(functors.find(w=>w===word.spelling))word.functor=true
		words.push(word)
		return {spelling:"",syntax:char,pronunciations:[],functor:false} 
	}
	for (let i = 0; i < passage.length; i++)
	{
		switch (passage[i]) 
		{
			case ".":
				word=finalize(".")
				break
				
			case "?":
				word=finalize("?")
				break  
			case "!":
				word=finalize("!")
				break  	
			case ",":
				word=finalize(",")
				break
			case "-":
				word=finalize("-")
				break
			case " ":
				word=finalize(" ")
				break	
			case "*":
				if (word.spelling.length>0)
				{
					update(".")
				}
				break
			default:
				word.spelling+=passage[i]
		}
	}
	words.forEach(word=>word.pronunciations=word.pronunciations.concat(pronouncing.phonesForWord(word.spelling)))
	var result=""
	words.forEach(word=>
	{
		var w=""
		word.pronunciations.forEach((p,index)=>w+=(index>0?"[":"")+p.replaceAll(" ","/")+(index>0?"]":""))
		w+="/"+word.syntax+"/"
		if (!word.functor) w="^/"+w
		result+=w
	})
	return result.slice(0,-1).toLowerCase()
}

var syllabify=function(phoneticizedPassage)  //array of phones and prosody markers [HH,EH1,l,ow,.]
{

	//https://en.wikipedia.org/wiki/English_phonology#Syllable_structure
	var onsets="hh/l/r/m/n/ng/ch/jh/dh/f/s/sh/zh/k/p/t/g/b/d/th/v/z/w/y/pl/bl/kl/gl/pr/br/tr/dr/kr/gr/tw/dw/gw/kw/pw/fl/sl/thl/shl/vl/fr/thr/shr/hw/sw/thw/vw/py/by/ty/dy/ky/gy/my/ny/fy/vy/thy/sy/zy/hy/ly/sp/st/sk/sm/sn/sf/sth/spl/skl/spr/str/skr/skw/spy/sty/sky/sny/sfr"
	var codas="l/lp/lb/lt/ld/lch/lzh/lf/lv/lth/ls/lz/lsh/lm/ln/r/m/md/mf/mz/mt/mth/mpt/mps/n/nf/nth/nz/nts/ntth/n/nd/nddh/ng/ngd/ngth/ngkt/ngks/ngkth/ngdh/ngkt/ch/dh/dhd/f/ft/s/sp/st/sk/th/fth/fths/sh/zh/k/ks/kst/ksth/kt/kts/p/pt/pts/pth/ps/t/tth/ts/g/b/d/dth/dz/th/v/z/zd/y"
	var nuclei="aa/ae/ah/ao/aw/ay/eh/rr/ey/ih/iy/ow/oy/uh/uw/ar/er/ir/or/ur"
	var stops="ch/b/d/dx/g/jh/k/p/t/tq"
	var rhotacize={aa:"ar",eh:"er",ih:"ir",ao:"or",uh:"ur"}
	var syllabicConsonant={l:"el",n:"en",m:"em"}
	var contentWord=false
	var syllable=[]
	var onsetCluster=""
	var onset=[]
	var coda=[]
	var count=0
	var syllables=[]
	word=[]
	var stress=""
	
	var segments=phoneticizedPassage.replace(/\[(.*?)\]/g,"").split("/")  //remove bracketed phonemes
	var prosody=1
	var startWord=true,startPhrase=true,startClause=true,endWord=false,endPhrase=false,endClause=false
	var phoneme,priorPhoneme
	// prosody 0==default, 1=initial syllable of word, 2= last syllable of word, 3== start syllable of phrase, 4 ==last syllable of phrase, 5 == initial syllable of clause, 6==last syllable of clause

	segments.forEach((segment,segmentIndex)=>
	{
		if (segment==="^") {contentWord=true}
		else
		{
			priorPhoneme=phoneme
			phoneme=segment.replace(/\d+/g, '')
			//er=>rr
			if (phoneme=="er"){phoneme="rr"}  //rename phoneme
			if (phoneme=="r" && "aa/eh/ih/ao/uh".includes(priorPhoneme)) //ar er ir or ur substitutions
			{
				syllables[syllables.length-1][syllables[syllables.length-1].length-1].phoneme=rhotacize[priorPhoneme]
			}
			else if(priorPhoneme=="ah" && stress==="0" && (phoneme=="l" || phoneme=="n" || phoneme=="m" )) //el en em substitutions.
			{
				syllables[syllables.length-1][syllables[syllables.length-1].length-1].phoneme=syllabicConsonant[phoneme]
				syllables[syllables.length-1][syllables[syllables.length-1].length-1].stress=stress
			}
			else 
			{
				let s=segment.replace(/[a-z]+/g,"")
				stress=isNaN(parseInt(s))?stress:s
				if (onsets.includes(onsetCluster+phoneme))
				{
					onsetCluster+=phoneme
					onset.push({duration:1,phoneme:phoneme,stress:stress,prosody,onset:true,nucleus:false,coda:false,rime:false,stop_consonant:stops.includes(phoneme),startWord:startWord,startPhrase:startPhrase,startClause:startClause,endWord:endWord,endPhrase:endPhrase,endClause:endClause,contentWord:contentWord,startSyllable:false})
				}
				else
				{
					if (nuclei.includes(phoneme))
					{
						
						syllable=syllable.concat(onset)
						onset=[]
						onsetCluster=""
						
						syllable.push({duration:1,phoneme:phoneme,stress:stress,prosody,onset:false,nucleus:true,coda:false,rime:true,stop_consonant:stops.includes(phoneme),startWord:startWord,startPhrase:startPhrase,startClause:startClause,endWord:endWord,endPhrase:endPhrase,endClause:endClause,contentWord:contentWord,startSyllable:false}) //incorrect if coda found later...
						syllable.forEach(phone=>phone.stress=stress)
						syllable[0].startSyllable=true
						syllables.push(syllable)

						syllable=[]
						count+=1
					}
					else //coda or prosody marker found
					{
						if (phoneme.match(/[\ \-\,\?\.]/g)) //word, phrase or clause boundary
						{
							if (onset.length>0) //add missing coda to previous syllable

							{
								onset.forEach(phone=>
								{
									phone.onset=false
									phone.coda=true
									phone.rime=true
									phone.contentWord=contentWord
									phone.startSyllable=false
								})
								syllables[syllables.length-1]=syllables[syllables.length-1].concat(onset) 
							}	
							//populate syllable stress
							syllables[syllables.length-1].forEach(phone=>{phone.stress=stress})
							syllables[syllables.length-1][0].startSyllable=true
							for (let index = syllables.length-count; index < syllables.length; index++) 
							{
								syllables[index].forEach(phone=>phone.polysyllabic=count>1)
							}
							count=0
							switch (phoneme) 
							{
								case " ":
									syllables[syllables.length-1].forEach(phone=>
										{
											phone.prosody=1
											phone.endWord=true
											phone.stress=stress	

										})
										startWord=true
										endWord=false
									break
								case "-":
									syllables[syllables.length-1].forEach(phone=>{
										phone.prosody=2
										phone.endPhrase=true
										phone.endWord=true
										if (syllables.length>1)
										{
											phone.startWord=false
											phone.startPhrase=false
											phone.startClause=false
											phone.stress=stress
										}
									})
									startPhrase=true
									startWord=true
									endPhrase=false
									endWord=false
									break
								case ".":
								case",":
								case "?":
								syllables[syllables.length-1].forEach(phone=>{
									phone.prosody=3
									phone.endClause=true
									phone.endPhrase=true
									phone.endWord=true
									phone.stress=stress

									/*if (syllables.length>1)
									{
										phone.startWord=false
										phone.startPhrase=false
										phone.startClause=false
									}*/
									if (phone.rime && phoneme === "?")phone.question=true
								})
								syllables[syllables.length-1][0].startSyllable=true
								
								startClause=true
								startPhrase=true
								startWord=true
								endClause=false
								endPhrase=false
								endWord=false
									break
								default:
									break
							}
							
							
							syllable=[]
							onset=[]
							onsetCluster=""
							contentWord=false
							stress=""
						}	
						else  //onset cluster + phoneme not valid onset so coda + start new syllable onset
						{
							
							
							onset.forEach(phone=>{phone.onset=false;phone.coda=true;phone.rime=true;phone.contentWord=contentWord})
							//add missing coda to previous syllable 
							syllables[syllables.length-1]=syllables[syllables.length-1].concat(onset) 
							//populate syllable stress
							syllables[syllables.length-1].forEach(phone=>{phone.stress=stress})
							startWord=false
							startPhrase=false
							startClause=false
							onset=[]
							onsetCluster=""
							syllable=[]
							onset=[{duration:1,phoneme:phoneme,stress:stress,prosody,onset:true,nucleus:false,coda:false,rime:false,stop_consonant:stops.includes(phoneme),startWord:startWord,startPhrase:startPhrase,startClause:startClause,endWord:endWord,endPhrase:endPhrase,endClause:endClause,contentWord:true,startSyllable:false}]
							syllables[syllables.length-1][0].startSyllable=true
							onsetCluster=phoneme
						}

					}
				}	
			}
		}		
	})
	return syllables
}

var intone=function(syllables)
{

	//https://archive.org/details/frontiersofspeec0000unse/page/287/mode/1up?view=theater

	var consonants="hh/l/el/lx/r/m/em/n/en/ng/ch/jh/dh/f/s/sh/zh/k/p/t/g/b/d/th/v/z/w/y"
	var liquids="l/el/lx/r"
	var nasals="m/n/ng/en/em"
	var sonorants="y/w/l/el/lx/r/m/em/n/en/ng"
	var voicedFricatives="v/z/dh/zh"
	var voicedPlosives="b/d/g"
	var voicelessPlosives="k/p/t"
	var nonNasalSonorants="y/w/l/el/lx/r/aa/ae/ah/ao/aw/ay/eh/rr/ar/er/ir/or/ur/ey/ih/iy/ow/oy/uh/uw"
	var vowels="aa/ae/ah/ao/aw/ay/eh/rr/ar/er/ir/or/ur/ey/ih/iy/ow/oy/uh/uw"
	var innateDuration={aa:1320,ae:1270,ah:770,ao:1320,aw:720,ay:690,eh:830,rr:990,ar:960,er:1000,ir:840,or:880,ur:840,ey:1040,ih:720,iy:880,ow:1210,oy:1540,uh:880,uw:1170,hh:440,l:440,lx:500,el:880,r:440,hh:440,m:390,em:940,n:360,en:940,ng:440,ch:385,jh:385,dh:275,f:660,s:690,sh:690,zh:385,k:360,p:470,t:360,tq:360,g:360,b:440,d:360,dx:110,th:606,v:330,z:410,w:440,y:440}

	var minimumDuration={aa:440,ae:330,ah:275,ao:440,aw:550,ay:495,eh:330,rr:330,ar:100,er:100,ir:100,or:100,ur:100,ey:385,ih:220,iy:275,ow:385,oy:606,uh:275,uw:330,hh:110,l:220,lx:385,el:610, r:165,m:330,em:550, n:193, en:550, ng:275,ch:275,jh:275,dh:165,f:330,s:275,sh:275,zh:220,k:275,p:275,t:220,tq:275,g:275,b:275,d:220,dx:110,th:220,v:220,z:220,w:330,y:220}	
	var saying=""

	syllables.forEach((syllable,syllableIndex)=>
	{
		syllable.forEach((phone,phoneIndex)=>
		{
			//Substitutions:
			
			if (phone.coda)
			{
				//Rule a: use LX instead of L if L is in coda
				if (phone.phoneme=="l"){phone.phoneme="lx"}
			}

			
			
			//Rule d: a voiceless plosive is not released if followed by another voiceless plosive if in the same clause boundary
			//Rule e: insert a glottal stop before word initial stressed vowel if previous segment is syllabic (last sound in syllable?) or the previous segment is a voiced nonplossive and there is an intervening phrase boundary

		

			//Rule 1 insert 200 ms pause ahead of start of clause
			if (phone.startClause && phoneIndex==0) saying+="_/"

			//Rule 2 lengthen rime of clause-final syllable by 140%
			if(phone.endClause && phone.rime) phone.duration*=1.4
			else
			{
				//Rule 3 shorten non-phrase final syllable nucleus by 60%. 
				if(!phone.endPhrase && phone.nucleus) phone.duration*=.6
				//Rule 3 lengthen phrase final postvocalic nasals and liquids by 1.4 is covered by Rule 2
				//if (phone.endPhrase && phone.coda && (liquids.includes(phone.phoneme)||nasals.includes(phone.phoneme))) phone.duration*=1.4
			}
			//Rule 4 if nucleus is not in last syllable of word shorten by 85%
			if(!phone.endWord && phone.nucleus)phone.duration*=.85

			//Rule 5 shorten nuclei of polysllabic words by 80%
			if (phone.polysyllabic && phone.nucleus)phone.duration*=.8
			
			//Rule 6 shorten non-initial consonants by 85%

			if(!(phone.startWord && phoneIndex===0) && consonants.includes(phone.phoneme))phone.duration*=.85

			//Rule 7 Unstress Syllables: first or last syllable shortened 70%, middle syllables shortened 50%
			if((phone.stress==="0"|| phone.stress==="2" ))
			{
				if (phone.nucleus) 
				{
					if (phone.startWord || phone.endWord){phone.duration*=.7}
					else {phone.duration*=.5}
				}
				else  //onset liquids shortened to 10% in unstressed syllables
				{
					if(phone.onset && liquids.includes(phone.phoneme) )phone.duration*=.1
				}	
			}

			//Rule 9 adjust vowels based on consonant following them in the same word
			//open stressed syllable lengthen 120%
			if(phone.nucleus && phoneIndex === syllable.length-1 && phone.endWord && phone.stress==="1")
			{
				if (phone.endphrase || phone.endClause){phone.duration*=1.2}
				else{phone.duration*=1.06}
			}
			var nextPhone  //the next sound segment regardless of any word, phrase, or clause boundaries
			if (phoneIndex < syllable.length-1)
			{
				nextPhone=syllable[phoneIndex+1]
			}
			else
			{
				if (syllableIndex<syllables.length-1)
				{
					//if (!syllables[syllableIndex+1][0].startWord) nextPhone=syllables[syllableIndex+1][0]
					nextPhone=syllables[syllableIndex+1][0]
				}
			}
			//vowel precedes consonant in same word.
			if (nextPhone && !nextPhone.startWord)
			{
				//before voiced fricative lengthen 160%
				if (voicedFricatives.includes(nextPhone.phoneme))phone.duration*=phone.endPhrase || phone.endClause?1.6:1.18
				//before voiced plosive lengthen 120%
				if (voicedPlosives.includes(nextPhone.phoneme))phone.duration*=phone.endPhrase || phone.endClause?1.2:1.06
				//before unstressed nasal shorten to 85%
				if (nextPhone.stress==="0" && nasals.includes(nextPhone.phoneme))phone.duration*=phone.endPhrase || phone.endClause?.85:.955
				//before voiceless plosive shorten to 70%
				if (voicelessPlosives.includes(nextPhone.phoneme))phone.duration*=phone.endPhrase || phone.endClause?.7:.91
			}

			var priorPhone
			if (phoneIndex > 0){priorPhone=syllable[phoneIndex-1]}
			else
			{
				if (syllableIndex>0) priorPhone=syllables[syllableIndex-1][syllables[syllableIndex-1].length-1]
			}
	
			if (!phone.endClause && !phone.endPhrase && !phone.startClause && !phone.startPhrase)
			{
				//Rule b: use DX instead of D or T if within words and across word boundaries, but not across phrase and clause boundaries, if followed by a nonprimary stress vowel and preceeded by a non-nasal sonorant. "sat about" "latter"

				if ((phone.phoneme==="d" || phone.phoneme==="t") && nonNasalSonorants.includes(priorPhone.phoneme) &&
				nextPhone.nucleus && nextPhone.stress!=="1")
				{
					phone.phoneme="dx"
					phoneme="dx"
				}
			}
			//Rule c: use TQ instead of word final t if the next word starts with a stressed sonorant and the next word does not start a new phrase or clause.
			if (phone.phoneme==="t" && phone.endWord && sonorants.includes(nextPhone.phoneme) && nextPhone.stress==="1")
			{
				phone.phoneme="tq"
				phoneme="tq"
			}
			


			//Rule 10 clusters of consonants or clusters of vowels disregarding word boundaries, but not phrase or clause boundary
			if (priorPhone)
			{
				if(!(priorPhone.endPhrase || priorPhone.endClause))
				{
					if(priorPhone.nucleus && phone.nucleus) phone.duration*=.7 //vowels
					if(!priorPhone.nucleus && !phone.nucleus) phone.duration*=.7 //consonants
				}
			}
			if (nextPhone)
			{
				if(!(nextPhone.endPhrase || nextPhone.endClause))
				{
					if(nextPhone.nucleus && phone.nucleus) phone.duration*=1.2 //vowels
					if(!nextPhone.nucleus && !phone.nucleus) phone.duration*=.7  //consonants
				}
			}

			var {phoneme,duration,stop_consonant,stress}=phone
			var minimum=stress==="0"?minimumDuration[phoneme]/2:minimumDuration[phoneme]
			var d=(innateDuration[phoneme]-minimum)*duration+minimum

			//Rule 11 a vowel or sonorant with 1 or 2 stress preceded by a voiceless plosive is lengthened b 25 ms or 140 ticks
			if (priorPhone && (phone.nucleus || sonorants.includes(phone.phoneme)) && phone.stress>"0" && voicelessPlosives.includes(priorPhone.phoneme))d+=140
	
				
			
			if (stop_consonant || phoneme.match(/[\?\-\,\.]/g))
			{
				var duration=d/1100
				if (phoneme==="dx")
				{
					phone.phoneme="d"
				}
				
				
			}
			else
			{
				switch (phoneme) 
				{
					case "el":
						phone.phoneme="l"
						var duration=d/innateDuration.l
						break
						
					case "lx":
						phone.phoneme="l"
						var duration=d/innateDuration.l
						break  
					case "en":
						phone.phoneme="n"
						var duration=d/innateDuration.n
						break  	
					case "em":
						phone.phoneme="m"
						var duration=d/innateDuration.m
						break
					
					default:
						var duration=d/innateDuration[phoneme]	
				}		
			}
			durationText=Math.abs(Math.floor((1-duration)*100)).toString().padStart(2,"0")//get digits after decimal
			if (durationText[duration.length-1]==0)durationText=durationText.slice(0,-1) //removing trailing zero
			if (durationText!=="0")
			{
				if (duration<1){saying+="-1."+durationText+"/"}
				if (duration>1){saying+="1."+durationText+"/"}
			}	
			//Pitch Prosody https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4617729/
			//https://pdf.sciencedirectassets.com/272464/1-s2.0-S0095447019X47002/1-s2.0-S0095447019309891/main.pdf
			
			if(phone.endClause)
			{
				if (phone.question){saying+="3/"}
				else {saying+="-3/"}
			}	 
			else
			{
				if (phone.contentWord && phone.nucleus && phone.stress==="1") saying+="3/"
			}

			if (phoneme.match(/[\?\-\,\.]/g)) saying+="_/"	
			else
			{
				if (phone.stop_consonant) saying+="_/"
				if (phone.phoneme !== "tq"){saying+=phone.phoneme+"/"}
			}	
			

		})
	})	
	return saying.slice(0,-1)

}

