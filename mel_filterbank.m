function [H, filter_mid] = mel_filterbank(f_index, nfilter)

% this is the triangular function in a _clever_ way to do piecewise functions
% in matlab

% the triangular function middle and right and left boundaries
% the boundaries are relative to the middle 
% e.g. f(x) will be 0 for (x-mid)<left
f_trng = @(x,left,right,mid) (-(x-mid)./left+1).*((x-mid)>left).*((x-mid)<=0)...
	+(-(x-mid)./right+1).*((x-mid)>0).*((x-mid)<=right);

f2mel = @(f) 2595*log10(1+f/700);
mel2f = @(mel) 700*(10.^(mel/2595)-1);

fmel_index = f2mel(f_index);

fmel_max = fmel_index(end);
fmel_min = fmel_index(1);

step = (fmel_max - fmel_min)/(nfilter+1);


filter_left = mel2f((0:nfilter-1)*step);    
filter_mid = mel2f(step+(0:nfilter-1)*step);
filter_right = mel2f(2*step+(0:nfilter-1)*step);

%filter_mid = (filter_left+filter_right)/2;

H = f_trng(f_index,filter_left'-filter_mid', filter_right'-filter_mid',...
	filter_mid');


end
