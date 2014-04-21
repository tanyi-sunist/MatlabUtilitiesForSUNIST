%% get original settings
hAx = gca;
D=get(hAx,'Children');
y0=get(D,'YData');
t=get(D,'XData');
ylabel1= get(hAx,'YLabel');
ylabel2 = get(ylabel1,'String');
fonts= get(hAx,'FontSize');
fontn = get(hAx,'FontName');
xlim1 = get(hAx,'XLim');
ylim1 = get(hAx,'YLim');
ytick1 = get(hAx,'YTick');

fs = 500;             %#sampling rate
f0 = 20;                %#notch frequency
fn = fs/2;              %#Nyquist frequency
%% notch filter
% freqRatio = f0/fn;      %#ratio of notch freq. to Nyquist freq.
% notchWidth = 0.05;       %#width of the notch
% %#Compute zeros
% zeros = [exp( sqrt(-1)*pi*freqRatio ), exp( -sqrt(-1)*pi*freqRatio )];
% %#Compute poles
% poles = (1-notchWidth) * zeros;
% %figure;
% %zplane(zeros.', poles.');
% b = poly( zeros ); %# Get moving average filter coefficients
% a = poly( poles ); %# Get autoregressive filter coefficients

%figure;
%freqz(b,a,32000,fs)
%#filter signal x
% figure;
% plot(t,y0,'r');hold on;
%% butter filter
Wn = 12/fn;                   % Normalozed cutoff frequency        
[b,a] = butter(9,Wn,'low');  % Butterworth filter

%% smooth
%  y=smoothn(y0);
%% redraw graph
 y = filter(b,a,y0);
plot(t,y);
xlim(hAx,xlim1);
ylim(hAx,ylim1);
ylabel(hAx,ylabel2,'FontSize',fonts,'FontName',fontn);
set(hAx,'FontSize',fonts,'FontName',fontn);
set(hAx,'YTick',ytick1);
% set(hAx,'XTickLabel',[]);
