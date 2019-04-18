clear;clc;
[sig, fs] = audioread('00002.wav'); %input to vocoder with sampling frequency
N = 50; %integer value for number of channels 

[spectrum, filtered_spectrum, filtered_index, t_index] = channel_vocoder(sig, fs, 60e-3,22);

[nfft, ~] = size(spectrum);
f_index = linspace(0,fs/2,nfft);

figure
plot(f_index, spectrum(:,2))

figure
plot(filtered_index, filtered_spectrum(:,2))

y=ones(13);


% this is the page where the slide figure came from
% https://haythamfayek.com/2016/04/21/speech-processing-for-machine-learning.html