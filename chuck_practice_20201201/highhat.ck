//chuck_practice_20201201
//highhat.ck

//sound chain

SndBuf hihat => JCRev jc => Pan2 panda => dac;
0.5 => panda.pan; //pan a bit right

me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;//load file
0 => hihat.rate; //silence hihat

//create BPM & Counter objects
BPM tempo;
TheCount counter;

[
[0,1,0,1,1,1,1,1,0,1,0,1,1,1,1,1], //3 patterns to randomly choose from
[0,0,1,0,0,1,0,0,0,1,0,0,0,1,0,1],
[1,1,1,1,1,0,1,0,1,1,1,1,1,0,1,0]
]@=> int BeatPattern[][];

while(true)
{   
    //play a loop
    
    Math.random2(0,2) => int CurrentPattern; //randomly choose one of three patterns
    for (0 => int beat; beat < 16; beat ++)
    {
        if (counter.Measure%2==0){//in even measures
            Math.random2f(0.1,0.2) => hihat.gain; //vary loudness of each highhat strike
            BeatPattern[CurrentPattern,beat] => hihat.rate; //read rate from currently selected pattern. 0 = silence. 1 = sound;
            0 => hihat.pos;
        }
        tempo.sixteenthNote => now;
    }
}