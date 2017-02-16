function [ output_args ] = detrendFourier( elevation_file )
%DETRENDFOURIER this function detrends an elevation profile and finds the
%Fourier transform, and plots it. Used for topographic analysis of debris
%covered glaciers. Expected input is an n x 2 x,y elevation profile.
%   Detailed explanation goes here


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
    
    detrend_elev = detrend(elev);
    subplot(3,1,2);
    plot(x,detrend_elev);
    hold on
    xlabel('Distance, km');
    ylabel('Elevation, m');
    title('Detrended Elevation Profile');
   
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

