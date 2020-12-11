//chuck_practice_20201210
//snare.ck

//sound chains

SndBuf snare => dac;
SndBuf snare2 => dac;
SndBuf snare3 => dac;
SndBuf snare4 => dac;

me.dir(-1) + "/audio/tr-09-sd.wav" => snare.read;//load sound file
snare.samples() => snare.pos;
me.dir(-1) + "/audio/tr-09-sd-snappy.wav" => snare2.read;//load sound file
snare2.samples() => snare2.pos;
me.dir(-1) + "/audio/tr-09-sd-snappy-low.wav" => snare3.read;//load sound file
snare3.samples() => snare3.pos;
me.dir(-1) + "/audio/tr-09-sd-low.wav" => snare4.read;//load sound file
snare4.samples() => snare4.pos;

// tempo and counter objects
BPM tempo;
TheCount counter;

while(true){
    tempo.quarterNote=> now;
    Math.random2f(0.4,0.8) => snare.gain;// vary loudness on each snare
    0 => snare.pos;
    tempo.halfNote=> now;
    

    Math.random2f(0,1.0) => float choice;
    Math.random2f(0.4,0.8) => snare2.gain => snare3.gain => snare4.gain;
    if (choice < 0.33)
        {0 => snare2.pos;}
    else if (choice > 0.33 && choice < 0.66)
        {0 => snare3.pos;}
    else 
        {0 => snare4.pos;}
    tempo.quarterNote=> now;
}