//chuck_practice_20201202
//kick.ck

//sound chain

SndBuf kick => dac;

me.dir(-1) + "/audio/kick_02.wav" => kick.read;//load sound file

// tempo and counter objects
BPM tempo;
TheCount counter;

repeat(8){//8 beats every runtime
    Math.random2f(0.4,0.8) => kick.gain;// vary loudness on each kick
    0 => kick.pos;
    if (counter.Measure < 30 )
        {tempo.eighthNote=> now;}//8 kicks per measure for most of piece
        else 
        {tempo.quarterNote=> now;}//only four kicks in final measure
}