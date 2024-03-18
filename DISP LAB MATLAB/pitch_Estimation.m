function pitch = estimate_pitch(signal, fs)
    % Get the autocorrelation of the signal
    autocorr = xcorr(signal);

    % Get the fundamental frequency (pitch) using the autocorrelation
    [~, fundamental_freq] = max(autocorr);

    pitch = fs / fundamental_freq;
end

% Load the speech signal using wavread
[signal, fs] = audioread('sample.wav');

% Estimate the pitch
pitch = estimate_pitch(signal, fs);

fprintf('Estimated fundamental frequency (pitch): %.2f Hz\n', pitch);
