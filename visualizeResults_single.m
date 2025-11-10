function visualizeResults_single(original, mask)
    % Resize mask to match image
    mask = imresize(mask, [size(original,1), size(original,2)]);
    original = im2double(original);
    mask = im2double(mask);

    % Create red overlay
    overlay = original;
    overlay(:,:,1) = original(:,:,1) + 0.6 * mask;
    overlay(:,:,2) = original(:,:,2) .* (1 - 0.4 * mask);
    overlay(:,:,3) = original(:,:,3) .* (1 - 0.4 * mask);
    overlay(overlay > 1) = 1;

    imshow(overlay);
end
