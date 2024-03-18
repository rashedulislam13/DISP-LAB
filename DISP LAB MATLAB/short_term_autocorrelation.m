% Load the speech signal
[speech_signal, sampling_frequency] = audioread('sample.wav');

% Define parameters
frame_length = 0.02 * sampling_frequency; % Frame length (20 ms)
overlap = 0.5 * frame_length;              % Overlap (50%)
num_frames = floor((length(speech_signal) - overlap) / (frame_length - overlap));
max_lag = frame_length - 1;
short_term_autocorr = zeros(num_frames, max_lag + 1);

% Compute short-term autocorrelation
for i = 1:num_frames
    start_index = round((i - 1) * (frame_length - overlap) + 1);
    end_index = start_index + frame_length - 1;
    frame = speech_signal(start_index:end_index);
    autocorr_values = xcorr(frame);
    short_term_autocorr(i, :) = autocorr_values(max_lag + 1:2*max_lag + 1); % Store only positive lags
end

% Plot short-term autocorrelation
figure;
imagesc(short_term_autocorr');
colormap('jet');
colorbar;
xlabel('Frame Index');
ylabel('Lag');
title('Short-Term Autocorrelation of Speech Signal');

% Display short-term autocorrelation values
figure;
plot(short_term_autocorr(1,:)); % Plot the autocorrelation values of the first frame
xlabel('Lag');
ylabel('Autocorrelation Value');
title('Short-Term Autocorrelation of First Frame');
