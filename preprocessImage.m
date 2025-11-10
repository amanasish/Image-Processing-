function I_out = preprocessImage(I)
    % Resize for uniform processing
    I_out = imresize(I, [256 256]);

    % Convert to double precision
    I_out = im2double(I_out);

    % --- Gaussian Smoothing (compatible with R2013b) ---
    % Create a Gaussian filter manually using fspecial
    h = fspecial('gaussian', [5 5], 1); % 5x5 kernel, sigma=1
    I_out = imfilter(I_out, h, 'replicate');
end
