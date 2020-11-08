

data = importdata("denoising_codeChallenge.mat");

origSignal = data.origSignal;
cleanedSignal = data.cleanedSignal;

figure(1)

plot(origSignal, 'b')

% plot(cleanedSignal)
k = 130;

% Running mean time series filter
coefficient = ((2*k+1)^-1);
meanSignal = origSignal;
for i=k+1:length(origSignal)-k-1
 
    meanSignal(i) = mean(meanSignal(i-k: i+k));
end

% Setting the edges to zero

figure(2)
plot(meanSignal,'r')
ylim([-1 0.7])
% Remove spike noise using the median filter
threshold = 70;

% get values above the threshold
aboveThresh = find(meanSignal>threshold);

% initialise median filtered signal
medianSignal = origSignal;

for i=1:length(aboveThresh)
    lowerBound = max(1, aboveThresh(i)-k);
    upperBound = min(aboveThresh(i)+ k, length(meanSignal));
    
    % calculate median of the surrounding points
    medianSignal(aboveThresh(i)) = median(meanSignal(lowerBound:upperBound));
    
end

medianSignal = filter(medianSignal);


figure(3)
plot(medianSignal,'k')
ylim([-1 0.7])

figure(4)
plot(dtrend(medianSignal))
ylim([-1 0.7])

% for i=k+1:length(origSignal)-k-1
%  
%     origSignal(i) = median(origSignal(i-k: i+k));
% end
% 
% hold on
% plot(origSignal,'k')
% 
% for i=2:length(origSignal)-1
%     origSignal(i) = (origSignal(i)^2) - (origSignal(i-1)*origSignal(i+1));
% end
% 
% hold on
% plot(origSignal,'k')
clear;clc;
data = importdata("denoising_codeChallenge.mat");

origSignal = data.origSignal;
cleanedSignal = data.cleanedSignal;

figure;

plot(origSignal, 'b')

k = 150;
% Remove spike noise using the median filter
upper_threshold = 10;
lower_threshold = -10;

% initialise median filtered signal
medianSignal = origSignal;

% get values above the threshold
aboveThresh = find(medianSignal>upper_threshold);

belowThresh = find(medianSignal<lower_threshold);

for i=1:length(aboveThresh)
    lowerBound = max(1, aboveThresh(i)-k);
    upperBound = min(aboveThresh(i)+ k, length(medianSignal));
    
    % calculate median of the surrounding points
    medianSignal(aboveThresh(i)) = 
median(medianSignal(lowerBound:upperBound));
    
end


for i=1:length(aboveThresh)
    lowerBound = max(1, belowThresh(i)-k);
    upperBound = min(aboveThresh(i)+ k, length(medianSignal));
    
    % calculate median of the surrounding points
    medianSignal(belowThresh(i)) = 
median(medianSignal(lowerBound:upperBound));
    
end
figure;
plot(medianSignal,'g')
%ylim([-3 3])



% plot(cleanedSignal)


% Running mean time series filter
coefficient = ((2*k+1)^-1);
meanSignal = medianSignal;
for i=k+1:length(origSignal)-k-1
    meanSignal(i) = mean(meanSignal(i-k: i+k));
end

% Setting the edges to zero

figure;
plot(meanSignal,'r')
ylim([-1 1])
