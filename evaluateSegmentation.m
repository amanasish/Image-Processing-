function [accuracy, diceScore] = evaluateSegmentation(predMask, trueMask)
    predMask = logical(predMask);
    trueMask = logical(trueMask);

    intersection = sum(predMask(:) & trueMask(:));
    union = sum(predMask(:) | trueMask(:));
    accuracy = intersection / union;

    diceScore = 2 * intersection / (sum(predMask(:)) + sum(trueMask(:)));
end
