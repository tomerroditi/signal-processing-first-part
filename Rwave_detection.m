function af2 = Rwave_detection(signal)
% this function implement the AF2 algorithm from the paper, and a
% correlation test between the candidates QRS sections found by the AF2
% algorithm and QRS sections and not QRS sections.

% reshape the vector signal if needed
if size(signal,1) ~= 1
    signal = signal.';
end

% filter the signal to denoise it and solve the base line wander problem
filtered_signal = filter_my_signal(signal);

% implement AF2 algorithm with different constants to be more accurate on
% the provided signals
threshold = 0.3*max(filtered_signal);               % compute threshold 
signal_1 = abs(filtered_signal);                    % get abs values   
signal_1(signal_1 < threshold) = threshold;         % clipp the signal
deriv_1 = signal_1(2:end) - signal_1(1:end - 1);    % first derivative
indx = find(deriv_1 > 0);    % ###### we changed the derivitive threshold here to be 0 instead of 5 ######

af2 = zeros(1,length(indx));                        % set af2 size in advanced to save computational time
half_window = 60;
for i = 1:length(indx) - 1
    if indx(i) - indx(i + 1) == -1
        continue
    end
    if indx(i) + half_window >= length(filtered_signal) || indx(i) - half_window <= 1  % ##### we added the second condition here ######
        continue
    end
    % perform correlation tests
     [qrs_corr , not_qrs_corr] = corr_qrs_window(signal(indx(i) - half_window:indx(i) + half_window));
     if qrs_corr > not_qrs_corr && qrs_corr > 0.85
         [~,ind] = max(signal(indx(i) - half_window:indx(i) + half_window));
         ind = ind + indx(i) - half_window - 1;
         af2(1,i) = ind;
     end
end

af2 = af2(1, af2 ~= 0);     % drop any unused indices in af2 vector
af2 = unique(af2);          % drop any repetitive indices

end



