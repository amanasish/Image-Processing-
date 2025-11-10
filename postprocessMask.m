function mask_clean = postprocessMask(mask)
    % Fill holes
    mask_clean = imfill(mask, 'holes');

    % Remove small objects
    mask_clean = bwareaopen(mask_clean, 100);

    % Optional smoothing
    se = strel('disk', 3);
    mask_clean = imclose(mask_clean, se);
end
