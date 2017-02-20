function [ output_args ] = detrendFourier( elevation_file )
%DETRENDFOURIER this function detrends an elevation profile and finds the
%Fourier transform, and plots it. Used for topographic analysis of debris
%covered glaciers. Expected input is an n x 2 x,y elevation profile.
%   Detailed explanation goes here

    close all
    set(0,'defaultAxesFontSize',16);
    input = load(elevation_file);
    x = input(:,1); %metres
    elev = input(:,2); %metres
    figure(1);
    subplot(3,1,1);
    plot(x,elev);
    hold on
    xlabel('Distance, km');
    ylabel('Elevation, m');
    title('Input Elevation Profile');
    
    %% Adding arcuate surface discontinuities, ugly hardcoding sorry
    load isd_spacing
    hold on
    y = [min(elev):10:max(elev)]';
    
    for k = 1:length(cumdist)
        asd_x = ones(length(y),1).*cumdist(k);
        plot(asd_x,y,'r--');
        hold on
    end
    
    
    detrend_elev = detrend(elev);
    subplot(3,1,2);
    plot(x,detrend_elev,'b');
    hold on
    xlabel('Distance, km');
    ylabel('Elevation, m');
    title('Detrended Elevation Profile');
    hold on
    y = [min(detrend_elev):1:max(detrend_elev)]';

    
    for k = 1:length(cumdist)
        asd_x = ones(length(y),1).*cumdist(k);
        plot(asd_x,y,'r');
        hold on
    end
    
    
    Fs = 1; %1 m resolution, which I think is the spatial sampling 'frequency'
    T = 1/Fs;
    L=length(detrend_elev);
    n = 2^nextpow2(L); %for padding the input with trailing zeroes, for fft performance
    elev_fft = fft(detrend_elev,n);
    inv_x = Fs*(0:(n/2))/n;
    P2 = abs(elev_fft/L); %two-sided spectrum
    subplot(3,1,3);
    loglog(inv_x,P2(1:n/2+1));
    title('Frequency spectrum for the detrended elevation profile');
    xlabel('Spatial frequency (1/m)');
    ylabel('Amplitude');
end

