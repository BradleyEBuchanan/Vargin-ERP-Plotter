function VarginPlotMulti(variables, File1, File2, File3, File4,  electrodes, Legend1, Legend2, Legend3, Legend4, patch_range, Samp, baseline)
    % Plot2ERP - Function to plot ERP data for two specified .set files
    % Inputs:
      % variables   -The amount of variables on the plot (Currently 2-4)
      % File1       - Name of the first .set file (e.g., 'Dataset1.set')
      % File2       - Name of the second .set file (e.g., 'Dataset2.set')
      % File3       - Name of the second .set file (e.g., 'Dataset3.set')
      % File4       - Name of the second .set file (e.g., 'Dataset4.set')
      % electrodes  - Vector of electrode indices to average (e.g., [54, 55, 61, 62])
      % Legend1     - Legend title for the first group (string)
      % Legend2     - Legend title for the second group (string)
      % patch_range - Time range for shaded patch [start_time, end_time]
      % Samp        - Sample rate for dynamic x-axis range adjustment
      % baseline    - Baseline shift in timepoints. Default is -250.
      % Note if variable is less than 4 File and Legend inputs must be "[]"

if variables == 1
    File2 = [];
    File3 = [];
    File4 = [];
    Legend2 = [];
    Legend3 = [];
    Legend4 = [];

    % Get the current working directory
    currentDir = pwd;

    % Construct full file paths
    File1Path = fullfile(currentDir, File1);

    % Check if the files exist in the current directory
    if ~isfile(File1Path)
        error('File "%s" not found in the current directory: %s', File1, currentDir);
    end

    % Load the EEG data
    fprintf('Loading data from %s...\n', File1Path);
    EEG1 = pop_loadset(File1Path);

    % Define the time axis based on the EEG data and Samp value
    dt = 1000/Samp;
    if ~mod(1000,Samp)
        dt = 1000/Samp;
    else
        error('Invalid sample rate.', Samp);
    end
    tps = 1:dt:(size(EEG1.data,2)*dt);

    % Check if baseline is provided, if not set it to zero
    if nargin < 13
        baseline = -201;  % Default value for baseline is 0
    else baseline = baseline-1;
    end

    % Apply the baseline shift to the x-axis
    x = tps + baseline;  % Shift the x-axis by the specified baseline value

    % Plot data from File1
    plot(x, mean(EEG1.data(electrodes, :, :), [1, 3]), 'Color', [0 0 1], 'LineStyle', '-', 'LineWidth', 2);
    hold on;

    % Add shaded patch for the user-defined range
    yLimits = ylim; % Get current y-axis limits
    patch([patch_range(1), patch_range(2), patch_range(2), patch_range(1)], ...
        [yLimits(1), yLimits(1), yLimits(2), yLimits(2)], ...
        [0.8 0.8 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Add labels and customize font sizes
    xlabel('Time (ms)', 'FontSize', 20); % Larger x-axis label
    ylabel('Amplitude (µV)', 'FontSize', 20, 'FontName', 'Times New Roman'); % Larger y-axis label
    set(gca, 'FontSize', 20,'FontName', 'Times New Roman'); % Adjust font size for axis ticks

    % Add legend
    legend(Legend1, 'FontSize', 20, 'FontName','Times New Roman');

    hold off;
    
    elseif variables == 2
    File3 = [];
    File4 = [];
    Legend3 = [];
    Legend4 = [];

    % Get the current working directory
    currentDir = pwd;

    % Construct full file paths
    File1Path = fullfile(currentDir, File1);
    File2Path = fullfile(currentDir, File2);

    % Check if the files exist in the current directory
    if ~isfile(File1Path)
        error('File "%s" not found in the current directory: %s', File1, currentDir);
    end
    if ~isfile(File2Path)
        error('File "%s" not found in the current directory: %s', File2, currentDir);
    end

    % Load the EEG data
    fprintf('Loading data from %s...\n', File1Path);
    EEG1 = pop_loadset(File1Path);
    fprintf('Loading data from %s...\n', File2Path);
    EEG2 = pop_loadset(File2Path);

    % Define the time axis based on the EEG data and Samp value
    dt = 1000/Samp;
    if ~mod(1000,Samp)
        dt = 1000/Samp;
    else
        error('Invalid sample rate.', Samp);
    end
    tps = 1:dt:(size(EEG1.data,2)*dt);

    % Check if baseline is provided, if not set it to zero
    if nargin < 13
        baseline = -201;  % Default value for baseline is 0
    else baseline = baseline-1;
    end

    % Apply the baseline shift to the x-axis
    x = tps + baseline;  % Shift the x-axis by the specified baseline value

    % Plot data from File1
    plot(x, mean(EEG1.data(electrodes, :, :), [1, 3]), 'Color', [0 0 1], 'LineStyle', '-', 'LineWidth', 2);
    hold on;

    % Plot data from File2
    plot(x, mean(EEG2.data(electrodes, :, :), [1, 3]), 'Color', [1 0 0], 'LineStyle', '-', 'LineWidth', 2);

    % Add shaded patch for the user-defined range
    yLimits = ylim; % Get current y-axis limits
    patch([patch_range(1), patch_range(2), patch_range(2), patch_range(1)], ...
        [yLimits(1), yLimits(1), yLimits(2), yLimits(2)], ...
        [0.8 0.8 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Add labels and customize font sizes
    xlabel('Time (ms)', 'FontSize', 20); % Larger x-axis label
    ylabel('Amplitude (µV)', 'FontSize', 20, 'FontName', 'Times New Roman'); % Larger y-axis label
    set(gca, 'FontSize', 20,'FontName', 'Times New Roman'); % Adjust font size for axis ticks

    % Add legend
    legend(Legend1, Legend2, 'FontSize', 20, 'FontName','Times New Roman');

    hold off;

    elseif variables == 3
    File4 = [];
    Legend4 = [];

    % Get the current working directory
    currentDir = pwd;

    % Construct full file paths
    File1Path = fullfile(currentDir, File1);
    File2Path = fullfile(currentDir, File2);
    File3Path = fullfile(currentDir, File3);
    % Check if the files exist in the current directory
    if ~isfile(File1Path)
        error('File "%s" not found in the current directory: %s', File1, currentDir);
    end
    if ~isfile(File2Path)
        error('File "%s" not found in the current directory: %s', File2, currentDir);
    end
    if ~isfile(File3Path)
        error('File "%s" not found in the current directory: %s', File3, currentDir);
    end

    % Load the EEG data
    fprintf('Loading data from %s...\n', File1Path);
    EEG1 = pop_loadset(File1Path);
    fprintf('Loading data from %s...\n', File2Path);
    EEG2 = pop_loadset(File2Path);
    fprintf('Loading data from %s...\n', File3Path);
    EEG3 = pop_loadset(File3Path);

    % Define the time axis based on the EEG data and Samp value
    dt = 1000/Samp;
    if ~mod(1000,Samp)
        dt = 1000/Samp;
    else
        error('Invalid sample rate.', Samp);
    end
    tps = 1:dt:(size(EEG1.data,2)*dt);

    % Check if baseline is provided, if not set it to zero
    if nargin < 13
        baseline = -201;  % Default value for baseline is 0
    else baseline = baseline-1;
    end

    % Apply the baseline shift to the x-axis
    x = tps + baseline;  % Shift the x-axis by the specified baseline value

    % Plot data from File1
    plot(x, mean(EEG1.data(electrodes, :, :), [1, 3]), 'Color', [0 0 1], 'LineStyle', '-', 'LineWidth', 2);
    hold on;

    % Plot data from File2
    plot(x, mean(EEG2.data(electrodes, :, :), [1, 3]), 'Color', [1 0 0], 'LineStyle', '-', 'LineWidth', 2);


    % Plot data from File2
    plot(x, mean(EEG3.data(electrodes, :, :), [1, 3]), 'Color', [0 1 0], 'LineStyle', '-', 'LineWidth', 2);

    % Add shaded patch for the user-defined range
    yLimits = ylim; % Get current y-axis limits
    patch([patch_range(1), patch_range(2), patch_range(2), patch_range(1)], ...
        [yLimits(1), yLimits(1), yLimits(2), yLimits(2)], ...
        [0.8 0.8 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Add labels and customize font sizes
    xlabel('Time (ms)', 'FontSize', 20); % Larger x-axis label
    ylabel('Amplitude (µV)', 'FontSize', 20, 'FontName', 'Times New Roman'); % Larger y-axis label
    set(gca, 'FontSize', 20,'FontName', 'Times New Roman'); % Adjust font size for axis ticks

    % Add legend
    legend(Legend1, Legend2, Legend3, 'FontSize', 20, 'FontName','Times New Roman');

    hold off;
    
elseif variables == 4

     % Get the current working directory
    currentDir = pwd;

    % Construct full file paths
    File1Path = fullfile(currentDir, File1);
    File2Path = fullfile(currentDir, File2);
    File3Path = fullfile(currentDir, File3);
    File4Path = fullfile(currentDir, File4);

    % Check if the files exist in the current directory
    if ~isfile(File1Path)
        error('File "%s" not found in the current directory: %s', File1, currentDir);
    end
    if ~isfile(File2Path)
        error('File "%s" not found in the current directory: %s', File2, currentDir);
    end
    if ~isfile(File3Path)
        error('File "%s" not found in the current directory: %s', File3, currentDir);
    end
    if ~isfile(File4Path)
        error('File "%s" not found in the current directory: %s', File4, currentDir);
    end

    % Load the EEG data
    fprintf('Loading data from %s...\n', File1Path);
    EEG1 = pop_loadset(File1Path);
    fprintf('Loading data from %s...\n', File2Path);
    EEG2 = pop_loadset(File2Path);
    fprintf('Loading data from %s...\n', File3Path);
    EEG3 = pop_loadset(File3Path);
    fprintf('Loading data from %s...\n', File4Path);
    EEG4 = pop_loadset(File4Path);

    % Define the time axis based on the EEG data and Samp value
    dt = 1000/Samp;
    if ~mod(1000,Samp)
        dt = 1000/Samp;
    else
        error('Invalid sample rate.', Samp);
    end
    tps = 1:dt:(size(EEG1.data,2)*dt);

    % Check if baseline is provided, if not set it to zero
    if nargin < 13
        baseline = -201;  % Default value for baseline is 0
    else baseline = baseline-1;
    end

    % Apply the baseline shift to the x-axis
    x = tps + baseline;  % Shift the x-axis by the specified baseline value

    % Plot data from File1
    plot(x, mean(EEG1.data(electrodes, :, :), [1, 3]), 'Color', [0 0 1], 'LineStyle', '-', 'LineWidth', 2);
    hold on;

    % Plot data from File2
    plot(x, mean(EEG2.data(electrodes, :, :), [1, 3]), 'Color', [1 0 0], 'LineStyle', '-', 'LineWidth', 2);


    % Plot data from File3
    plot(x, mean(EEG3.data(electrodes, :, :), [1, 3]), 'Color', [0 1 0], 'LineStyle', '-', 'LineWidth', 2);

    % Plot data from File4
    plot(x, mean(EEG4.data(electrodes, :, :), [1, 3]), 'Color', [0 1 1], 'LineStyle', '-', 'LineWidth', 2);

    % Add shaded patch for the user-defined range
    yLimits = ylim; % Get current y-axis limits
    patch([patch_range(1), patch_range(2), patch_range(2), patch_range(1)], ...
        [yLimits(1), yLimits(1), yLimits(2), yLimits(2)], ...
        [0.8 0.8 0.8], 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Add labels and customize font sizes
    xlabel('Time (ms)', 'FontSize', 20); % Larger x-axis label
    ylabel('Amplitude (µV)', 'FontSize', 20, 'FontName', 'Times New Roman'); % Larger y-axis label
    set(gca, 'FontSize', 20,'FontName', 'Times New Roman'); % Adjust font size for axis ticks

    % Add legend
    legend(Legend1, Legend2, Legend3, Legend4, 'FontSize', 20, 'FontName','Times New Roman');

    hold off;
end