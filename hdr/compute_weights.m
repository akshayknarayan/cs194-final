% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% compute_weights() is a helper function which computes the weights needed in the algorithm for each 
% of the intensity values.  As of now, we've implemented the triangle function specified in the 
% paper.
% @return weights is a 1x256 vector with the corresponding weight for the intensity.
function weights = compute_weights()
    weights = 1:256;
    weights = min(weights, 256 - weights + 1);  % TODO Added one here to make sure we don't end up with zero weights.  Check if this is needed.
end