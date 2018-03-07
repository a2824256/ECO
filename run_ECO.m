
% This demo script runs the ECO tracker with deep features on the
% included "Crossing" video.

% Add paths
function results=run_LCSVM(subS, res_path, bSaveImage)
setup_paths();

% Load video information
video_path = subS.path;
disp(video_path);
[seq, ground_truth] = load_video_info(video_path);


% Run ECO!
results = testing_ECO(seq);