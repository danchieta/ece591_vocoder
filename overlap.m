function y = overlap(x,win,shift)
%
% This function converts the input row vector, x, into a matrix, y,
% where each column is a windowed version of the input vector,
% windowed by win.
% The windows overlap, starting points are shifted by shift.

winlength = length(win);
cols = ceil(length(x)/shift);
x = x(:)';
x = [x zeros(1,winlength)];
y = zeros(winlength,cols);
for i=0:cols-1
	y(:,i+1) = win.*x(i*shift+1:i*shift+winlength)';
end
