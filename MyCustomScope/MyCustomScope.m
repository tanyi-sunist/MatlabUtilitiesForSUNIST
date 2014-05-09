function varargout = MyCustomScope(varargin)
% MYCUSTOMSCOPE M-file for MyCustomScope.fig
%      MYCUSTOMSCOPE, by itself, creates a new MYCUSTOMSCOPE or raises the existing
%      singleton*.
%
%      H = MYCUSTOMSCOPE returns the handle to a new MYCUSTOMSCOPE or the handle to
%      the existing singleton*.
%
%      MYCUSTOMSCOPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYCUSTOMSCOPE.M with the given input arguments.
%
%      MYCUSTOMSCOPE('Property','Value',...) creates a new MYCUSTOMSCOPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyCustomScope_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyCustomScope_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyCustomScope

% Last Modified by GUIDE v2.5 24-Sep-2011 07:07:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyCustomScope_OpeningFcn, ...
                   'gui_OutputFcn',  @MyCustomScope_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before MyCustomScope is made visible.
function MyCustomScope_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyCustomScope (see VARARGIN)

% Choose default command line output for MyCustomScope
handles.output = hObject;

% Update handles structure
handles.hFigure=figure;
set(handles.hFigure,'Visible','off');

[y,x]=makeValueString(handles);
set(handles.editDataString,'String',y);
set(handles.editTimeString,'String',x);

guidata(hObject, handles);
global currentTitle currentColor
currentTitle='';
currentColor=6;
% UIWAIT makes MyCustomScope wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = MyCustomScope_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


function checkChannelNo(handles)
ch = get(handles.editChannel,'String');
if length(ch) < 2
    set(handles.editChannel,'String',strcat('0',ch));
else
    switch get(handles.pmDAQ, 'Value')
        case 1
            if str2double(ch)>96
                ch=int2str(96);
            end
        case 2
            if str2double(ch)>96
                ch=int2str(96);
            end
        case 3
            if str2double(ch)>96
                ch=int2str(96);
            end
        case 4
            if str2double(ch)>16
                ch=int2str(16);
            end
        case 5
            if str2double(ch)>16
                ch=int2str(16);
            end
        case 6
            if str2double(ch)>31
                ch=int2str(31);
            end
    end
    set(handles.editChannel,'String',ch);
end

function updateValueString(handles,newStringY,newStringX)
sPreDataString=get(handles.editDataString,'String');
sPreTimeString=get(handles.editTimeString,'String');
if ~isempty(getKernelString(sPreDataString))
    set(handles.editDataString,'String', ...
        strrep(sPreDataString,getKernelString(sPreDataString), ...
        getKernelString(newStringY)));
else
    set(handles.editDataString,'String',newStringY);
end
if ~isempty(getKernelString(sPreTimeString))
    set(handles.editTimeString,'String', ...
        strrep(sPreTimeString,getKernelString(sPreTimeString), ...
        getKernelString(newStringX)));
else
    set(handles.editTimeString,'String',newStringX);
end

function SelectTheSame(listbox,handles)
L = get(listbox,{'String','Value'});  % Get the users choice.

set(handles.lbDataStrings,'Value',L{2});
set(handles.lbTimeStrings,'Value',L{2});
set(handles.lbYLabels,'Value',L{2});
set(handles.lbXLabels,'Value',L{2});
set(handles.lbYMins,'Value',L{2});
set(handles.lbYMaxes,'Value',L{2});
set(handles.lbMarkers,'Value',L{2});
set(handles.lbDrawTypes,'Value',L{2});

L = get(handles.lbDataStrings,{'String','Value'});  % Get the users choice.
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
set(handles.editDataString,'String', strValue);

L = get(handles.lbTimeStrings,{'String','Value'});  % Get the users choice.
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
set(handles.editTimeString,'String', strValue);

L = get(handles.lbYLabels,{'String','Value'}); 
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
set(handles.editYLabel,'String', strValue);

L = get(handles.lbXLabels,{'String','Value'}); 
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
set(handles.editXLabel,'String', strValue);

L = get(handles.lbYMins,{'String','Value'}); 
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
set(handles.editYMin,'String', strValue);

L = get(handles.lbYMaxes,{'String','Value'}); 
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
set(handles.editYMax,'String', strValue);

L = get(handles.lbMarkers,{'String','Value'}); 
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
if strcmp(strValue,'null')
    strValue='';
end
set(handles.editMarker,'String', strValue);

L = get(handles.lbDrawTypes,{'String','Value'}); 
if iscell(L{1})
    strValue = L{1}{L{2}};
else
    strValue = L{1};
end
set(handles.editDrawType,'String', strValue);

function kernelString=getKernelString(strValue)
% get the first 'rawdata:acq196_174:input_01' from
% smooth(data('rawdata:acq196_174:input_01'),20)
start = findstr(strValue,'rawdata:');
if ~isempty(start)
    % the first ')' after 'rawdata:'
    stop=findstr(strValue(start(1):length(strValue)),')'); 
    if ~isempty(stop)
        kernelString=strValue(start(1):stop(1)+start(1)-1);
        % remove the last non-numeric character
        if ~isnumeric(kernelString(1,length(kernelString)))
            kernelString=kernelString(1,1:length(kernelString)-1);
        end
    else
        kernelString = [];
    end
else
    kernelString = [];
end
function [yString,xString]=makeValueString(handles)
valueString = 'rawdata:';
timeSuffixString = '';
switch get(handles.pmDAQ, 'Value')
    case 1
        valueString=strcat(valueString,'acq196_174:input_');
        timeSuffixString = '*1e3';
    case 2
        valueString=strcat(valueString,'acq196_176:input_');
        timeSuffixString = '*1e3';
    case 3
        valueString=strcat(valueString,'acq196_395:input_');
        timeSuffixString = '*1e3';
    case 4
        valueString=strcat(valueString,'acq216_260:input_');
        timeSuffixString = '*1e3';
    case 5
        valueString=strcat(valueString,'acq216_264:input_');
        timeSuffixString = '*1e3';
    case 6
        valueString=strcat(valueString,'wlyxz:CH_');
        timeSuffixString = '*0.5e-3';
end
valueString=strcat(valueString,get(handles.editChannel, 'String')); 
yString=strcat('data(''',valueString,''')');
xString=strcat('data(''dim_of(',valueString,')'')',timeSuffixString);

function pbAdd_Callback(hObject, eventdata, handles)
AddValue(handles.lbDataStrings,handles.editDataString);
AddValue(handles.lbYLabels,handles.editYLabel);
AddValue(handles.lbXLabels,handles.editXLabel);
AddValue(handles.lbYMins,handles.editYMin);
AddValue(handles.lbYMaxes,handles.editYMax);
AddValue(handles.lbTimeStrings,handles.editTimeString);
AddValue(handles.lbMarkers,handles.editMarker);
AddValue(handles.lbDrawTypes,handles.editDrawType);

function AddValue(listbox,edit)
oldstr = get(listbox,'str'); % The string as it is now.
addstr = {get(edit,'String')}; % The string to add to the stack.
if isempty(addstr{1})
    addstr{1}='null';
end
% The order of the args to cat puts the new string either on top or bottom.
if ~isempty(oldstr)
    if iscell(oldstr)
        set(listbox,'str',{addstr{:},oldstr{:}});  % Put the new string on top -OR-
    else
        set(listbox,'str',{addstr{:},oldstr});  % Put the new string on top -OR-
    end
else
    set(listbox,{'str','Value'},{addstr{:},1});
end

function pbRemove_Callback(hObject, eventdata, handles)
RemoveValue(handles.lbDataStrings)
RemoveValue(handles.lbYLabels)
RemoveValue(handles.lbXLabels)
RemoveValue(handles.lbYMins)
RemoveValue(handles.lbYMaxes)
RemoveValue(handles.lbTimeStrings)
RemoveValue(handles.lbMarkers);
RemoveValue(handles.lbDrawTypes);

function RemoveValue(listbox)
L = get(listbox,{'String','Value'});  % Get the users choice.

% We need to make sure we don't try to assign an empty string.
if ~isempty(L{1})
    if ~iscell(L{1})
        L{1} = [];
    else
        L{1}(L{2}(:)) = [];  % Delete the selected strings.
    end
    set(listbox,'string',L{1},'val',min(L{2},length(L{1}))) % Set the new string.
end

function pbUpdate_Callback(hObject, eventdata, handles)
UpdateValue(handles.lbDataStrings,handles.editDataString);
UpdateValue(handles.lbYLabels,handles.editYLabel);
UpdateValue(handles.lbXLabels,handles.editXLabel);
UpdateValue(handles.lbYMins,handles.editYMin);
UpdateValue(handles.lbYMaxes,handles.editYMax);
UpdateValue(handles.lbTimeStrings,handles.editTimeString);
UpdateValue(handles.lbMarkers,handles.editMarker);
UpdateValue(handles.lbDrawTypes,handles.editDrawType);

function UpdateValue(listbox,edit)
L = get(listbox,{'String','Value'});  % Get the users choice.
% We need to make sure we don't try to assign an empty string.
%if ~isempty(L{1})
    if iscell(L{1})
        L{1}{L{2}} = (get(edit,'String'));  % Delete the selected strings.
    else
        L{1} = get(edit,'String');
    end
    set(listbox,'string',L{1},'val',L{2}) % Set the new string.
%end

function ChangeSize(handles)
figure(handles.hFigure);
pos=get(gcf,'OuterPosition');
width=str2double(get(handles.editWidth,'String'));
height=str2double(get(handles.editHeight,'String'));
set(gcf,'OuterPosition',[pos(1),pos(2),width, height]);

function pbPlot_Callback(hObject, eventdata, handles)
global currentTitle currentColor currentShotno
if strcmp(get(handles.pbConnect, 'String'),'Disconnect')
    shotno = str2double(get(handles.editShotNO, 'String'));
    if shotno < 0    % the input shot no is an offset value like '-1'
      shotno = mdsopen('sunist',0) + shotno;
    end
    shotno = mdsopen('sunist',shotno);
    currentShotno = shotno;
    if isnumeric(shotno) || isa(shotno,'MDSplus.Int32')
        valueString = get(handles.lbDataStrings,'String');  % Get the users choice.
        timeString = get(handles.lbTimeStrings,'String');
        if ~isempty(valueString)
            if iscell(valueString)
                count = size(valueString,1);
            else
                count = 1;
            end
            
            figure(handles.hFigure);
            pos=get(gcf,'OuterPosition');
            set(handles.editWidth,'String',num2str(pos(3)));
            set(handles.editHeight,'String',num2str(pos(4)));

            set(gcf,'Name',shotno2str(shotno));

            isholdon = get(handles.cbHoldOn,'Value');
            issingle = get(handles.cbSingle,'Value');
            usinglatex = get(handles.cbLatex,'Value');
            gridon = get(handles.cbGrid,'Value');

            if ~isholdon
                clf;
            end
            if isholdon && ~issingle
                color=getNextColor();
            else
                color='blue';
                currentColor=6;
            end

            t_start=str2double(get(handles.editStart, 'String'));
            t_stop=str2double(get(handles.editStop, 'String'));
            fontsize=str2double(get(handles.editFontSize,'String'));
            fontname=get(handles.editFontName,'String');

            left=str2double(get(handles.editLeft, 'String'));
            right=str2double(get(handles.editRight, 'String'));
            top=str2double(get(handles.editTop, 'String'));
            bottom=str2double(get(handles.editBottom, 'String'));
            spacing=str2double(get(handles.editSpacing, 'String'));
            linewidth=str2double(get(handles.editLineWidth, 'String'));
            
            width = 1-left-right;
            if issingle
                height = 1-top-bottom;
            else
                height = ((1-top-bottom)-(count-1)*spacing)/count;
            end
            try
                for i=1:count
                    if issingle
                        subplot('position',[left bottom width height]);
                    else
                        subplot('position',[left 1-top-i*height width height]);
                    end
                    if isholdon || issingle
                        hold on;
                    else
                        hold off;
                    end
                    [ylabel1,xlabel1,ymin1,ymax1,marker,drawType]=GetPlotOptions(i,handles);
                    
                    if strcmp(drawType,'plot')
                        if count == 1 && ~iscell(valueString)
                            y=eval(valueString);
                            x=eval(timeString);
                        else
                            y=eval(valueString{i});
                            x=eval(timeString{i});
                        end
                        if size(x,1) < size(x,2)
                            x=x';
                        end
                        if size(y,1) < size(y,2)
                            y=y';
                        end
                        if size(x,1) > size(y,1)
                            x=x(1:size(y,1),1);
                        end
                        if isnumeric(y) && isnumeric(x)
                            if isempty(marker)
                                plot(x,y,'Color',color,'LineWidth',linewidth);
                            else
                                plot(x,y,marker,'Color',color);
                            end
                        else
                            text(0.1,0.5,y);
                        end
                    elseif  strcmp(drawType,'image')
                        if count == 1 && ~iscell(valueString)
                            eval(valueString);
                        else
                            eval(valueString{i});
                        end
%                         image(y);
                        %imresize(I, 0.5);
                        set(gca,'YDir','normal');
                    end

                    if ~isnan(t_start) && ~isnan(t_stop) && t_start<t_stop
                        xlim([t_start t_stop]);
                    end
%                     xlim1=xlim;
%                     xtick=xlim1(1):single(vpa((xlim1(2)-xlim1(1))/4,2)):xlim1(2);
%                     set(gca,'XTick',xtick);
                        xtick = get(gca,'XTick');
                    if i<count && ~issingle
                        set(gca,'XTickLabel',{});
                    elseif ~isempty(xlabel1)
                        set(gca,'XTick',xtick,'FontSize',fontsize,'FontName',fontname);
                        if usinglatex
                            xlabel(xlabel1,'FontSize',fontsize,'FontName',fontname,'Interpreter','latex');
                        else
                            xlabel(xlabel1,'FontSize',fontsize,'FontName',fontname);
                        end
                    end

                    if ~isempty(ylabel1) && ~issingle
                        if usinglatex
                            ylabel(ylabel1,'FontSize',fontsize,'FontName',fontname,'interpreter','latex');
                        else
                            ylabel(ylabel1,'FontSize',fontsize,'FontName',fontname);
                        end
                    end
                    if ~isnan(ymin1) && ~isnan(ymax1) && ymin1<ymax1
                        ylim([ymin1 ymax1]);
                    end
                    set(gca,'FontSize',fontsize,'FontName',fontname);
                    ylim1=ylim;
                    ytick=get(gca,'YTick');
                    if ylim1(1) == ytick(1) && ~issingle && i<count
                        set(gca,'YTick',ytick(2:end));
                    end
                    if gridon
                        grid on;
                    else
                        grid off;
                    end
                    if issingle
                        if i==1
                            currentTitle = '';
                        end
                        currentTitle=[currentTitle,', ','{\color{',color,'}',ylabel1,'}'];
                        if i==count
                            if usinglatex
                                title( ['Shot ',shotno2str(shotno),currentTitle], ...
                                 'HorizontalAlignment','right', ...
                                 'FontName',fontname, ...
                                 'FontSize',fontsize/2, ...
                                 'Position',[t_stop,ylim1(2),0],'interpreter','latex');  
                            else
                                title( ['Shot ',shotno2str(shotno),currentTitle], ...
                                 'HorizontalAlignment','right', ...
                                 'FontName',fontname, ...
                                 'FontSize',fontsize/2, ...
                                 'Position',[t_stop,ylim1(2),0]);  
                            end
                        end
                        color=getNextColor();
                    else
                        if i==1
                            if ~isholdon
                                currentTitle=['{\color{',color,'}',int2str(shotno),'}'];
                            else
                                currentTitle=[currentTitle,', ','{\color{',color,'}',int2str(shotno),'}'];
                            end
                            title( ['Shot ',currentTitle], ...
                             'HorizontalAlignment','right', ...
                             'FontName',fontname, ...
                             'FontSize',fontsize/2, ...
                             'Position',[t_stop,ylim1(2),0]);  
                        end
                    end
                end
            catch ME
                if ~isempty(strfind(ME.identifier,'ExpectedFiniteNonNaN'))
                    msgbox('Please fill all necessary blanks.','Error','error');
                else
                    msgbox(ME.message,'Error','error');
                end
                return
            end
            if issingle
                box on;
            end
            set(gcf,'color','white');
        end
    else
        msgbox('Can not open this shot on this tree!','Error','error');
    end
    mdsclose();
else
    msgbox('Please connect to the MDSplus server first!','Error','error');
end

function str = shotno2str(shotno)
str = int2str(shotno);
if length(str) == 8 
    str = ['0' str];
end

function [ylabel,xlabel,ymin,ymax,marker,drawType]=GetPlotOptions(i,handles)
L= get(handles.lbYLabels,'String');  % Get the users choice.
if ~iscell(L)
    strValue=L;
else
    strValue = L{i};
end
if ~strcmp(strValue,'null')
    ylabel=strValue;
else
    ylabel='';
end

L= get(handles.lbXLabels,'String');  % Get the users choice.
if ~iscell(L)
    strValue=L;
else
    strValue = L{i};
end
if ~strcmp(strValue,'null')
    xlabel=strValue;
else
    xlabel='';
end

L= get(handles.lbYMins,'String');  % Get the users choice.
if ~iscell(L)
    strValue=L;
else
    strValue = L{i};
end
if ~strcmp(strValue,'null')
    ymin=str2double(strValue);
else
    ymin=0;
end

L= get(handles.lbYMaxes,'String');  % Get the users choice.
if ~iscell(L)
    strValue=L;
else
    strValue = L{i};
end
if ~strcmp(strValue,'null')
    ymax=str2double(strValue);
else
    ymax=0;
end

L= get(handles.lbMarkers,'String');  % Get the users choice.
if ~iscell(L)
    strValue=L;
else
    strValue = L{i};
end
if ~strcmp(strValue,'null')
    marker=strValue;
else
    marker='';
end

L= get(handles.lbDrawTypes,'String');  % Get the users choice.
if ~iscell(L)
    strValue=L;
else
    strValue = L{i};
end
if ~strcmp(strValue,'null')
    drawType=strValue;
else
    drawType='plot';
end


function [y,x]=myfunc1(y0,x0)
% Quick integration function with 1/10 sampling
t=1:10:length(y0);
y0=y0(t);
x=x0(t);
y0=y0-mean(y0);
y=zeros(size(y0)-[1 0]);
deltT=zeros(size(y0));
for i=1:length(y)
    deltT(i,1)=x(i+1,1)-x(i,1);
    y(i,1)=sum(y0.*deltT);
end

function y=integrate(y0, n)
y=zeros(size(y0));
average = mean(y0(1:n,1));
y0 = y0 -average;
for i=1:length(y0)
    y(i,1)=sum(y0(1:i,1));
end

function y=BoEffects(y0,coef)
Uc=zeros(size(y0));

for i = 2:length(Uc)
    Uc(i,1)=Uc(i-1,1)+(y0(i,1)-Uc(i-1,1))*coef;
end
y=y0-Uc;

function y=data(valueString) %#ok<DEFNU>
y=mdsvalue(strcat('data(',valueString,')'));   % First, use kernel string to retrieve data.
% if ~isempty(findstr(valuestring,'wlyxz'))    % remove some elements in the head of wlyxz data
%     y=y(10:length(y),1);
% end

function y=subdata(valueString,baseShotno) %#ok<DEFNU>
global currentShotno
y1=mdsvalue(strcat('data(',valueString,')'));   % First, use kernel string to retrieve data.
mdsopen('sunist',currentShotno + baseShotno);
y2=mdsvalue(strcat('data(',valueString,')'));
mdsopen('sunist',currentShotno);
y=y1-y2;

function y=spect(y0,window,overlap)
y=spectrogram(y0,window,overlap);

function y=TrimBaseline(signal,sample_rate,baseline_start,baseline_length)
baseline = mean( signal(baseline_start*sample_rate/1e3:(baseline_start+baseline_length)*sample_rate/1e3,1));
y=signal - baseline;

function y=TrimSlope(y0,start,stop)
if start > 0 && stop > start && length(y0) > stop 
    d = y0(stop)-y0(start);
    y=y0-(1:length(y0))'.*d/(stop-start);
else
    y= [];
end

function y=modifyIp(y0,start,startv,stop,stopv)
y=zeros(size(y0));
y(start:stop)=startv+(stopv-startv)/(stop-start)*(0:stop-start)';
y(stop:length(y))=stopv;
y=y0+y;
% function y=mi(ctString,ctThreshold, ptString)
% ct=data(ctString);
% pt=data(ptString);
% 
% ct_smptno=3;
% pt_smptno=3;
% pt_baseline_smptno=51;
% 
% ct_sm=smooth(ct,ct_smptno);
% pt_sm=smooth(pt,pt_smptno);
% 
% pt_baseline=smooth(pt_sm,pt_baseline_smptno);
% 
% ct(ct_sm<ctThreshold)=-1;
% ct(ct_sm>=ctThreshold)=0;
% 
% ct_falling=zeros(size(ct));
% ct_falling(2:end)=ct(2:end)-ct(1:end-1);
% 
% ct_falling(ct_falling>-0.5)=1;
% ct_falling(ct_falling<-0.5)=0;
% 
% %---- phase trigger falling edge ----
% pt(pt_sm-pt_baseline<0)=0;
% pt(pt_sm-pt_baseline>0)=-1;
% pt(1)=0;
% pt(end)=pt(end-1);
% 
% pt_falling=zeros(size(pt));
% pt_falling(2:end)=pt(2:end)-pt(1:end-1);
% 
% pt_falling(pt_falling>-0.5)=0;
% pt_falling(pt_falling<-0.5)=1;
% 
% %---- fringe calculation ----
% fringe=zeros(size(pt));
% fringe(1)=1*ct_falling(1);
% for ii=2:size(pt,1)
%     fringe(ii)=(fringe(ii-1)+1)*ct_falling(ii);
% end
% y=fringe.*pt_falling;

function y=eib(valueString) %#ok<DEFNU>
y=evalin('base',valueString);

function c=getNextColor()
global currentColor
colorspec={'magenta','cyan','green','black','yellow','blue','red'};
if currentColor < 7
    currentColor=currentColor+1;
else
    currentColor=1;
end
c_t=colorspec(currentColor);
c=c_t{1};

function editChannel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function figure1_CloseRequestFcn(hObject, eventdata, handles)
if strcmp(get(handles.pbConnect, 'String'),'Disconnect')
    mdsdisconnect();
end
figure(handles.hFigure);
close();
delete(hObject);
function editDataString_Callback(hObject, eventdata, handles)
function editDataString_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function lbDataStrings_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbDataStrings,handles);
function editServerAddress_Callback(hObject, eventdata, handles)
function editServerAddress_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pbConnect_Callback(hObject, eventdata, handles)
if strcmp(get(handles.pbConnect, 'String'),'Connect')
    mdsconnect(get(handles.editServerAddress, 'String'));%mdsopen( strcat(get(handles.editServerAddress, 'String'),'::sunist'),0);
    %if mod(result, 2) > 0
    set(handles.pbConnect, 'String','Disconnect');
%         plotData(handles);
    %end
else
    mdsdisconnect();
    %if mod(result, 2) > 0
    set(handles.pbConnect, 'String','Connect');
    %end
end
function editShotNO_Callback(hObject, eventdata, handles)
% plotData(handles);
function editShotNO_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pbPrevious_Callback(hObject, eventdata, handles)
present = get(handles.editShotNO,'String');
server = get(handles.editServerAddress,'String');
shotno = mdsopen('sunist',0);
if str2double(present) <= 0 
    if str2double(present) + mod(shotno,1000) > 1
        set(handles.editShotNO, 'String',int2str(str2double(present)-1));
    else
        set(handles.editShotNO, 'String', ...
            GetPrevShotNO(int2str(shotno - mod(shotno,1000) +1),server));
    end
elseif length(present) == 9 || length(present) == 8
    set(handles.editShotNO, 'String',GetPrevShotNO(present,server));
end
pbPlot_Callback(hObject, eventdata, handles);
function pbNext_Callback(hObject, eventdata, handles)
present = get(handles.editShotNO,'String');
server = get(handles.editServerAddress,'String');
if str2double(present) < 0 
    set(handles.editShotNO, 'String',int2str(str2double(present)+1));
elseif length(present) == 9 || length(present) == 8
    shotno = mdsopen('sunist',0);
    next = GetNextShotNO(present,server);
    if floor(shotno/1000) == floor(str2double(next)/1000)
        set(handles.editShotNO, 'String',int2str(str2double(next)-shotno));
    else
        set(handles.editShotNO, 'String',next);
    end
end
pbPlot_Callback(hObject, eventdata, handles);

function shotno=GetNextShotNO(present,server)
if ~strcmp(server,'192.168.1.2')
    url=java.net.URL(strcat('http://',server,':8010/filelist.php?shotno=',present,'&direction=next'));
else
    url=java.net.URL(strcat('http://',server,'/filelist.php?shotno=',present,'&direction=next'));
end
stream = openStream(url);
ireader = java.io.InputStreamReader(stream);
breader = java.io.BufferedReader(ireader);
shotno=readLine(breader);
shotno=char(shotno);

function shotno=GetPrevShotNO(present,server)
if ~strcmp(server,'192.168.1.2')
    url=java.net.URL(strcat('http://',server,':8010/filelist.php?shotno=',present,'&direction=prev'));
else
    url=java.net.URL(strcat('http://',server,'/filelist.php?shotno=',present,'&direction=prev'));
end
stream = openStream(url);
ireader = java.io.InputStreamReader(stream);
breader = java.io.BufferedReader(ireader);
shotno=readLine(breader);
shotno=char(shotno);

function pmDAQ_Callback(hObject, eventdata, handles)
checkChannelNo(handles);
[y,x]=makeValueString(handles);
updateValueString(handles,y,x);
function pmDAQ_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editChannel_Callback(hObject, eventdata, handles)
checkChannelNo(handles);
[y,x]=makeValueString(handles);
updateValueString(handles,y,x);
function editStart_Callback(hObject, eventdata, handles)
function editStart_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editStop_Callback(hObject, eventdata, handles)
function editStop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editYLabel_Callback(hObject, eventdata, handles)
function editYLabel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editXLabel_Callback(hObject, eventdata, handles)
function editXLabel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editYMin_Callback(hObject, eventdata, handles)
function editYMin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editYMax_Callback(hObject, eventdata, handles)
function editYMax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function cbHoldOn_Callback(hObject, eventdata, handles)
function lbDataStrings_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function lbYLabels_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbYLabels,handles);
function lbYLabels_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function lbXLabels_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbXLabels,handles);
function lbXLabels_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function lbYMins_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbYMins,handles);
function lbYMins_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function lbYMaxes_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbYMaxes,handles);
function lbYMaxes_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pbSave_Callback(hObject, eventdata, handles)
global currentShotno
L1 = get(handles.lbDataStrings,'String');  % Get the users choice.
L3 = get(handles.lbYLabels,'String');  % Get the users choice.
L4 = get(handles.lbXLabels,'String');  % Get the users choice.
L5 = get(handles.lbYMins,'String');  % Get the users choice.
L6 = get(handles.lbYMaxes,'String');  % Get the users choice.
L8 = get(handles.lbTimeStrings,'String');  % Get the users choice.
L9 = get(handles.lbMarkers,'String');  % Get the users choice.
L10 = get(handles.lbDrawTypes,'String');  % Get the users choice.

ShotNO=currentShotno;
MDSplusServer=get(handles.editServerAddress,'String');

t_start=get(handles.editStart,'String');
t_stop=get(handles.editStop,'String');

left=str2double(get(handles.editLeft, 'String'));
right=str2double(get(handles.editRight, 'String'));
top=str2double(get(handles.editTop, 'String'));
bottom=str2double(get(handles.editBottom, 'String'));
spacing=str2double(get(handles.editSpacing, 'String'));

fontsize=get(handles.editFontSize,'String');
fontname=get(handles.editFontName,'String');
linewidth=get(handles.editLineWidth,'String');

width=get(handles.editWidth,'String');
height=get(handles.editHeight,'String');

vpn = get(handles.cbVPN,'Value');
autorefresh = get(handles.cbAR,'Value');
rate = get(handles.editRate,'String');
issingle = get(handles.cbSingle,'Value');
usinglatex = get(handles.cbLatex,'Value');
gridon = get(handles.cbGrid,'Value');

uisave({'L1','L3','L4','L5','L6','L8','L9','L10','ShotNO','MDSplusServer','t_start',...
    't_stop','left','right','top','bottom','spacing','fontsize','fontname',...
    'linewidth','width','height','vpn','autorefresh','rate','issingle','usinglatex',...
    'gridon'},['shot' shotno2str(currentShotno)]);

function pbLoad_Callback(hObject, eventdata, handles)
uiopen('LOAD');

if exist('L1','var')
    set(handles.lbDataStrings,'String',L1);  % Get the users choice.
end
if exist('L3','var')
    set(handles.lbYLabels,'String',L3);  % Get the users choice.
end
if exist('L4','var')
    set(handles.lbXLabels,'String',L4);  % Get the users choice.
end
if exist('L5','var')
    set(handles.lbYMins,'String',L5);  % Get the users choice.
end
if exist('L6','var')
    set(handles.lbYMaxes,'String',L6);  % Get the users choice.
end
if exist('L8','var')
    set(handles.lbTimeStrings,'String',L8);  % Get the users choice.
end
if exist('L9','var')
    set(handles.lbMarkers,'String',L9);  % Get the users choice.
end
if exist('L10','var')
    set(handles.lbDrawTypes,'String',L10);  % Get the users choice.
end

if exist('ShotNO','var')
    set(handles.editShotNO,'String',num2str(ShotNO));  
end
if exist('MDSplusServer','var')
    set(handles.editServerAddress,'String',MDSplusServer);  
end
if exist('t_start','var')
    set(handles.editStart,'String',t_start);  
end
if exist('t_stop','var')
    set(handles.editStop,'String',t_stop);  
end
if exist('fontsize','var')
    set(handles.editFontSize,'String',fontsize);  
end
if exist('fontname','var')
    set(handles.editFontName,'String',fontname);  
end
if exist('left','var')
    set(handles.editLeft,'String',left);  
end
if exist('right','var')
    set(handles.editRight,'String',right);  
end
if exist('top','var')
    set(handles.editTop,'String',top);  
end
if exist('bottom','var')
    set(handles.editBottom,'String',bottom);  
end
if exist('spacing','var')
    set(handles.editSpacing,'String',spacing);  
end
if exist('linewidth','var')
    set(handles.editLineWidth,'String',linewidth);  
end
if exist('width','var')
    set(handles.editWidth,'String',width);  
end
if exist('height','var')
    set(handles.editHeight,'String',height);  
end
if exist('vpn','var')
    set(handles.cbVPN,'Value',vpn);  
end
if exist('autorefresh','var')
    set(handles.cbAR,'Value',autorefresh);  
end
if exist('rate','var')
    set(handles.editRate,'String',rate);  
end
if exist('issingle','var')
    set(handles.cbSingle,'Value',issingle);  
end
if exist('usinglatex','var')
    set(handles.cbLatex,'Value',usinglatex);  
end
if exist('gridon','var')
    set(handles.cbGrid,'Value',gridon);  
end


function editFontSize_Callback(hObject, eventdata, handles)
function editFontSize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editTop_Callback(hObject, eventdata, handles)
function editTop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editBottom_Callback(hObject, eventdata, handles)
function editBottom_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editLeft_Callback(hObject, eventdata, handles)
function editLeft_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editRight_Callback(hObject, eventdata, handles)
function editRight_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editSpacing_Callback(hObject, eventdata, handles)
function editSpacing_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editFontName_Callback(hObject, eventdata, handles)
function editFontName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editTimeString_Callback(hObject, eventdata, handles)
function editTimeString_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function lbTimeStrings_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbTimeStrings,handles);
function lbTimeStrings_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function editLineWidth_Callback(hObject, eventdata, handles)
function editLineWidth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editWidth_Callback(hObject, eventdata, handles)
ChangeSize(handles);
function editWidth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editHeight_Callback(hObject, eventdata, handles)
ChangeSize(handles);
function editHeight_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMarker_Callback(hObject, eventdata, handles)
function editMarker_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lbDrawTypes_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbDrawTypes,handles);


function lbDrawTypes_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lbMarkers_Callback(hObject, eventdata, handles)
SelectTheSame(handles.lbMarkers,handles);

function lbMarkers_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDrawType_Callback(hObject, eventdata, handles)

function editDrawType_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ExchangeValues(listbox,i1,i2)
L=get(listbox,'String');
tmp=L{i1};
L{i1}=L{i2};
L{i2}=tmp;
set(listbox,'String',L) % Set the new string.
set(listbox,'Value',i2) % Set the new string.

function pbUp_Callback(hObject, eventdata, handles)
index = get(handles.lbDataStrings,'Value');  % Get the users choice.
if index>1
    ExchangeValues(handles.lbDataStrings,index,index-1);
    ExchangeValues(handles.lbYLabels,index,index-1);
    ExchangeValues(handles.lbYMaxes,index,index-1);
    ExchangeValues(handles.lbYMins,index,index-1);
    ExchangeValues(handles.lbTimeStrings,index,index-1);
    ExchangeValues(handles.lbXLabels,index,index-1);
    ExchangeValues(handles.lbMarkers,index,index-1);
    ExchangeValues(handles.lbDrawTypes,index,index-1);
end

function pbDown_Callback(hObject, eventdata, handles)
index = get(handles.lbDataStrings,'Value');  % Get the users choice.
num = length(get(handles.lbDataStrings,'String'));
if index<num
    ExchangeValues(handles.lbDataStrings,index,index+1);
    ExchangeValues(handles.lbYLabels,index,index+1);
    ExchangeValues(handles.lbYMaxes,index,index+1);
    ExchangeValues(handles.lbYMins,index,index+1);
    ExchangeValues(handles.lbTimeStrings,index,index+1);
    ExchangeValues(handles.lbXLabels,index,index+1);
    ExchangeValues(handles.lbMarkers,index,index+1);
    ExchangeValues(handles.lbDrawTypes,index,index+1);
end


% --- Executes on button press in cbSingle.
function cbSingle_Callback(hObject, eventdata, handles)
% hObject    handle to cbSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbSingle


% --- Executes on button press in cbVPN.
function cbVPN_Callback(hObject, eventdata, handles)
% hObject    handle to cbVPN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbVPN
if get(hObject,'Value')
    set(handles.editServerAddress,'String','192.168.1.2');
else
    set(handles.editServerAddress,'String','166.111.89.112');
end


% --- Executes on button press in cbAR.
function cbAR_Callback(hObject, eventdata, handles)
% hObject    handle to cbAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% cbAR;
if get(hObject,'Value');
    rate = str2num(get(handles.editRate,'String'));
    t = timer('StartDelay',1,'ExecutionMode',...
                     'fixedRate','BusyMode','drop','Period',rate*60);
    t.TimerFcn = { @pbPlot_Callback,  handles};
    start(t);
else
    stop(timerfind);
    delete(timerfind);
end


function editRate_Callback(hObject, eventdata, handles)
% hObject    handle to editRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRate as text
%        str2double(get(hObject,'String')) returns contents of editRate as a double


% --- Executes during object creation, after setting all properties.
function editRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cbLatex.
function cbLatex_Callback(hObject, eventdata, handles)
% hObject    handle to cbLatex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbLatex


% --- Executes on button press in cbGrid.
function cbGrid_Callback(hObject, eventdata, handles)
% hObject    handle to cbGrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbGrid
