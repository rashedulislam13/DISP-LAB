% Load the speech signal
[speech_signal, sampling_frequency] = audioread('sample.wav');

% Define window size and overlap
window_size = 0.02 * sampling_frequency;  % 20 ms window size
overlap = 0.5 * window_size;              % 50% overlap

% Compute the zero crossing rate (ZCR) using different window functions
window_functions = {@rectwin, @hamming, @hann, @blackman};
num_window_functions = length(window_functions);
zcr_values = zeros(num_window_functions, 1);

% Compute ZCR for each window function
for i = 1:num_window_functions
    % Apply the current window function
    window = window_functions{i}(window_size);
    
    % Compute the ZCR for the entire signal using the current window function
    zcr_values(i) = zerocrossingrate(speech_signal, window, overlap);
end

% Display ZCR values
disp('Zero Crossing Rate (ZCR) using different window functions:');
for i = 1:num_window_functions
    fprintf('%s window function: %.2f\n', func2str(window_functions{i}), zcr_values(i));
end

% Function to compute zero crossing rate (ZCR) for the entire signal
function avg_zcr = zerocrossingrate(signal, window, overlap)
    frame_length = length(window);
    step_size = frame_length - overlap;
    num_frames = floor((length(signal) - overlap) / step_size);
    padded_signal_length = frame_length + (num_frames - 1) * step_size;
    padded_signal = [signal; zeros(padded_signal_length - length(signal), 1)];
    zcr = zeros(num_frames, 1);
    
    for i = 1:num_frames
        start_index = (i - 1) * step_size + 1;
        end_index = start_index + frame_length - 1;
        frame = padded_signal(start_index:end_index);
        zcr(i) = sum(abs(diff(frame > 0))) / (2 * frame_length);
    end
    
    % Compute average ZCR across all frames
    avg_zcr = mean(zcr);
end
