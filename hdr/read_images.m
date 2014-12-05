% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% read_images() is a helper function which reads in all of the images and exposure times from a 
% given directory.
% @param directory is the name of the directory to access.  This name is relative to the input 
% directory and should NOT include a trailing slash.  i.e. 'foo' will access directory 'input/foo/'
% @param extension (optional) specifies the extension to match for the images.  If not provided, 
% the default extension used is 'jpg'
% @return images, a cell array containing the images which have been read in
% @return exposure_times, a matrix containing the exposure times for those images
function [images, exposure_times] = read_images(directory, extension)
    % If extension is not provided, use default extension of jpg.
    if (~exist('extension'))
        extension = 'jpg';
    end

    % Grab the files from the directory, and initialize cell arrays for storage.
    files = dir(['input/' directory '/*.' extension]);
    num_files = numel(files);
    images = cell(num_files, 1);
    exposure_times = zeros(num_files, 1);

    % Read in images and associated exposure times.
    fprintf('== Reading %s images from directory input/%s ==\n', extension, directory);
    for i = 1:num_files
        curr_img_file = ['input/' directory '/' files(i).name];
        fprintf('Reading image %s\n', curr_img_file);
        curr_img_info = imfinfo(curr_img_file);
        images{i} = imread(curr_img_file);
        exposure_times(i) = curr_img_info.DigitalCamera.ExposureTime;
    end
end