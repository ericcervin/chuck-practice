//chuck_practice_20201231
//kick_09.ck

//sound chains

SndBuf kick => dac;
SndBuf kick2 => dac;
SndBuf kick3 => dac;
SndBuf kick4 => dac;

me.dir(-1) + "/audio/tr-09-bd.wav" => kick.read;//load sound file
kick.samples() => kick.pos;
me.dir(-1) + "/audio/tr-09-bd-long.wav" => kick2.read;//load sound file
kick2.samples() => kick2.pos;
me.dir(-1) + "/audio/tr-09-bd-long-low.wav" => kick3.read;//load sound file
kick3.samples() => kick3.pos;
me.dir(-1) + "/audio/tr-09-bd-low.wav" => kick4.read;//load sound file
kick4.samples() => kick4.pos;

// tempo and counter objects
BPM tempo;
TheCount counter;

while(true){
    Math.random2f(0.2,0.4) => kick.gain;// vary loudness on each kick
    0 => kick.pos;
    tempo.quarterNote=> now;

    Math.random2f(0,1.0) => float choice;
    Math.random2f(0.4,0.6) => kick2.gain => kick3.gain => kick4.gain;
    if (choice < 0.33)
        {0 => kick2.pos;}
    else if (choice > 0.33 && choice < 0.66)
        {0 => kick3.pos;}
    else 
        {0 => kick4.pos;}
    tempo.quarterNote=> now;
}