//chuck_practice_20210128.ck
//metal_09.ck

[
"tr-09-ch.wav", //0
"tr-09-ch-long.wav", 
"tr-09-oh.wav", //2 
"tr-09-oh-long.wav", 
"tr-09-crash.wav", //4
"tr-09-crash-low.wav",//5
"tr-09-ride.wav", //6
"tr-09-ride-low.wav"//7
] @=> string metalfiles[];

SndBuf metals[metalfiles.cap()];

for (0 => int i; i < metalfiles.cap(); i++){
  metals[i] => dac;
  me.dir(-1) + "/audio/"+ metalfiles[i] => metals[i].read;//load sound file
  metals[i].samples() => metals[i].pos;
}

// tempo and counter objects
BPM tempo;
TheCount counter;

while(true){
        Math.random2f(0.7,1) => metals[5].gain => metals[7].gain; // vary loudness on each
        0 => metals[7].pos;
        tempo.eighthNote=> now;
        
        Math.random2(1,8) => float chance;
        if        (chance == 1){} //nothing
        else if (chance == 2) {0 => metals[5].pos;} //crash
        else {0 => metals[7].pos;} // ride    
        tempo.eighthNote=> now;
      }    
      



