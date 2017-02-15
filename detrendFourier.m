function [ output_args ] = detrendFourier( elevation_file )
%DETRENDFOURIER this function detrends an elevation profile and finds the
%Fourier transform, and plots it. Used for topographic analysis of debris
%covered glaciers. Expected input is an n x 2 x,y elevation profile.
%   Detailed explanation goes here

    input = load(elevation_file);
    x = input(:,1); %metres
    y = input(:,2); %metres
    figure(1);
    plot(x,elev);
    xlabel('Distance, km');
    ylabel('Elevation, m');
    title('Input Elevation Profile');
    
    %Fs = 1; %1 m resolution, which I think is the spatial sampling 'frequency'
    %T = 1/Fs;
    %L=length(elev);
    %t = (0:L-1)*T;        % Inverse x-axis
    elev_fft = fft(elev);
    figure(2)
    plot(elev_fft);
    
end

