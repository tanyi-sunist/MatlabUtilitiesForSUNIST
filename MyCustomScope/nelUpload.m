%% Upload NeL data to the mdsplus server
% Manually extract electron density data from the graph with distorted
% zebra lines, and then upload the neL data to the mdsplus server.
% mdsShot: the number of the shot that will be uploaded
% note: before use me, please connect to the mdsplus server first
function nelUpload(mdsShot)
mdsopen('sunist',mdsShot);
ct=mdsvalue('\ct');
pt=mdsvalue('\pt');
tm1=mdsvalue('\acq308_tm')+39.2;
y=mi(ct,3,pt-2);
fig=figure(1);
h_of_plot=plot(tm1,y,'.');
set (fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
hold on;
tmp_h_ginput = gca;

%% calculate the gap between two fringes
yn=y(y~=0);
yl=yn(length(yn)-20:length(yn)-1,:);
dy=diff(yl);
dye=dy(dy>0 & dy>min(abs(dy)));
base_gap = mean(dye);
%%
choice = questdlg('请从图中点选密度曲线（左键选取数据点，右键结束），并上传至MDSPlus服务器。','微波干涉仪密度曲线','现在选取','取消','取消');
if strcmp(choice, '现在选取')
    X=get(h_of_plot,'XData');
    Y=get(h_of_plot,'YData');
    tmp_idx = (y ~= 0);
    X=X(tmp_idx);
    Y=Y(tmp_idx);
    
    button = 1;
    xy = [];
    while button == 1
        [xi, yi, button] = ginput(1);
        if button == 1
            tmpIndex=abs(X-xi)<(max(tm1)-min(tm1))/40 & abs(Y-yi)<base_gap/4;
            tmpY=Y(tmpIndex);
            tmpX=X(tmpIndex);
            plot(tmp_h_ginput, tmpX, tmpY, 'r+');
            xy=[xy;tmpX' tmpY'];
        end
    end
    xy=unique(xy,'rows');
    xy(:,2) = xy(:,2) - min(xy(:,2));
    mdsNELNode = '\nel';
    mdsNEL_PHASENode = '\nel_phase';
    frequency = 94; % GHz
    const = 2.366E15;

    tm = xy(:, 1);
    phase_data = 2 * pi * xy(:, 2) / base_gap;
    nel_data = phase_data * frequency * const;

    mdsput(mdsNELNode, ...
        'Build_Signal(Build_With_Units($, "m-2"), *, Build_With_Units($, "ms"))', ...
        nel_data, tm);
    mdsput(mdsNEL_PHASENode, ...
        'Build_Signal($, *, Build_With_Units($, "ms"))', ...
        phase_data, tm);

    mdsvalue('setevent(''nel_put_done'')');
    
    msgbox('nel 数据上传完毕！', '微波干涉仪密度曲线', 'help');
end
close all;
