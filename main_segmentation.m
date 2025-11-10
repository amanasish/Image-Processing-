clc; clear; close all;

% --- PATH SETUP ---
inputDir = '../data/input_images/';
outputDir = '../data/output_masks/';

if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% --- LOAD IMAGES ---
imageFiles = [dir(fullfile(inputDir, '*.jpg'));
              dir(fullfile(inputDir, '*.png'));
              dir(fullfile(inputDir, '*.jpeg'))];
numImages = length(imageFiles);

if numImages == 0
    error('?? No images found in %s', inputDir);
end

% --- Randomly Select Images (change number as desired) ---
numToShow = min(6, numImages);
randIdx = randperm(numImages, numToShow);

% --- Create Figure Window ---
figure('Name', 'Original vs Segmented Results', 'NumberTitle', 'off');
set(gcf, 'Position', [50 50 1400 800]);

for i = 1:numToShow
    idx = randIdx(i);
    imgName = imageFiles(idx).name;
    imgPath = fullfile(inputDir, imgName);
    I = imread(imgPath);

    fprintf('Processing %s...\n', imgName);

    % --- PREPROCESSING ---
    I_prep = preprocessImage(I);

    % --- SEGMENTATION ---
    mask = segmentImage(I_prep);

    % --- POSTPROCESSING ---
    mask_clean = postprocessMask(mask);

    % --- SAVE MASK ---
    outPath = fullfile(outputDir, ['mask_' imgName]);
    imwrite(mask_clean, outPath);

    % --- SUBPLOT LAYOUT ---
    % Each image gets 2 panels: original + result
    subplot(numToShow, 2, 2*i-1);
    imshow(I);
    title(sprintf('Original: %s', imgName), 'Interpreter', 'none', 'FontSize', 9);

    subplot(numToShow, 2, 2*i);
    visualizeResults_single(I, mask_clean);
    title('Segmented Output', 'FontSize', 9);
end
