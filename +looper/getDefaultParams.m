function params = getDefaultParams
% Default parameters for LOOPER, both functional interface and GUI.
% This is the place to change any defaults.

%%% Preprocessing %%%

% Whether to z-score each channel of the raw data (across all time) before delay embedding
params.PreprocessData.ZScore = false;

% Standard deviation of Gaussian kernel to use for smoothing raw data (in samples)
params.PreprocessData.Smoothing = 0;

% Samples to delay data for each iteration of delay embedding
params.PreprocessData.DelayTime = 0;

% Number of delayed versions of the data to include
params.PreprocessData.DelayCount = 0;

% If inputs/outputs are provided, they are rescaled by these factors (respectively)
% relative to the scale of the data. Specifically, the norm over channels of the
% center 90% of samples (95th quantile - 5th quantile) of the inputs is
% inputLambda times that of the data (activity), and similarly for the outputs.
params.PreprocessData.InputLambda = 1;
params.PreprocessData.OutputLambda = 1;

%%% Diffusion map %%%

% How many neighbors (closest in state space that are separated in time by at least the minimum
% return time) to use to define local neighborhoods for the diffusion map
params.NearestNeighbors = 6;

% Whether to rescale (spherize) position and velocity based on local anisotropy before computing
% local neighborhoods
params.UseLocalDimensions = false;

% When identifying local neighborhoods, the minimum number of timesteps required
% between neighbors, to ensure that the system leaves the neighborhood and then returns to it.
params.MinimumReturnTime = 10;

% When simulating the time evolution of the system, exponentiate the normalized diffusion map
% (Markov matrix) until at least this fraction of elements in some row are nonzero:
params.RepopulateDensity = 0.95;

%%% Model reduction %%%

% When computing the KL divergence of evolved states using original and reduced matrices,
% step forward from 1 to this many time steps, forward from each trial time.
params.MaxCheckTime = 5;

end

