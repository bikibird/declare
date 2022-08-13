pronouncing.syllabify=function(p)
{
	//https://en.wikipedia.org/wiki/English_phonology#Syllable_structure
	var onsets="HH,L,R,M,N,NG,CH,JH,DH,F,S,SH,ZH,K,P,T,G,B,D,TH,V,Z,W,Y,PL,BL,KL,GL,PR,BR,TR,DR,KR,GR,TW,DW,GW,KW,PW,FL,SL,THL,SHL,VL,FR,THR,SHR,HW,SW,THW,VW,PY,BY,TY,DY,KY,GY,MY,NY,FY,VY,THY,SY,ZY,HY,LY,SP,ST,SK,SM,SN,SF,STH,SPL,SKL,SPR,STR,SKR,SKW,SPY,STY,SKY,SNY,SFR"
	var nuclei="AA,AE,AH,AO,AW,AY,EH,ER,EY,IH,IY,OW,OY,UH,UW"
	var syllable=[]
	var onsetCluster=""
	var onset=[]
	var pronounciation=[]
	var stress=""
	p.split(" ").forEach(phoneme=>
	{
		stress=phoneme.replace(/[A-Z]+/g,"")
		phoneme=phoneme.replace(/\d+/g, '')
		if (onsets.includes(onsetCluster+phoneme))
		{
			onsetCluster+=phoneme
			onset.push(phoneme)
		}
		else
		{
			if (nuclei.includes(phoneme))
			{
				syllable=syllable.concat(onset)
				onset=[]
				onsetCluster=""
				syllable.push(phoneme+stress)
				pronounciation.push(syllable) //inconplete if coda found later...
				syllable=[] 
			}
			else //coda found
			{
				pronounciation[pronounciation.length-1]=pronounciation[pronounciation.length-1].concat(onset) //coda
				onsetCluster=phoneme
				onset=[phoneme]
				syllable=[]
			}
		}	
	})
	//add last coda
	if (onsetCluster !== "")pronounciation[pronounciation.length-1]=pronounciation[pronounciation.length-1].concat(onset) 
	return pronounciation
}

declare=function(passage)
{

	var innateDuration={aa:1320,ae:1270,ah:660,ao:1320,aw:720,ay:690,eh:830,er:740,ey:1040,ih:720,iy:880,ow:1210,oy:1540,uh:880,uw:1170,hh:440,l:440,r:440,hh:440,m:390,n:360,ng:440,ch:385,jh:385,dh:275,f:660,s:690,sh:690,zh:385,k:360,p:470,t:360,g:360,b:440,d:360,th:606,v:330,z:410,w:440,y:440}

	var minimumDuration={aa:440,ae:330,ah:275,ao:440,aw:550,ay:495,eh:330,er:550,ey:385,ih:220,iy:275,ow:385,oy:606,uh:275,uw:330,hh:110,l:220,r:165,m:330,n:193,ng:275,ch:275,jh:275,dh:165,f:330,s:275,sh:275,zh:220,k:275,p:275,t:220,g:275,b:275,d:220,th:220,v:220,z:220,w:330,y:220}	
	var consonants="hh,l,r,m,n,ng,ch,jh,dh,f,s,sh,zh,k,p,t,g,b,d,th,v,z,w,y"
	var stops="ch,b,d,g,jh,k,p,t"
	var liquids="l,r"
	var nasals="m,n,ng"
	var clauses=[]
	var words=[]
	var word={spelling:"",syntax:" ",pronounciations:[]} 
	
	passage=passage.toLowerCase().replace(/\s+/g, ' ').trim().replace(" -","-").replace("- ","-").replace(" ,",",").replace(", ",",").replace(" .",".").replace(". ",".").replace(" ?","?").replace("? ","?")+"*"
	function update(char)
	{
		word.prosody=char
		words.push(word)
		return {spelling:"",prosody:" ",pronounciations:[]} 
	}
	for (let i = 0; i < passage.length; i++)
	{
	
		switch (passage[i]) 
		{
			case ".":
				word=update(".")
				break
				
			case "?":
				word=update("?")
				break  
				
			case ",":
				word=update(",")
				break
			case "-":
				word=update("-")
				break
			case " ":
				word=update(" ")
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
	var clause=[]
	words.forEach(word=>
	{
		word.pronounciations=word.pronounciations.concat(pronouncing.phonesForWord(word.spelling))
		var onset=true,nucleus=false,rime=false,coda=false
		word.pronounciations=word.pronounciations.map(p=>pronouncing.syllabify(p).map((syllable,index)=>
		{
			onset=true,nucleus=false,rime=false,coda=false
			var lastSyllable=syllable.length-1
			syllable=syllable.map(phone=>
			{
				var stress=phone.replace(/[A-Z]+/g,"")
				var phoneme=phone.replace(/\d+/g, '').toLowerCase()
				var prosody=0  
				if (index===lastSyllable && (word.prosody==="," || word.prosody==="." || word.prosody==="?")){prosody=3}
				else
				{
					if (index===lastSyllable && word.prosody==="-" ){prosody=2}
					else
					{
						if (index===lastSyllable)prosody=1
					}
				}	
				if (stress >= "0")
				{
					//if (index>0) 
					onset=false
					nucleus=true
					rime=true
					coda=false
				}
				else
				{
					if (nucleus) coda=true
				}
				return {duration:1,phoneme:phoneme,stress:stress,prosody:prosody,onset:onset,nucleus:nucleus,coda:coda,rime:rime}
			})
			return syllable
		}))
		clause.push(word)
		if (word.prosody==="." || word.prosody==="?" || word.prosody==="," || word.prosody==="*")
		{
			clauses.push(clause)
			clause=[]
		}
	})
	var saying=""
	clauses.forEach(clause=>
	{
		//Rule 1 add 200 ms pause for each clause
		saying+="-/" 
		clause.forEach(word=>
		{	
			word.pronounciations.forEach(p=>
			{
				p.forEach((syllable,syllableIndex)=>
				{
					
					syllable.forEach((phone,phoneIndex)=>  //for each phone in last syllable
					{
						//Rule 2 lengthen rime of clause final syllable by 140%
						if(phone.prosody===3 && phone.rime) phone.duration*=1.4
						
						//Rule 3 shorten non-phrase final syllable nucleus by 60%. 
						if (phone.nucleus && phone.prosody < 2 ) phone.duration*=.6

						//Rule 3 Lengthen phrase final coda l,r,m,n,ng by 140%
						if (phone.coda && phone.prosody === 2 && (liquids.includes(phone.phoneme)||nasals.includes(phone.phoneme))) phone.duration*=1.4

						//Rule 4 Shorten non word final syllables by 85%
						if (phone.prosody === 0 ) phone.duration*=.85

						//Rule 5 shorten polysyllabic words by 80%
						if (p.length>1) phone.duration*=.8

						//Rule 6 shorten non initial consonant in word by 85%
						if ((syllableIndex !== 0 || phoneIndex !== 0) && consonants.includes(phone.phoneme)) phone.duration*=.85
						
						//Rule 7 Unstress Syllables: first or last syllable shortened 70%, middle syllables shortened 50%
					})
					
				})
				
			})
		})
	})	
	//Generate Speako-8 string
	
	clauses.forEach(clause=>
	{	
		clause.forEach(word=>
		{
			word.pronounciations.forEach(p=>
			{
				p.forEach(syllable=>syllable.forEach(phone=>
				{
					var {phoneme,duration,stop_consonant,stress}=phone
					var d=innateDuration[phoneme]*duration
					d=d>minimumDuration[phoneme]?d:(stress=="0"?minimumDuration[phoneme]/2:minimumDuration[phoneme])
					if (stop_consonant)
					{
						var duration=d/1100
					}
					else
					{
						var duration=d/innateDuration[phoneme]
					}
					
					if (duration!==0)
					{ 
						durationText=Math.abs(Math.floor((1-duration)*100)).toString()//get digits after decimal
						if (durationText[duration.length-1]==0)durationText=durationText.slice(0,-1) //removing trailing zero
						if (duration<1){saying+="-1."+durationText+"/"}
						if (duration>1){saying+="1."+durationText+"/"}
					}
					if (phone.stop_consonant) saying+="_/"
					saying+=phone.phoneme+"/"
				}))
			
			})
		})
	})
	return saying=saying.slice(0,-1).toLowerCase()
}