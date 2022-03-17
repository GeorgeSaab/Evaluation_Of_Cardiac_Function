%George Saab
%BMEN E6003

%% Determine Cardiac Metrics 

[SV, EF, CO, EDV, ESV] = Cardiac_Metrics();

fprintf('End Diastolic volume is %0.3f\nEnd Systolic volume is %0.3f\nStroke volume is %0.3f\nEjection fraction is %0.3f\nCardiac output is %0.3f', EDV, ESV, SV, EF, CO)

%% Function to Determine Cardiac Metrics
% Determines the various cardiac metrics by measuring the end systolic and
% diastolic for each video input. The frames are selected manually after
% viewing and the calculations are done automatically. The calibration
% scale in the image is used to convert from the pixel length to
% centimeters.

function [SV, EF, CO, EDV, ESV] = Cardiac_Metrics()
global_pause = 1.0;

% Check if videos exist in folder
if isfile('SA_PapilaryVolunteer.avi') && isfile('SA_MitralVolunteer.avi') && isfile('SA_ApexVolunteer.avi') && isfile('Apical4chVolunteer.avi') 
    fprintf('Loading video files...\n\n')
else
    error('Video Files need to be in same folder')
end

% calibration [do not touch]
calibration = 446.6214 - 88.2045; %When x distance is zero, measure y distance on scale -> supposed to match 15 cm on images
calibration_1cm = calibration / 15;

% Load Videos
PM = VideoReader('SA_PapilaryVolunteer.avi');
MV = VideoReader('SA_MitralVolunteer.avi');
APEX = VideoReader('SA_ApexVolunteer.avi');
AP = VideoReader('Apical4chVolunteer.avi');

% For AP
AP_Label = 'Apical 4 Channel';
fig1 = figure(1);
fig1.WindowState = 'maximized';
for n = 2:AP.NumFrames-1
    a = n-1;
    s = n;
    d = n+1;
    frame1 = read(AP,a);
    frame2 = read(AP,s);
    frame3 = read(AP,d);
    
    subplot(1,3,1)
    imshow(frame1)
    title(sprintf('Frame: %d', a))
    subplot(1,3,2)
    imshow(frame2)
    title(sprintf('Frame: %d', s))
    subplot(1,3,3)
    imshow(frame3)
    title(sprintf('Frame: %d', d))
    sgtitle(AP_Label)
    pause(global_pause)
end
close(fig1);

% Input and receive results
input_frame_ED_AP = input('Which is the End-Diastolic frame?: ');
frame = read(AP,input_frame_ED_AP);
fig1 = figure(1);
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ED_AP, AP_Label))

% Draw line for ED and ES
h1 = drawline('SelectedColor','yellow');

% x and y coordinates
% |x1 y1|
% |x2 y2|
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);

% Convert distance to cm
distance_ED_AP = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ED_AP_cm = distance_ED_AP / calibration_1cm
close(fig1);
% Repeat for End-Systolic
input_frame_ES_AP = input('Which is the End-Systolic frame?: ');
frame = read(AP,input_frame_ES_AP);
fig1 = figure(1);
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ES_AP, AP_Label))
h1 = drawline('SelectedColor','yellow');
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);
distance_ES_AP = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ES_AP_cm = distance_ES_AP / calibration_1cm
close(fig1);

% Repeat all of the above code for the next 3 videos


% For APEX
APEX_Label = 'Short Axis Apex';
fig1 = figure(1);
fig1.WindowState = 'maximized';
for n = 2:APEX.NumFrames-1
    a = n-1;
    s = n;
    d = n+1;
    frame1 = read(APEX,a);
    frame2 = read(APEX,s);
    frame3 = read(APEX,d);
    subplot(1,3,1)
    imshow(frame1)
    title(sprintf('Frame: %d', a))
    subplot(1,3,2)
    imshow(frame2)
    title(sprintf('Frame: %d', s))
    subplot(1,3,3)
    imshow(frame3)
    title(sprintf('Frame: %d', d))
    sgtitle(APEX_Label)
    pause(global_pause)
end
close(fig1);
input_frame_ED_APEX = input('Which is the End-Diastolic frame?: ');
frame = read(APEX,input_frame_ED_APEX);
fig1 = figure(1);
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ED_APEX, APEX_Label))
h1 = drawline('SelectedColor','yellow');
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);
distance_ED_APEX = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ED_APEX_cm = distance_ED_APEX / calibration_1cm
close(fig1);
input_frame_ES_APEX = input('Which is the End-Systolic frame?: ');
frame = read(APEX,input_frame_ES_APEX);
fig1 = figure(1);
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ES_APEX, APEX_Label))
h1 = drawline('SelectedColor','yellow');
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);
distance_ES_APEX = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ES_APEX_cm = distance_ES_APEX / calibration_1cm
close(fig1)

% For MV
MV_Label = 'Short Axis Mitral';
fig1 = figure(1);
fig1.WindowState = 'maximized';
for n = 2:MV.NumFrames-1
    a = n-1;
    s = n;
    d = n+1;
    frame1 = read(MV,a);
    frame2 = read(MV,s);
    frame3 = read(MV,d);
    subplot(1,3,1)
    imshow(frame1)
    title(sprintf('Frame: %d', a))
    subplot(1,3,2)
    imshow(frame2)
    title(sprintf('Frame: %d', s))
    subplot(1,3,3)
    imshow(frame3)
    title(sprintf('Frame: %d', d))
    sgtitle(MV_Label)
    pause(global_pause)
end
close(fig1);
input_frame_ED_MV = input('Which is the End-Diastolic frame?: ');
frame = read(MV,input_frame_ED_MV);
fig1 = figure(1)
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ED_MV, MV_Label))
h1 = drawline('SelectedColor','yellow');
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);
distance_ED_MV = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ED_MV_cm = distance_ED_MV / calibration_1cm
close(fig1);
input_frame_ES_MV = input('Which is the End-Systolic frame?: ');
frame = read(MV,input_frame_ES_MV);
fig1 = figure(1)
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ES_MV, MV_Label))
h1 = drawline('SelectedColor','yellow');
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);
distance_ES_MV = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ES_MV_cm = distance_ES_MV / calibration_1cm
close(fig1);

% For PM
PM_Label = 'Short Axis Papillary';
fig1 = figure(1);
fig1.WindowState = 'maximized';
for n = 2:PM.NumFrames-1
    a = n-1;
    s = n;
    d = n+1;
    frame1 = read(PM,a);
    frame2 = read(PM,s);
    frame3 = read(PM,d);
    subplot(1,3,1)
    imshow(frame1)
    title(sprintf('Frame: %d', a))
    subplot(1,3,2)
    imshow(frame2)
    title(sprintf('Frame: %d', s))
    subplot(1,3,3)
    imshow(frame3)
    title(sprintf('Frame: %d', d))
    sgtitle(PM_Label)
    pause(global_pause)
end
close(fig1);
input_frame_ED_PM = input('Which is the End-Diastolic frame?: ');
frame = read(PM,input_frame_ED_PM);
fig1 = figure(1)
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ED_PM, PM_Label))
h1 = drawline('SelectedColor','yellow');
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);
distance_ED_PM = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ED_PM_cm = distance_ED_PM / calibration_1cm
close(fig1);
input_frame_ES_PM = input('Which is the End-Systolic frame?: ');
frame = read(PM,input_frame_ES_PM);
fig1 = figure(1)
fig1.WindowState = 'maximized';
imshow(frame)
title(sprintf('Frame: %d | %s', input_frame_ES_PM, PM_Label))
h1 = drawline('SelectedColor','yellow');
x1 = h1.Position(1,1); 
x2 = h1.Position(2,1);
y1 = h1.Position(1,2);
y2 = h1.Position(2,2);
distance_ES_PM = sqrt((x2-x1)^2 + (y2-y1)^2);
distance_ES_PM_cm = distance_ES_PM / calibration_1cm
close(fig1);


% After measurements have been taken, calculate the values

HR = 60; %60 bpm

h_ED = distance_ED_AP_cm / 3;
ED_MV_Area = pi*(distance_ED_MV_cm/2)^2;
ED_PM_Area = pi*(distance_ED_PM_cm/2)^2;
ED_APEX_Area = pi*(distance_ED_APEX_cm/2)^2;
EDV = (ED_MV_Area + ED_PM_Area)*h_ED + (ED_APEX_Area*(h_ED/2)) + (pi*(h_ED^3)/6);

h_ES = distance_ES_AP_cm / 3;
ES_MV_Area = pi*(distance_ES_MV_cm/2)^2;
ES_PM_Area = pi*(distance_ES_PM_cm/2)^2;
ES_APEX_Area = pi*(distance_ES_APEX_cm/2)^2;
ESV = (ES_MV_Area + ES_PM_Area)* h_ES + (ES_APEX_Area*(h_ES/2)) + (pi*(h_ES^3)/6);

SV = EDV - ESV;
EF = SV / EDV;
CO = SV * HR;
end
