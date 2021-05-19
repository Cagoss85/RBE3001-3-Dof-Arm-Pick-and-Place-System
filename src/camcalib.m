% Camera Calibration Script
% Most of this script is generated, but a few things were modified to make it 
% nicer to run. For example, a DEBUG flag was added so the script will not
% generate figures unless absolutely needed!


if exist('DEBUG', 'var') ~= 1
    DEBUG = false;
end

% Define images to process
% Note: This WILL be different, make sure you replace these with your pictures before
imageFileNames = {'/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image25.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image34.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image41.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image45.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image48.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image67.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image68.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image69.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image74.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image89.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image92.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image99.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image100.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image101.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image102.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image109.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image114.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image126.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image131.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image132.png',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 25;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

if DEBUG
    
    % View reprojection errors
    h1=figure; showReprojectionErrors(cameraParams);

    % Visualize pattern locations
    h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

    % Display parameter estimation errors
    displayErrors(estimationErrors, cameraParams);
    
end
