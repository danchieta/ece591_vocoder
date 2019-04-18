function [mag_sig_overlap_fft, mag_filtered, f_index_filt, t_index] = channel_vocoder(sig, fs, win_dur, N)
%The purpose of this funciton is to return a vocoded signal and the center
%frequencies of the vocoded signal when given an input and a number of
%channels.
%   Inputs: sig is the signal in, such as a .wav file. fs is the sampling 
%   frequency of the signal read from audioread. N is the number of
%   channels, a positive integer value. 
%   Outputs: voco is the vocoded signal output, fc is the center
%   frequencies of the vocoded signal. 

% win_dur = 60;  %msec
shift_percent = 50; % % of win_dur

% max_mel = 2595*log10(1 + (fs/2) * 700); %maximum mel value
% delta_mel = max_mel/(N+1); 
% melvect = (1:N) * delta_mel;

winlen = ceil(win_dur*fs);
shift = ceil(winlen * shift_percent / 100);

fftlen = 2^(ceil(log2(winlen)));
% f_vect = ((10.^(melvect/2595)) - 1)/700; %gives center frequencies
% delta_f = fs/fftlen;    %change between center frequencies
% fft_freq = [0:delta_f:fs/2];

sig_overlap = overlap(sig, hamming(winlen), shift);

sig_overlap_fft = fft(sig_overlap, fftlen);
sig_overlap_fft = sig_overlap_fft(1:fftlen/2,:);
mag_sig_overlap_fft = abs(sig_overlap_fft);

[~, ncol] = size(sig_overlap);

t_index = (1:ncol)*shift/fs;
f_index = linspace(0, fs/2, fftlen/2);

[H, f_index_filt] = mel_filterbank(f_index,N);

mag_filtered = H*mag_sig_overlap_fft;


end

