clc; clear all; close all;

tic
%import all ecg signals
ecg1 = load('ECG_316048396_01.mat');
ecg2 = load('ECG_316048396_02.mat');
ecg3 = load('ECG_208119719_01.mat');
ecg4 = load('ECG_208119719_02.mat');

ecg1 = ecg1.sig;
ecg2 = ecg2.sig;
ecg3 = ecg3.sig;
ecg4 = ecg4.sig;

% R-wave detection 
Rwaves.R1 = Rwave_detection(ecg1);      % R1 = index of R waves in ecg3
Rwaves.R2 = Rwave_detection(ecg2);      % R2 = index of R waves in ecg4

% figure(10)
% plot(ecg2); hold on; plot(Rwaves.R2, ecg2(Rwaves.R2),'r.');

% %% plots for word document
% % Plots for ECG_208119719_01
% ecg1 = ecg1;
% ecg2 = ecg2';
% ecg3 = ecg3;
% ecg4 = ecg4';
% figure(1);
% plot((15000:20000)./1000, ecg3(15000:20000)./1000); xlabel('Time[sec]'); ylabel('Amplitude [mv]');
% 
% figure(2);
% plot((23000:28000)./1000, ecg3(23000:28000)./1000); xlabel('Time[sec]'); ylabel('Amplitude [mv]'); hold on;
% marks = find(Rwaves.R1 >= 23000  &  Rwaves.R1 <= 28000);
% plot(Rwaves.R1(marks)./1000, ecg3(Rwaves.R1(marks))./1000,'r*'); hold off;
% 
% figure(3);
% peaks = Rwaves.R1;
% RR = (peaks(2:end)-peaks(1:end - 1))./1000;
% heart_rate=1./RR;
% plot(peaks(1,2:end)./1000,heart_rate); xlabel('Time[sec]'); ylabel('Heart Rate[Beat/sec]');
% 
% % Plots for ECG_208119719_02
% figure(4);
% plot([15000:20000]./1000, ecg4(15000:20000)./1000); xlabel('Time [sec]'); ylabel('Amplitude [mv]');
% 
% figure(5);
% plot((23000:28000)./1000, ecg4(23000:28000)./1000); xlabel('Time [sec]'); ylabel('Amplitude [mv]'); hold on;
% marks = find(Rwaves.R2 >= 23000 & Rwaves.R2 <= 28000);
% plot(Rwaves.R2(marks)./1000, ecg4(Rwaves.R2(marks))./1000, 'r*');hold off;
% 
% figure(6);
% peaks = Rwaves.R2;
% RR=(peaks(2:end) - peaks(1:end - 1))./1000;
% heart_rate=1./RR;
% plot(peaks(1,2:end)./1000,heart_rate); xlabel('Time[sec]'); ylabel('Heart Rate[Beat/sec]');

%% save the peaks vectors as instructed
save('316048396.mat','Rwaves');

toc

