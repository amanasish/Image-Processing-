clc; clear; close all;

% Step 1: Read and preprocess image
I = imread('cameraman.tif');   % Replace with any grayscale image
I = im2uint8(I);               % Ensure 8-bit grayscale
figure, imshow(I), title('Original Image');

% ==========================================================
% ? PART 1: Run-Length Encoding (RLE)
% ==========================================================

% Step 2: Convert image to 1D vector
I_vector = I(:);

% Step 3: Perform Run-Length Encoding
rle_encoded = [];
count = 1;

for i = 2:length(I_vector)
    if I_vector(i) == I_vector(i-1)
        count = count + 1;
    else
        rle_encoded = [rle_encoded; I_vector(i-1), count];
        count = 1;
    end
end
% Append the last run
rle_encoded = [rle_encoded; I_vector(end), count];

% Step 4: Decode RLE
rle_decoded = [];
for i = 1:size(rle_encoded,1)
    rle_decoded = [rle_decoded; repmat(rle_encoded(i,1), rle_encoded(i,2), 1)];
end

% Reshape decoded data to original image
I_rle_decoded = reshape(rle_decoded, size(I));

% Step 5: Display and compare
figure;
subplot(1,2,1), imshow(I, []), title('Original Image');
subplot(1,2,2), imshow(I_rle_decoded, []), title('RLE Decoded Image');

% Compression ratio
rle_bits_original = numel(I_vector) * 8;
rle_bits_encoded = size(rle_encoded,1) * (8 + 16); % pixel value + count (assume 16-bit)
rle_ratio = rle_bits_original / rle_bits_encoded;
fprintf('RLE Compression Ratio = %.2f\n', rle_ratio);

% ==========================================================
% ? PART 2: Huffman Encoding
% ==========================================================

% Step 6: Compute histogram and probability
symbols = unique(I_vector);
counts = histcounts(I_vector, [symbols; max(symbols)+1]);
prob = counts / sum(counts);

% Step 7: Create Huffman dictionary
dict = huffmandict(num2cell(symbols), prob);

% Step 8: Encode image using Huffman
huff_encoded = huffmanenco(num2cell(I_vector), dict);

% Step 9: Decode Huffman data
huff_decoded = huffmandeco(huff_encoded, dict);
I_huff_decoded = reshape(cell2mat(huff_decoded), size(I));

% Step 10: Display and compare
figure;
subplot(1,2,1), imshow(I, []), title('Original Image');
subplot(1,2,2), imshow(I_huff_decoded, []), title('Huffman Decoded Image');

% Compression ratio (approximation)
original_bits = numel(I_vector) * 8;
compressed_bits = length(huff_encoded);
huff_ratio = original_bits / compressed_bits;
fprintf('Huffman Compression Ratio = %.2f\n', huff_ratio);
