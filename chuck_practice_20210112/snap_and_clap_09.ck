//chuck_practice_20210112
//snap_and_clap.ck

//sound chains


SndBuf rim => dac;
SndBuf clap => dac;

me.dir(-1) + "/audio/tr-09-clap.wav" => clap.read;//load sound file
clap.samples() => clap.pos;
me.dir(-1) + "/audio/tr-09-rim.wav" => rim.read;//load sound file
rim.samples() => rim.pos;

// tempo and counter objects
BPM tempo;
TheCount counter;

while(true){
      Math.random2f(0.3,0.6) => clap.gain;// vary loudness on each clap
      0 => clap.pos;    
      tempo.halfNote => now;
    
}