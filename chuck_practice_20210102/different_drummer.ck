//chuck_practice_20210102
//different_drummer.ck

// tempo and counter objects
BPM tempo;
TheCount counter;

["tr-09-bd.wav",//0
"tr-09-bd-long.wav",
"tr-09-bd-long-low.wav",
"tr-09-bd-low.wav",
"tr-09-ch.wav",//4
"tr-09-ch-long.wav",
"tr-09-clap.wav",
"tr-09-crash.wav",
"tr-09-crash-low.wav",//8
"tr-09-ht.wav",
"tr-09-ht-long.wav",
"tr-09-ht-long-low.wav",
"tr-09-ht-low.wav",
"tr-09-lt.wav",
"tr-09-lt-long.wav",
"tr-09-lt-long-low.wav",
"tr-09-lt-low.wav",
"tr-09-mt.wav",
"tr-09-mt-long.wav",
"tr-09-mt-long-low.wav",
"tr-09-mt-low.wav",//20
"tr-09-oh.wav",
"tr-09-oh-long.wav",
"tr-09-ride.wav",
"tr-09-ride-low.wav",
"tr-09-rim.wav",
"tr-09-sd.wav",
"tr-09-sd-low.wav",
"tr-09-sd-snappy.wav",
"tr-09-sd-snappy-low.wav"] @=> string drum_files[];

drum_files.size() => int drum_count;
Event happening[drum_count];

for (0 => int i; i < drum_count; i++){
    spork ~ drum_buff(happening[i],drum_files[i], 0, 500, 0.8);
    }   

    
[[5 , 0, 7, 4,11, 6, 9,15,10, 1, 3,14,13, 2, 8,12], //P
 [11, 0, 9,12, 5,10, 7, 1, 6,15,13, 2, 3,14, 8, 4], //I
 [12, 8, 2,13,14, 3, 1,10,15, 9, 6,11, 4, 7, 0, 5], //R
 [ 4, 8,14, 3, 2,13,15, 6, 1, 7,10, 5,12, 9, 0,11]  //IR
    ] @=> int drum_rows[][];

0 => int i;
0 => int row_choice;
    
while(true){
    i % 16 => int step;
    
    if       (counter.Measure == 9){1 => row_choice;}
    else if  (counter.Measure == 17){0 => row_choice;}
    else if  (counter.Measure == 25){1 => row_choice;}
        
    
    //<<<i, i % 16,drum_row[i % 16]>>>;
    if (counter.Measure < 33){
      if (drum_rows[row_choice][step] < 12){
        happening[drum_rows[row_choice][step] + 9].signal();//just toms
      }
    }
    tempo.sixteenthNote => now;
    i + 1 => i;   
    }

    
fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

fun void drum_buff(Event anEvent, string file, int start, int len, float rate){
    SndBuf sound  => dac;
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    rate => sound.rate;
    sound.samples() => sound.pos;
    0.8 => sound.gain;
    
    
    while( true )
    {
      anEvent => now;
   
      msToSamples(start) => sound.pos;
      len::ms=>now;
      sound.samples() => sound.pos;
      
    }
 }