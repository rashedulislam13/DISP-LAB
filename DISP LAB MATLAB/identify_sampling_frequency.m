% Load the speech signal
[speech_signal, sampling_frequency] = audioread('sample.wav');

% Identify sampling frequency
fprintf('Sampling Frequency: %d Hz\n', sampling_frequency);

% Identify bit resolution
info = audioinfo('sample.wav');
bit_resolution = info.BitsPerSample;
fprintf('Bit Resolution: %d bits\n', bit_resolution);

% Downsampling the frequency
downsampled_signal = downsample(speech_signal, 2); % Downsampling by a factor of 2

% Save the downsampled signal
downsampled_sampling_frequency = sampling_frequency / 2;
audiowrite('downsampled_signal.wav', downsampled_signal, downsampled_sampling_frequency);

disp('Downsampled signal saved as downsampled_signal.wav');
