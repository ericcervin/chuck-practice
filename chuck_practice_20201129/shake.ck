//chuck_practice_20201129
//shake.ck

//sound chain
Shakers shak1 => dac;
Shakers shak2 => dac;

1 => shak1.gain;//set shaker gain
6 => shak1.preset;//set shaker preset

1 => shak2.gain;//set shaker gain
7 => shak2.preset;//set shaker preset

spork ~ shakeShack1(); // start shak1 pattern
0.1::second => now; //2nd pattern offset
spork ~ shakeShack2(); // start shak2 pattern

fun void shakeShack1(){
    repeat(Math.random2(1,3)){
        1 => shak1.noteOn;
        0.15::second => now;
    }
}

fun void shakeShack2(){
    repeat(Math.random2(1,3)){
        1 => shak2.noteOn;
        0.15::second => now;
    }
}

0.625::second => now;