function [params, preprocessParams] = getDefaultParams
% Default parameters for LOOPER, both functional interface and GUI.
% This is the place to change any defaults.

%%% Preprocessing %%%

% Whether to z-score each channel of the raw data (across all time) before delay embedding
preprocessParams.ZScore = false;

% Standard deviation of Gaussian kernel to use for smoothing raw data (in samples)
preprocessParams.Smoothing = 0;

% Samples to delay data for each iteration of delay embedding
preprocessParams.DelayTime = 0;

% Number of delayed versions of the data to include
preprocessParams.DelayCount = 0;

% If inputs/outputs are provided, they are rescaled by these factors (respectively)
% relative to the scale of the data. Specifically, the norm over channels of the
% center 90% of samples (95th quantile - 5th quantile) of the inputs is
% inputLambda times that of the data (activity), and similarly for the outputs.
preprocessParams.InputLambda = 1;
preprocessParams.OutputLambda = 1;

% Parameters hidden in UI
preprocessParams.TrialLambda = 1;
preprocessParams.MergeStarts = false;
preprocessParams.MergeEnds = false;

%%% Diffusion map %%%

% How many neighbors (closest in state space that are separated in time by at least the minimum
% return time) to use to define local neighborhoods for the diffusion map
params.NearestNeighbors = 6;

% Whether to rescale (spherize) position and velocity based on local anisotropy before computing
% local neighborhoods
params.UseLocalDimensions = false;

% When simulating the time evolution of the system, exponentiate the normalized diffusion map
% (Markov matrix) until at least this fraction of elements in some row are nonzero:
params.RepopulateDensity = 0.95;

% When identifying local neighborhoods, the minimum number of timesteps required
% between neighbors, to ensure that the system leaves the neighborhood and then returns to it.
params.MinimumReturnTime = 10;

%%% Model reduction %%%

% Numbers of states (C) to try when reducing the diffusion map - will be compared using MDL
params.PutativeClusterCounts = [100, 80, 60, 50, 40, 30, 20, 17, 15, 12, 10, 8];

% Measure to use to compute similarity between rows of the diffusion map matrix (2nd input to pdist)
% This similarity matrix is then used to hierarchically cluster and merge the states.
params.DistanceType = 'correlation';

% When computing the KL divergence of evolved states using original and reduced matrices,
% step forward from 1 to this many time steps, forward from each trial time.
params.MaxCheckTime = 5;

%%% Find loops %%%

% Numbers of loop (clusters) to try to account for the complete dynamics
params.PutativeLoopCounts = [5, 4, 3, 2];

% "Target state count" - what does this do??
params.TotalStates = 100;

% Whether to use a dummy "terminal state" to connect each trial's end to each next trial's start
params.UseTerminalState = false;



end
