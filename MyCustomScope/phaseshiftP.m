function deltPhi=phaseshiftP(t,s1,s2)
% PHASESHIFT return the phase shift between two signals by comparing 
%   the time difference of interpolated zero-crossing points. This
%   function requires crossing.m written by Steffen Brueckner.
%
%   Usage: [time, deltT, deltPhi] = phaseshift(t, s1, s2)
%   Parameters description:
%   time£º the time stamp of deltT and deltPhi
%   deltT: the time differences between the zero-crossing points in signal
%           s1 and s2. For each zero-crossing points in s1, this function
%           will find the neareast zero-crossing point in s2 and then
%           return the time differences in deltT.
%   deltPhi: deltT / (the period between two neareast zero-crossing points
%           in s1) * pi.
%   t: the time base of signal s1 and s2
%   s1: signal s1
%   s2: signal s2
%
% Tan Yi, 2013-03-01
%
% Copyright (c) Tan Yi, 2013
% tanyi@sunist.org
[~, t1] = crossing(s1,t);
[~, t2] = crossing(s2,t);
%start = 1;
size1 = length(t1);
%size2 = length(t2);
deltT = zeros(size(t1));
deltPhi = zeros(size(t1));
time = t1;
for i=1:size1-1
%     delt = inf;
%     if t1(i) > 6
%         
%     end
%     for j=start:size2-1
%         d = abs(t2(j)-t1(i));
%         if d < delt
%             tempS1 = s1(t1(i+1)>t>t1(i));
%             tempS2 = s2(t2(j+1)>t>t2(j));
%             if ~isempty(tempS1) && ~isempty(tempS2)
%                 if (tempS1(1) > 0 && tempS2(1) > 0) || (tempS1(1) < 0 && tempS2(1) < 0)
%                     delt = d;
%                 end
%             end
%         else
%             break;
%         end
%     end
    deltT(i) = min(abs(t2-t1(i))); %delt;
    deltPhi(i) = deltT(i)/(t1(i+1)-t1(i))*180;
end

end