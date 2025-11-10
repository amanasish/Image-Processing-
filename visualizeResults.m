function visualizeResults_single(original, mask)
    % Resize mask to match image size
    mask = imresize(mask, [size(original,1), size(original,2)]);

    % Convert to double for blending
    original = im2double(original);
    mask = im2double(mask);

    % Create red overlay manually (highlight segmented region)
    overlay = original;
    overlay(:,:,1) = original(:,:,1) + 0.6 * mask; % increase red
    overlay(:,:,2) = original(:,:,2) .* (1 - 0.4 * mask); % reduce green
    overlay(:,:,3) = original(:,:,3) .* (1 - 0.4 * mask); % reduce blue
    overlay(overlay > 1) = 1;

    % Show overlay directly
    imshow(overlay);
end
