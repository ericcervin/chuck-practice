//chuck_practice_20210112
//reich_thing_1965.ck


// tempo and counter objects
BPM tempo;
TheCount counter;

spork ~ looper("elizabeth_from_knoxville.wav",msToSamples(1750),tempo.halfNote,0.5,160);
2::minute => now;


fun void looper(string file, int start, dur len, float rate, int reps){    
    //msToSamples(start) => int startInSamples;
    
    SndBuf sound => dac;  
    1.5 => sound.gain; 
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    start => sound.pos;
    rate => sound.rate;
    while(reps > 0){
     (len/rate) => now;
      start => sound.pos;
      reps--; 
     }
 }



fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

