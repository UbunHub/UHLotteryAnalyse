//
//  WavaSever.hpp
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/5/13.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#ifndef WavaSever_hpp
#define WavaSever_hpp
#include <stdio.h>

class WavaSever{

    static const int duration = 10;
    static const int sampleRate = 44100;
    static const int numSamples = duration * sampleRate;
private: double sample[numSamples];

    /**
     * 音频信号的频率，红外需要38kHz的频率。
     * 手机输出的频率一般在人耳听力中的
     * 20~20kHz范围内，所以这里仅仅取最高频率。
     * 该频率是指最终的信号的频率，采样率仅存在于数字音频信号生成过程中的一个概念。
     */
private: double freqOfTone = 200000; // hz  200000=>20khz(50us) 最高
    private : double generatedSnd[2 * numSamples];
    /** Data "1" 高电平宽度 */
    private : float          INFRARED_1_HIGH_WIDTH = 0.56f ;
    /** Data "1" 低电平宽度 */
    private : float           INFRARED_1_LOW_WIDTH = 1.69f;  // 2.25 - 0.56
    /** Data "0" 高电平宽度 */
    private : float          INFRARED_0_HIGH_WIDTH = 0.56f ;
    /** Data "0" 低电平宽度 */
    private : float           INFRARED_0_LOW_WIDTH = 0.565f ;// 1.125-0.56
    /** Leader code 高电平宽度 */
    private : float INFRARED_LEADERCODE_HIGH_WIDTH = 9.0f  ;
    /** Leader code 低电平宽度 */
    private : float  INFRARED_LEADERCODE_LOW_WIDTH = 4.50f ;
    /** Stop bit 高电平宽度 */
    private : float    INFRARED_STOPBIT_HIGH_WIDTH = 0.56f ;
};



#endif /* WavaSever_hpp */
