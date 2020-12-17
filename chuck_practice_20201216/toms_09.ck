//chuck_practice_20201216
//toms_09.ck

[
"tr-09-ht.wav", //0
"tr-09-ht-long.wav", 
"tr-09-ht-long-low.wav", //2 
"tr-09-ht-low.wav", 
"tr-09-lt.wav", //4
"tr-09-lt-long.wav",
"tr-09-lt-long-low.wav", //6
"tr-09-lt-low.wav"
] @=> string tomfiles[];

SndBuf toms[tomfiles.cap()];

for (0 => int i; i < tomfiles.cap(); i++){
  toms[i] => dac;
  me.dir(-1) + "/audio/"+ tomfiles[i] => toms[i].read;//load sound file
  toms[i].samples() => toms[i].pos;
}

// tempo and counter objects
BPM tempo;
TheCount counter;

while(true){
    repeat(8){
      repeat(2){
        Math.random2f(0.4,0.8) => toms[6].gain => toms[0].gain;// vary loudness on each tom
        if (((counter.Measure >=9)&&(counter.Measure <=16)) ||
            ((counter.Measure >=25)&&(counter.Measure <=32))
            ){
          0 => toms[0].pos;
        } else {
          0 => toms[6].pos; }
        tempo.eighthNote=> now;
      }    
    }
}


