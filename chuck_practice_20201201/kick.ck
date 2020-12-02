//chuck_practice_20201201
//kick.ck

//sound chain

SndBuf kick => JCRev jc => dac;

me.dir(-1) + "/audio/kick_02.wav" => kick.read;//load sound file



//create BPM object
BPM tempo;


while(true)
{   
    //play a loop
    
    for (0 => int beat; beat < 4; beat ++)// vary loudness on each kick
    {
        Math.random2f(0.2,0.5) => kick.gain;
        0 => kick.pos;
        tempo.quarterNote => now;
    }
}