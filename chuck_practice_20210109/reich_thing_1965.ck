//chuck_practice_20210109
//reich_thing_1965.ck

spork ~ looper("elizabeth_from_knoxville.wav",0,1782,1,1);
2000::ms => now;

repeat(2){
  spork ~ looper("elizabeth_from_knoxville.wav",1750,900,0.9,16);
  spork ~ looper("elizabeth_from_knoxville.wav",1750,900,1.0,16);
  14400::ms => now;

  spork ~ looper("elizabeth_from_knoxville.wav",6500,2000,0.9,8);
  spork ~ looper("elizabeth_from_knoxville.wav",6500,2000,1.0,8);
  16000::ms => now;
}
500::ms => now;
spork ~ looper("elizabeth_from_knoxville.wav",26500,1250,1.0,1);
3000::ms => now;


fun void looper(string file, int start, int len, float rate, int reps){    
    msToSamples(start) => int startInSamples;
    
    SndBuf sound => dac;  
    1.5 => sound.gain; 
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    startInSamples => sound.pos;
    rate => sound.rate;
    while(reps > 0){
     (len/rate)::ms => now;
      startInSamples => sound.pos;
      reps--; 
     }
 }



fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

