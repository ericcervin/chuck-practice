//chuck_practice_20201212
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
    Math.random2f(0.0,1.0) => float chance;
    if (chance > 0.125){
      Math.random2f(0.2,0.8) => rim.gain;// vary loudness rimshot
      0 => rim.pos;
    } else {
      Math.random2f(0.4,0.8) => clap.gain;// vary loudness on each snare
      0 => clap.pos;    
    }
    tempo.sixteenthNote => now;
    
}