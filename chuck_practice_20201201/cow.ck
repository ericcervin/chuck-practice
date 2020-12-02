//chuck_practice_20201201
//cow.ck

//sound chain
SndBuf cow => JCRev jc => Pan2 panda => dac;
-0.5 => panda.pan; //pan a bit left

me.dir(-1) + "/audio/cowbell_01.wav" => cow.read;//load sound file

//create BPM object
BPM tempo;


while(true)
{   
    //play a loop
    
    for (0 => int beat; beat < 4; beat ++)
    {
        Math.random2f(0.1,0.3) => cow.gain; // vary loudness on each strike of bell
        0 => cow.pos;
        tempo.halfNote => now;
    }
}