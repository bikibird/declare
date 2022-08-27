var phoneticize = function(passage)
{
	//http://www.viviancook.uk/Words/StructureWordsList.htm
	var functors="a,about,above,after,after,again,against,ago,ahead,all,almost,almost,along,already,also,although,always,am,among,an,and,any,are,aren't,around,as,at,away,backward,backwards,be,because,before,behind,below,beneath,beside,between,both,but,by,can,cannot,can't,cause,'cos,'cuz,could,couldn't,'d,despite,did,didn't,do,does,doesn't,don't,down,during,each,either,even,ever,every,except,for,forward,from,had,hadn't,has,hasn't,have,haven't,he,her,here,hers,herself,him,himself,his,how,however,i,if,in,inside,inspite,instead,into,is,isn't,it,its,itself,just,'ll,least,less,like,'m,many,may,mayn't,me,might,mightn't,mine,more,most,much,must,mustn't,my,myself,near,need,needn't,needs,neither,never,no,none,nor,not,now,of,off,often,on,once,only,onto,or,ought,oughtn't,our,ours,ourselves,out,outside,over,past,perhaps,quite,'re,rather,'s,seldom,several,shall,shan't,she,should,shouldn't,since,so,some,sometimes,soon,than,that,the,their,theirs,them,themselves,then,there,therefore,these,they,this,those,though,through,thus,till,to,together,too,towards,under,unless,until,up,upon,us,used,usedn't,usen't,usually,'ve,very,was,wasn't,we,well,were,weren't,what,when,where,whether,which,while,who,whom,whose,why,will,with,without,won't,would,wouldn't,yet,you,your,yours,yourself,yourselves".split(",")

	passage=passage.toLowerCase().replaceAll(/\s+/g, ' ').replace(";",".").trim().replaceAll(" -","-").replaceAll("- ","-").replaceAll(" ,",",").replaceAll(", ",",").replaceAll(" .",".").replaceAll(". ",".").replaceAll(" ?","?").replaceAll("? ","?").replaceAll("’","'")
	if (!passage[passage.length-1].match(/[\!\?\.]/g))passage+="."
	var words=[]
	var word={spelling:"",syntax:" ",pronounciations:[],functor:false} 
	function finalize(char)
	{
		word.syntax=char
		if(functors.find(w=>w===word.spelling))word.functor=true
		words.push(word)
		return {spelling:"",syntax:char,pronounciations:[],functor:false} 
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
	words.forEach(word=>word.pronounciations=word.pronounciations.concat(pronouncing.phonesForWord(word.spelling)))
	var result=""
	words.forEach(word=>
	{
		var w=""
		word.pronounciations.forEach((p,index)=>w+=(index>0?"[":"")+p.replaceAll(" ","/")+(index>0?"]":""))
		w+="/"+word.syntax+"/"
		if (!word.functor) w="^/"+w
		result+=w
	})
	return result.slice(0,-1).toLowerCase()
}

var syllabify=function(phoneticizedPassage)  //array of phones and prosody markers [HH,EH1,l,ow,.]
{

	//https://en.wikipedia.org/wiki/English_phonology#Syllable_structure
	var onsets="hh,l,r,m,n,ng,ch,jh,dh,f,s,sh,zh,k,p,t,g,b,d,th,v,z,w,y,pl,bl,kl,gl,pr,br,tr,dr,kr,gr,tw,dw,gw,kw,pw,fl,sl,thl,shl,vl,fr,thr,shr,hw,sw,thw,vw,py,by,ty,dy,ky,gy,my,ny,fy,vy,thy,sy,zy,hy,ly,sp,st,sk,sm,sn,sf,sth,spl,skl,spr,str,skr,skw,spy,sty,sky,sny,sfr"
	var nuclei="aa,ae,ah,ao,aw,ay,eh,er,ey,ih,iy,ow,oy,uh,uw"
	var stops="ch,b,d,g,jh,k,p,t"
	var contentWord=false
	var syllable=[]
	var onsetCluster=""
	var onset=[]
	var count=0
	var syllables=[]
	word=[]
	var stress=""
	var segments=phoneticizedPassage.replace(/\[(.*?)\]/g,"").split("/")  //remove bracketed phonemes
	var prosody=1
	var startWord=true,startPhrase=true,startClause=true,endWord=false,endPhrase=false,endClause=false
	// prosody 0==default, 1=initial syllable of word, 2= last syllable of word, 3== start syllable of phrase, 4 ==last syllable of phrase, 5 == initial syllable of clause, 6==last syllable of clause
	segments.forEach((segment,segmentIndex)=>
	{
		if (segment==="^") {contentWord=true}
		else
		{
			stress=segment.replace(/[a-z]+/g,"")
			phoneme=segment.replace(/\d+/g, '')
			
			if (onsets.includes(onsetCluster+phoneme))
			{
				onsetCluster+=phoneme
				onset.push({duration:1,phoneme:phoneme,stress:stress,prosody,onset:true,nucleus:false,coda:false,rime:false,stop_consonant:stops.includes(phoneme),startWord:startWord,startPhrase:startPhrase,startClause:startClause,endWord:endWord,endPhrase:endPhrase,endClause:endClause,contentWord:contentWord})
			}
			else
			{
				if (nuclei.includes(phoneme))
				{
					syllable=syllable.concat(onset)
					onset=[]
					onsetCluster=""
					syllable.push({duration:1,phoneme:phoneme,stress:stress,prosody,onset:false,nucleus:true,coda:false,rime:true,stop_consonant:stops.includes(phoneme),startWord:startWord,startPhrase:startPhrase,startClause:startClause,endWord:endWord,endPhrase:endPhrase,endClause:endClause,contentWord:contentWord}) //incorrect if coda found later...
					syllables.push(syllable)
					startWord=false
					startPhrase=false
					startClause=false
					syllable=[]
					count+=1
				}
				else //coda or prosody marker found
				{
					if (phoneme.match(/[\ \-\,\?\.]/g)) //word, phrase or clause boundary
					{
						if (onset.length>0)
						{
							onset.forEach(phone=>{phone.onset=false;phone.coda=true;phone.rime=true;phone.contentWord=contentWord})
							syllables[syllables.length-1]=syllables[syllables.length-1].concat(onset) //add missing coda to previous syllable
						}	
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
										phone.phraseWord=false
										phone.startClause=false
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
								if (syllables.length>1)
								{
									phone.startWord=false
									phone.startPhrase=false
									phone.startClause=false
								}
								if (phone.rime && phoneme === "?")phone.question=true
							})
							

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
						
					}	
					else  //onset cluster + phoneme not valid onset so coda + start onset
					{
						onset.forEach(phone=>{phone.onset=false;phone.coda=true;phone.rime=true;phone.contentWord=contentWord})
						syllables[syllables.length-1]=syllables[syllables.length-1].concat(onset) //add missing coda to previous syllable

						startWord=false
						startPhrase=false
						startClause=false
						onset=[]
						onsetCluster=""
						syllable=[]
						onset=[{duration:1,phoneme:phoneme,stress:stress,prosody,onset:true,nucleus:false,coda:false,rime:false,stop_consonant:stops.includes(phoneme),startWord:startWord,startPhrase:startPhrase,startClause:startClause,endWord:endWord,endPhrase:endPhrase,endClause:endClause,contentWord:true}]
						onsetCluster=phoneme
					}
				}
			}
		}		
	})
	return syllables
}

var intone=function(syllables)
{
	var consonants="hh,l,r,m,n,ng,ch,jh,dh,f,s,sh,zh,k,p,t,g,b,d,th,v,z,w,y"
	var liquids="l,r"
	var nasals="m,n,ng"
	var sonorants="y,w,l,r,m,n,ng"
	var voicedFricatives="v,z,dh,zh"
	var voicedPlosives="b,d,g"
	var voicelessPlosives="k,p,t"

	var innateDuration={aa:1320,ae:1270,ah:770,ao:1320,aw:720,ay:690,eh:830,er:990,ey:1040,ih:720,iy:880,ow:1210,oy:1540,uh:880,uw:1170,hh:440,l:440,r:440,hh:440,m:390,n:360,ng:440,ch:385,jh:385,dh:275,f:660,s:690,sh:690,zh:385,k:360,p:470,t:360,g:360,b:440,d:360,th:606,v:330,z:410,w:440,y:440}

	var minimumDuration={aa:440,ae:330,ah:275,ao:440,aw:550,ay:495,eh:330,er:330,ey:385,ih:220,iy:275,ow:385,oy:606,uh:275,uw:330,hh:110,l:220,r:165,m:330,n:193,ng:275,ch:275,jh:275,dh:165,f:330,s:275,sh:275,zh:220,k:275,p:275,t:220,g:275,b:275,d:220,th:220,v:220,z:220,w:330,y:220}	
	var saying=""
	
	syllables.forEach((syllable,syllableIndex)=>
	{
		syllable.forEach((phone,phoneIndex)=>
		{

			//Rule 1 insert 200 ms pause ahead of start of clause
			if (phone.startClause && phoneIndex==0) saying+="_/"

			//Rule 2 lengthen rime of clause-final syllable by 140%
			if(phone.endClause && phone.rime) phone.duration*=1.4
			else
			{
				//Rule 3 shorten non-phrase final syllable nucleus by 60%. 
				if(!phone.endPhrase && phone.nucleus) phone.duration*=.6
				//Rule 3 lengthen phrase final postvocalic nasals and liquids by 1.4
				if (phone.endPhrase && phone.coda && (liquids.includes(phone.phoneme)||nasals.includes(phone.phoneme))) phone.duration*=1.4
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
			var nextPhone
			if (phoneIndex < syllable.length-1){nextPhone=syllable[phoneIndex+1]}
			else
			{
				if (syllableIndex<syllables.length-1)
				{
					if (!syllables[syllableIndex+1][0].startWord) nextPhone=syllables[syllableIndex+1][0]
				}
			}
			//vowel proeeds consonant in same word.
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
			}
			else
			{
				var duration=d/innateDuration[phoneme]
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
				saying+=phone.phoneme+"/"	
			}	
			

		})
	})	
	return saying.slice(0,-1)

}

