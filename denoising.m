clear;clc;
data = importdata("denoising_codeChallenge.mat");

origSignal = data.origSignal;
cleanedSignal = data.cleanedSignal;

figure;

plot(origSignal, 'b')
title('Original Signal')
xlabel('time')
ylabel('amplitude')

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
    medianSignal(aboveThresh(i)) = median(medianSignal(lowerBound:upperBound));
    
end


for i=1:length(aboveThresh)
    lowerBound = max(1, belowThresh(i)-k);
    upperBound = min(aboveThresh(i)+ k, length(medianSignal));
    
    % calculate median of the surrounding points
    medianSignal(belowThresh(i)) = median(medianSignal(lowerBound:upperBound));
    
end
figure;
plot(medianSignal,'g')
title('median filter with k = 150')
xlabel('time')
ylabel('amp[litude')
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
title('cascaded output through mean timeseries filter with k = 150')
xlabel('time')
ylabel('amplitude')
ylim([-1 1])