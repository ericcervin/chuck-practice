//chuck_practice_20201201
//shake.ck

//sound chain
Shakers shak1 => JCRev jc => Pan2 panda1 => dac;
Shakers shak2 => JCRev jc2 => Pan2 panda2 => dac;

//create BPM & Counter objects
BPM tempo;
TheCount counter;


1 => shak1.gain;//set shaker gain
6 => shak1.preset;//set shaker preset
-1.0 => panda1.pan; //pan shaker hard left

1 => shak2.gain;//set shaker gain
7 => shak2.preset;//set shaker preset
1.0 => panda2.pan;//pan shaker hard right

while(true)
{
    if (counter.Measure%2!=0){//in odd measures
        spork ~ shakeShack1(); // start shak1 pattern
        0.1::second => now; //2nd pattern offset
        spork ~ shakeShack2(); // start shak2 pattern
    }
    tempo.quarterNote => now;
}
fun void shakeShack1(){
    repeat(Math.random2(1,6)){//play shaker between one and six times
        1 => shak1.noteOn;
        0.15::second => now;
    }
}

fun void shakeShack2(){
    repeat(Math.random2(1,6)){//play shaker between one and six times
        1 => shak2.noteOn;
        0.15::second => now;
    }
}