% Auto-generated by cameraCalibrator app on 06-Mar-2021
%-------------------------------------------------------


% Define images to process
imageFileNames = {'/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image100.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image101.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image102.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image109.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image11.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image114.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image126.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image131.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image132.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image21.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image22.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image24.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image25.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image33.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image34.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image36.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image41.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image42.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image45.png',...
    '/home/cagoss85/RBE3001Code09/camera_calibration/casey_calib_pics/Image48.png',...
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
    'EstimateSkew', true, 'EstimateTangentialDistortion', true, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
