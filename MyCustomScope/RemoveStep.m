function y1=RemoveStep(y0,t,after)
if size(y0,1) < size(y0,2)
    y0=y0';
end
y0=y0(1:min(length(y0),length(t)));
t=t(1:length(y0));
[~,afterIndex]=min(abs(t-after));
dy0=smooth(diff(y0),100);
ddy0=diff(smooth(dy0,50));
[~,startIndex]=min(ddy0(afterIndex:end));
[~,finishIndex]=max(ddy0(afterIndex:end));
startIndex = startIndex+afterIndex;
finishIndex = finishIndex+afterIndex;
% [~,startIndex]=min(abs(t-start));
% [~,finishIndex]=min(abs(t-finish));
% tail = mean(y0(t>max(t)-tailLength));
% delta = error*(max(y0(startIndex:end))-tail);
% lastStepIndex =max(t(y0-tail>delta));
% [~,finishIndex] = min(abs(t-lastStepIndex));
step=(1:finishIndex-startIndex)*y0(finishIndex)/(finishIndex-startIndex);
y0(finishIndex+1:end)=y0(finishIndex+1:end)-y0(finishIndex);
y0(startIndex+1:finishIndex,1)=y0(startIndex+1:finishIndex)-step';
y1=y0;
