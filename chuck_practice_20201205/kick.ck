//chuck_practice_20201205
//kick.ck

//sound chain

SndBuf kick => dac;

me.dir(-1) + "/audio/kick_02.wav" => kick.read;//load sound file

// tempo and counter objects
BPM tempo;
TheCount counter;

while(true){
    Math.random2f(0.4,0.8) => kick.gain;// vary loudness on each kick
    0 => kick.pos;
    tempo.quarterNote=> now;
}