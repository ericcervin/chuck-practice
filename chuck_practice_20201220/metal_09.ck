//chuck_practice_20201220
//metal_09.ck

[
"tr-09-ch.wav", //0
"tr-09-ch-long.wav", 
"tr-09-oh.wav", //2 
"tr-09-oh-long.wav", 
"tr-09-crash.wav", //4
"tr-09-crash-low.wav",
"tr-09-ride.wav", //6
"tr-09-ride-low.wav"
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
        Math.random2f(0.4,0.8) => metals[0].gain => metals[2].gain; // vary loudness on each
        Math.random2f(0.0,1.0) => float chance;
        if (chance > 0.125){ 
          0 => metals[0].pos;
        } else {
          0 => metals[2].pos;
        }
            
        tempo.eighthNote=> now;
      }    
      



