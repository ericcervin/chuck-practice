//chuck_practice_20201129
//kick.ck

//sound chain
SndBuf kick => dac;

me.dir(-1) + "/audio/kick_02.wav" => kick.read; //load file

while (true)
    {
    Math.random2f(0.25,0.75) => kick.gain; // random gain between 0.25 and 0.75
    0 => kick.pos;    //reset kick
    0.625::second => now; //advance time one quarter note
    }