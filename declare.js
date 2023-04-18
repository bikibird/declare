var phoneticize = function(passage)
{
	//http://www.viviancook.uk/Words/StructureWordsList.htm
	var functors="a,about,above,after,after,again,against,ago,ahead,all,almost,almost,along,already,also,although,always,am,among,an,and,any,are,aren't,around,as,at,away,backward,backwards,be,because,before,behind,below,beneath,beside,between,both,but,by,can,cannot,can't,cause,'cos,'cuz,could,couldn't,'d,despite,did,didn't,do,does,doesn't,don't,down,during,each,either,even,ever,every,except,for,forward,from,had,hadn't,has,hasn't,have,haven't,he,her,here,hers,herself,him,himself,his,how,however,i,if,in,inside,inspite,instead,into,is,isn't,it,its,itself,just,'ll,least,less,like,'m,many,may,mayn't,me,might,mightn't,mine,more,most,much,must,mustn't,my,myself,near,need,needn't,needs,neither,never,no,none,nor,not,now,of,off,often,on,once,only,onto,or,ought,oughtn't,our,ours,ourselves,out,outside,over,past,perhaps,quite,'re,rather,'s,seldom,several,shall,shan't,she,should,shouldn't,since,so,some,sometimes,soon,than,that,the,their,theirs,them,themselves,then,there,therefore,these,they,this,those,though,through,thus,till,to,together,too,towards,under,unless,until,up,upon,us,used,usedn't,usen't,usually,'ve,very,was,wasn't,we,well,were,weren't,what,when,where,whether,which,while,who,whom,whose,why,will,with,without,won't,would,wouldn't,yet,you,your,yours,yourself,yourselves".split(",")
	var syllabic={AA:true,AE:true,AH:true,AO:true,AW:true,AR:true,EH:true,EL:true,EM:true,EN:true,ER:true,RR:true,EY:true,HH:true,IH:true,IR:true,IY:true,OW:true,OR:true,OY:true,UH:true,UW:true,UR:true}
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
	words.forEach(word=>
	{
		word.pronunciations=word.pronunciations.concat(pronouncing.phonesForWord(word.spelling))
	

	})
	//Rule 6 if next word starts with vowel, prefer dh iy pronounciation of "the".
	for (let i = 0; i < words.length-1; i++)
	{
		if (words[i].spelling==="the" && syllabic[words[i+1].pronunciations[0].substring(0,2)])
		{
			words[i].pronunciations=["dh iy0","dh ah0","dh ah1"]
		}
		
	}
	var phoneticizedPassage=""
	words.forEach(word=>
	{
		var w=""
		word.pronunciations.forEach((p,index)=>w+=(index>0?"[":"")+p.replaceAll(" ","/")+(index>0?"]":""))
		w+="/"+word.syntax+"/"
		if (!word.functor) w="^/"+w
		phoneticizedPassage+=w
	})
	return phoneticizedPassage.slice(0,-1).toLowerCase()
}

//https://archive.org/details/frontiersofspeec0000unse/page/287/mode/1up?view=theater
//https://archive.org/details/fromtexttospeech00alle/page/93/mode/1up?view=theater
var renderSpeechString=function(phoneticizedPassage)  //array of phones and prosody markers [HH,EH1,l,ow,.]
{
	
	var syllabic={aa:true,ae:true,ah:true,ao:true,aw:true,ar:true,eh:true,el:true,em:true,en:true,er:true,rr:true,ey:true,hh:true,ih:true,ir:true,iy:true,ow:true,or:true,oy:true,uh:true,uw:true,ur:true}

	var onset={hh:true,l:true,r:true,m:true,n:true,ng:true,ch:true,jh:true,dh:true,f:true,s:true,sh:true,zh:true,k:true,p:true,t:true,g:true,b:true,d:true,th:true,v:true,z:true,w:true,y:true,pl:true,bl:true,kl:true,gl:true,pr:true,br:true,tr:true,dr:true,kr:true,gr:true,tw:true,dw:true,gw:true,kw:true,pw:true,fl:true,sl:true,thl:true,shl:true,vl:true,fr:true,thr:true,shr:true,hw:true,sw:true,thw:true,vw:true,py:true,by:true,ty:true,dy:true,ky:true,gy:true,my:true,ny:true,fy:true,vy:true,thy:true,sy:true,zy:true,hy:true,ly:true,sp:true,st:true,sk:true,sm:true,sn:true,sf:true,sth:true,spl:true,skl:true,spr:true,str:true,skr:true,skw:true,spy:true,sty:true,sky:true,sny:true,sfr:true}

	var coda={l:true,lp:true,lb:true,lt:true,ld:true,lch:true,lzh:true,lf:true,lv:true,lth:true,ls:true,lz:true,lsh:true,lm:true,ln:true,r:true,m:true,md:true,mf:true,mz:true,mt:true,mth:true,mpt:true,mps:true,n:true,nf:true,nth:true,nz:true,nts:true,ntth:true,n:true,nd:true,nddh:true,nds:true,ng:true,ngd:true,ngth:true,ngkt:true,ngks:true,ngkth:true,ngdh:true,ngkt:true,ch:true,dh:true,dhd:true,f:true,ft:true,s:true,sp:true,st:true,sk:true,th:true,fth:true,fths:true,sh:true,zh:true,k:true,ks:true,kst:true,ksth:true,kt:true,kts:true,p:true,pt:true,pts:true,pth:true,ps:true,t:true,tth:true,ts:true,g:true,b:true,d:true,dth:true,dz:true,th:true,v:true,z:true,zd:true,y:true}
	
	//Durations in milliseconds

	var innateDuration={aa:240,ae:230,ah:140,ao:240,aw:260,ay:250,eh:150,rr:180,ar:260,er:270,ir:230,or:240,ur:230,ey:190,ih:135,iy:155,ow:220,oy:280,uh:160,uw:210,hh:80,l:80,lx:90,el:260,r:80,m:70,em:170,n:60,en:170,ng:95,ch:70,jh:70,dh:50,f:100,s:105,sh:105,zh:70,k:80,p:90,t:75,g:80,b:85,d:75,dd:20,th:90,v:60,z:75,w:80,y:80}

	var minimumDuration={aa:100,ae:80,ah:60,ao:100,aw:100,ay:150,eh:70,rr:80,ar:120,er:130,ir:100,or:130,ur:110,ey:100,ih:40,iy:55,ow:80,oy:150,uh:60,uw:70,hh:20,l:40,lx:70,el:110,r:30,m:60,em:110,n:50,en:100,ng:60,ch:50,jh:50,dh:30,f:80,s:60,sh:80,zh:40,k:60,p:50,t:50,g:60,b:60,d:50,dd:20,th:60,v:40,z:40,w:60,y:40}	


	var rhotacize={aa:"ar",eh:"er",ih:"ir",ao:"or",uw:"ur"}
	var syllabicConsonant={l:"el",n:"en",m:"em"}
	var contentW=false
	var word=[]  
	var phrase=[]
	var clause=[]
	var polysyllabic=0
	var segments=phoneticizedPassage.replace(/\[(.*?)\]/g,"").split("/")  //remove bracketed phonemes
	var speechString=""
	var sonorant={aa:true,ae:true,ah:true,ao:true,aw:true,ar:true,eh:true,el:true,em:true,en:true,er:true,rr:true,ey:true,hh:true,ih:true,ir:true,iy:true,l:true,lx:true,m:true,n:true,ng:true,ow:true,or:true,oy:true,r:true,uh:true,uw:true,ur:true,w:true,y:true}
	var glide={w:true,y:true}
	var liquid={el:true,l:true,lx:true,r:true,w:true,y:true}
	var liquidOrGlide=Object.assign(Object.assign({},liquid),glide)
	var nasal={em:true,en:true,n:true,m:true,ng:true}
	var liquidOrNasal=Object.assign(Object.assign({},liquid),nasal)
	var sonorantConsonant=Object.assign(Object.assign({},liquidOrNasal),glide)
	var voicedFricative={dh:true,v:true,z:true,zh:true}
	var voicedPlosive={b:true,d:true,g:true,jh:true}
	var voicelessPlosive={ch:true,k:true,p:true,t:true}
	var plosive=Object.assign(Object.assign({},voicedPlosive),voicelessPlosive)
	segments.forEach((segment)=>
	{
		if (segment==="^") {contentW=true}
		else
		{
			phoneme=segment.replace(/\d+/g, '')
			//er=>rr
			if (phoneme=="er"){phoneme="rr"}  //rename phoneme
			
			if (phoneme=="r" && rhotacize[word[word.length-1]?.phoneme] ) //ar er ir or ur substitutions 
			{
				word[word.length-1].phoneme=rhotacize[word[word.length-1].phoneme]
			}
			else if(word[word.length-1]?.phoneme=="ah" && word[word.length-1]?.stress==="0" && (phoneme=="l" || phoneme=="n" || phoneme=="m" )) //el en em substitutions.
			{
				word[word.length-1].phoneme=syllabicConsonant[phoneme]
				
			}
			
			else //skip if phone r, l, m, or n was syllabasized and absorbed into prior vowel because phone no longer exists.
			{
				if (syllabic[phoneme]) //mark up nucleus
				{

					stress=segment.replace(/[a-z]+/g,"")
					polysyllabic ++  //syllable count
					phone={duration:1,duration11:0,phoneme:phoneme,stress:segment.replace(/[a-z]+/g,""), nucleus:true, startWord:false,endWord:false,startPhrase:false,endPhrase:false}
					phone.minDur=minimumDuration[phoneme]	

					//Rule 7
					if (stress==="0")
					{
						phone.minDur=phone.minDur/2
					}
					word.push(phone)
				}
				else if (" -,?.".includes(phoneme)) //prosody marker
				{
					//Word level markup

					//assign stress to onset and coda of primary stress syllable in preparation of Rule 7.
					var syllableCount=0
					var cluster=""
					var clusterLength=0
					var onsetFlag=true
					var codaStress=""
					for (let i =0; i< word.length; i++)
					{
						if (onsetFlag )  //mark stressed syllable consonants
							{
								if(onset[cluster+word[i].phoneme])
								{
									cluster=cluster+word[i].phoneme
									clusterLength++
								}

							}
							else
							{
								if(coda[cluster+word[i].phoneme])
								{
									cluster=cluster+word[i].phoneme
									clusterLength++
								}
								else
								{
									for (let j=i-clusterLength;j < i;j++) 
									{
										word[j].stress=codaStress
										
									}
									onsetFlag=true
									if (word[i].nucleus)
									{
										cluster=""
										clusterLength=0
									}
									else
									{
										cluster=word[i].phoneme
										clusterLength=1
									}
									
									codaStres=""
								}

							}
						
						if (word[i].nucleus)
						{
							word[i].syllable==syllableCount
							syllableCount++
							
							if (word[i].stress==="1")  
							{
								if (onsetFlag && i>0)  //add stress to onset consonants
								{
									
									for (let j=1;j <= clusterLength;j++) 
									{
										word[i-j].stress=word[i].stress
										
									}
									onsetFlag=false
									codaStress=word[i].stress
								}
								
							}
							else
							{
								if(codaStress==="1")
								{
									for (let j=i-clusterLength;j < i;j++) 
									{
										word[j].stress=codaStress
										
									}
								}	
							}
							
							cluster=""
							clusterLength=0
						}
					}
					if (codaStress==="1" && clusterLength>0)
					{
						for (let j=word.length-clusterLength;j < word.length;j++) 
						{
							word[j].stress=codaStress
							
						}
					}
					
					// apply word level rules

					for (let i = word.length-1; i>=0; i--)  
					{
						phone=word[i]
						phone.contentWord=contentW
						if (phone.phoneme==="l") //l -> lx substition
						{
							//if post vocalic l and next phone is not a stressed vowel
							if (word.length>1 && i!==0 &&(word[i-1].nucleus)&& (i===word.length-1 || (word[i+1].stress==="1" && word[i+1].nucleus)))
							{phone.phoneme="lx"}
						}
						if (polysyllabic>1)	{phone.polysyllabic=true}
						else {phone.polysyllabic=false}
						if (phone.nucleus)
						{
							if (syllableCount !==0){phone.duration*=.85}  //Rule 4 non-word final syllablic shortening
							if (polysyllabic>1){phone.duration*=.8}  //Rule 5 polysyllabic shortening
							if (phone.stress!=="1") //Rule 7 unstress and secondary stress shortening
							{
								if (i>0 && i<word.length-1 && phone.nucleus) //if vowel is in middle of word
								{
									phone.duration*=.5
									//if liquid or glide precedes vowel
									if (liquidOrGlide[word[i-1].phoneme]){word[i-1].duration*=.1}  
								} 
								else{phone.duration*=.7}//all other
							}
						
						}
						else  //consonant
						{
							if (i!==0) //non word initial consonant
							{
								word[i].duration*=.85 //Rule 6 non initial consonant shortening
							}  

						}
					}
					word[0].startWord=true
					word[word.length-1].endWord=true
					phrase=phrase.concat(word)
					word=[]
					syllableCount=0
					cluster=""
					clusterLength=0
					onsetFlag=true
					codaStress=""
					contentW=false

					if ("-,?.".includes(phoneme))
					{
						//phrase level rules
						phrase[0].startPhrase=true

						phrase[phrase.length-1].endPhrase=true
						for (let i =phrase.length-1; i>=0; i--) //mark final vowel before pause phrase or clause boundary and post vocalic consonants.
						{
							phrase[i].phraseFinal=true
							if (phrase[i].nucleus)
							{
								break
							}

						} 
						for (let i =0; i< phrase.length; i++)  
						{
							var phone=phrase[i]
							if (phone.phoneme==="t" || phone.phoneme==="d") //t,d -> dd segmental rule #2
							{
								//if  t or d between non-nasal sonorant and non stressed vowel

								if (i<phrase.length-1 && i!==0 &&(phrase[i-1].nucleus || sonorant[phrase[i-1].phoneme] ) && (phrase[i+1].stress!=="1" && phrase[i+1].nucleus))
								{
									phone.phoneme="dd"
								}

							}
							

							if (phrase[i].nucleus) //Rule 9 Postvocalic effect on nucleus
							{
								var percent1=1 
								if (phrase[i].endWord ||voicedPlosive[phrase[i+1].phoneme] ){percent1=1.2}  //open syllable or voiced plosive
								else if(voicedFricative[phrase[i+1].phoneme]){percent1=1.6} //voiced fricative
								else if(nasal[phrase.phoneme]){percent1=.85} //nasal
								else if(voicelessPlosive[phrase[i+1].phonem]){percent1=.7} //voiceless plossive
								if(phrase[i].phraseFinal)
								{
									phrase[i].duration*=percent1
								}
								else
								{
									phrase[i].duration*=(.7+ .3*percent1)
								}
							}
							if (phrase[i].nucleus && !phrase[i].phraseFinal )  //Rule 3 non-phrase final shortening
							{
								phrase[i].duration*=.6
							}
							if (liquidOrNasal[phrase[i].phoneme] && phrase[i].phraseFinal)  //rule 3 phrase final post vocalic liquid or nasal is lengthened
							{
								phrase[i].duration*=1.4
							}

							//Rule 10 cluster shortening
							if( i<phrase.length-1)
							{
								if(phrase[i].nucleus && phrase[i+1].nucleus ){phrase[i].duration*=.7} //vowel precedes vowel
								if(!phrase[i].nucleus && !phrase[i+1].nucleus ){phrase[i].duration*=.7} //const precedes const
								if(phrase[i].nucleus && (liquidOrNasal[phrase[i+1].phoneme]))
								{phrase[i+1].duration*=1.4}  //Rule 3 Post vocalic liquids and nasals

							} 
							if (i>0)
							{
								if(phrase[i-1].nucleus && phrase[i].nucleus ){phrase[i].duration*=1.2} //vowel follows vowel
								if(!phrase[i-1].nucleus && !phrase[i].nucleus ){phrase[i].duration*=.7} //const follows const
								//Rule 11 a 1 or 2 stress vowel or sonorant preceded by a voiceless plosive is lengthened b 25 ms or 140 ticks
								if((sonorant[phrase[i].phoneme] || (phrase[i].nucleus && phrase[i].stress!=="0") ) && voicelessPlosive[phrase[i-1].phoneme])
								{phrase[i].duration11=25} 

							}

						}

						phrase[0].startPhrase=true
						phrase[phrase.length-1].endPhrase=true
						clause=clause.concat(phrase)
						phrase=[]
						if (",?.".includes(phoneme)) 
						{
							//clause level rules

							for (let i = clause.length-1; i>=0; i--) //Rule 2 Lengthen rhyme of clause final syllable
							{
								clause[i].duration*=1.4
								if (clause[i].nucleus)
								{
									clause[i].clauseFinal=true
									if (phoneme==="?"){clause[i].question=true}
									else{clause[i].question=false}
									break
								}

							} 
							//create speech string
							speechString+="1,1,1,_;" //Rule 1

							for (let i = 0; i<clause.length; i++)
							{
								

								var d=(innateDuration[clause[i].phoneme]-clause[i].minDur)*clause[i].duration+clause[i].minDur+clause[i].duration11
								//set duration
								clause[i].duration=d/innateDuration[clause[i].phoneme]
								if (plosive[clause[i].phoneme]) 
								{

									//plosive aspiration rules
									if (
										//allophone rule 3 glottal stop word final t if prior segment is sonorant
										!(clause[i].endWord && clause[i].phoneme==="t" && i>0 && sonorant[clause[i-1].phoneme])
										&&
										//allophone rule 4 a voiceless plosive is not released if the next phone is also a voiceless plosive. example: apt cookie
										!(voicelessPlosive[clause[i].phoneme] && i<clause.length-1 && voicelessPlosive[clause[i+1].phoneme])
									)
									{
										clause[i].phoneme+=";1,1,1,"+clause[i].phoneme+"x" //t -> t/tx
									}	
	
								}	
								if (clause[i].startWord && clause[i].nucleus && clause[i].stress==="1" &&i>0 && (clause[i-1].nucleus))
								{speechString+=".38,1,1,_;"} //Rule 5 glottal stops between word ending in vowel and word starting with stressed vowel
							//	var durationText=Math.abs(Math.floor((1-clause[i].duration)*100)).toString().padStart(2,"0") //get digits after decimal
								
								speechString+=(Math.floor(clause[i].duration*100)/100).toString().replace("0.",".")+","
								//if (durationText[durationText.length-1]=="0")durationText=durationText.slice(0,-1) //removing trailing zero
								/*if (durationText!=="0")
								{
									if (clause[i].duration<1){speechString+="-"+durationText+","}
									if (clause[i].duration>1){speechString+=durationText+","}
								}*/		

								//Pitch Prosody https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4617729/
								//https://pdf.sciencedirectassets.com/272464/1-s2.0-S0095447019X47002/1-s2.0-S0095447019309891/main.pdf
			
								if(clause[i].clauseFinal)
								{
									if (clause[i].question){speechString+="1,2,"}
									else {speechString+="1,-1,"}
								}	 
								else
								{
									if (clause[i].contentWord && clause[i].nucleus && clause[i].stress==="1") 
									{
										speechString+="1,2,"
									}
									else
									{
										speechString+="1,1,"
									}	
								}
								speechString+=clause[i].phoneme+";"
							}
							
							clause=[]

						}


					}

				}
				else //consonant
				{
					phone={duration:1,duration11:0,phoneme:phoneme,stress:segment.replace(/[a-z]+/g,""),minDur:minimumDuration[phoneme], nucleus:false,startWord:false,endWord:false,startPhrase:false,endPhrase:false}
					word.push(phone)
				}
			}
		}
	})	
	return speechString
}


